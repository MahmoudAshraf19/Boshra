import 'dart:async';
import 'dart:math' as math;
import 'dart:ui' show PathOperation;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/prayer/data/models/prayer_times_model.dart';

enum Season { none, winter, spring, summer, autumn }

/// The sky above the user's city RIGHT NOW, driven by the real prayer/sun times of the
/// location (Fajr, sunrise, Dhuhr, Asr, sunset, Isha) and the season of the hemisphere.
class SkyState {
  final Color top;
  final Color mid;
  final Color bottom;
  final double? sunT; // 0..1 along the day arc (null at night)
  final double? moonT; // 0..1 along the night arc (null by day)
  final double stars; // 0..1
  final Season season;
  const SkyState(this.top, this.mid, this.bottom, this.sunT, this.moonT, this.stars, this.season);
}

class SkyTheme {
  SkyTheme._();

  static const _prefKey = 'living_theme';

  /// User switch (More → Living theme). Default ON.
  static final ValueNotifier<bool> enabled = ValueNotifier<bool>(true);
  static bool _loaded = false;

  static Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    final p = await SharedPreferences.getInstance();
    enabled.value = p.getBool(_prefKey) ?? true;
  }

  static Future<void> setEnabled(bool v) async {
    enabled.value = v;
    final p = await SharedPreferences.getInstance();
    await p.setBool(_prefKey, v);
  }

  static DateTime? _parse(String raw, DateTime day) {
    final m = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
    if (m == null) return null;
    return DateTime(day.year, day.month, day.day, int.parse(m.group(1)!), int.parse(m.group(2)!));
  }

  static Season seasonFor(DateTime d, double lat) {
    if (lat.abs() < 12) return Season.none; // near the equator there is no real winter/summer
    var m = d.month;
    if (lat < 0) m = (m + 5) % 12 + 1; // southern hemisphere: shift by 6 months
    if (m == 12 || m <= 2) return Season.winter;
    if (m <= 5) return Season.spring;
    if (m <= 8) return Season.summer;
    return Season.autumn;
  }

  static const _night = [Color(0xFF0B1026), Color(0xFF141B3A), Color(0xFF1D2A4D)];
  static const _dawn = [Color(0xFF1B2250), Color(0xFF3A3F7A), Color(0xFF8A6FA8)];
  static const _sunrise = [Color(0xFF3B4C8C), Color(0xFFE0866B), Color(0xFFF4C27A)];
  static const _morning = [Color(0xFF2F7FB8), Color(0xFF62B0D9), Color(0xFFBFE3F2)];
  static const _noon = [Color(0xFF2A86C5), Color(0xFF5BB5E0), Color(0xFFA9DCF0)];
  static const _afternoon = [Color(0xFF3B7FB0), Color(0xFF79B4C9), Color(0xFFE8D9A8)];
  static const _sunset = [Color(0xFF3A3A78), Color(0xFFD9603B), Color(0xFFF2A65A)];
  static const _dusk = [Color(0xFF1A1F4D), Color(0xFF4A3A78), Color(0xFF8A5A8A)];

  static double _c01(double v) => v < 0 ? 0.0 : (v > 1 ? 1.0 : v);

  static List<Color> _lerp3(List<Color> a, List<Color> b, double t) =>
      [for (var i = 0; i < 3; i++) Color.lerp(a[i], b[i], t)!];

  /// [t] = today's times from the prayer model (already for the user's location).
  static SkyState compute(DateTime now, Timings t, double lat) {
    final fajr = _parse(t.fajr, now);
    final sunrise = _parse(t.sunrise, now);
    final dhuhr = _parse(t.dhuhr, now);
    final asr = _parse(t.asr, now);
    final sunset = _parse(t.sunset.isNotEmpty ? t.sunset : t.maghrib, now);
    final isha = _parse(t.isha, now);
    final season = seasonFor(now, lat);
    if (fajr == null || sunrise == null || dhuhr == null || asr == null || sunset == null || isha == null) {
      return SkyState(_night[0], _night[1], _night[2], null, null, 0.6, season);
    }
    const day = Duration(days: 1);
    final anchors = <(DateTime, List<Color>)>[
      (isha.subtract(day).add(const Duration(minutes: 75)), _night),
      (fajr.subtract(const Duration(minutes: 45)), _night),
      (fajr, _dawn),
      (sunrise, _sunrise),
      (sunrise.add(const Duration(minutes: 100)), _morning),
      (dhuhr, _noon),
      (asr, _afternoon),
      (sunset.subtract(const Duration(minutes: 30)), _afternoon),
      (sunset, _sunset),
      (isha, _dusk),
      (isha.add(const Duration(minutes: 75)), _night),
      (fajr.add(day).subtract(const Duration(minutes: 45)), _night),
    ];
    var cols = _night;
    for (var i = 0; i < anchors.length - 1; i++) {
      final a = anchors[i], b = anchors[i + 1];
      if (!now.isBefore(a.$1) && now.isBefore(b.$1)) {
        final span = b.$1.difference(a.$1).inSeconds;
        final k = span <= 0 ? 0.0 : now.difference(a.$1).inSeconds / span;
        cols = _lerp3(a.$2, b.$2, _c01(k));
        break;
      }
    }

    // season tint
    final tint = switch (season) {
      Season.winter => const Color(0xFF8FB8E8),
      Season.spring => const Color(0xFF8BD17C),
      Season.summer => const Color(0xFFFFC857),
      Season.autumn => const Color(0xFFE0894B),
      Season.none => null,
    };
    if (tint != null) cols = [for (final c in cols) Color.lerp(c, tint, 0.14)!];

    double? sunT, moonT;
    if (!now.isBefore(sunrise) && now.isBefore(sunset)) {
      sunT = now.difference(sunrise).inSeconds / math.max(1, sunset.difference(sunrise).inSeconds);
    } else {
      final nightStart = now.isBefore(sunrise) ? sunset.subtract(day) : sunset;
      final nightEnd = now.isBefore(sunrise) ? sunrise : sunrise.add(day);
      moonT = _c01(now.difference(nightStart).inSeconds / math.max(1, nightEnd.difference(nightStart).inSeconds));
    }
    double stars = 0;
    if (now.isBefore(sunrise)) {
      stars = 1 - _c01(now.difference(fajr).inMinutes / math.max(1, sunrise.difference(fajr).inMinutes));
      if (now.isBefore(fajr)) stars = 1;
    } else if (!now.isBefore(sunset)) {
      stars = _c01(now.difference(sunset).inMinutes / math.max(1, isha.add(const Duration(minutes: 60)).difference(sunset).inMinutes));
    }
    return SkyState(cols[0], cols[1], cols[2], sunT, moonT, stars, season);
  }
}

/// Overlay for the Home header: sky gradient + sun / moon on their real arc + stars + a season mark.
/// Updates every 30 s. Sits ON TOP of the existing banner image, below the readability gradient,
/// so the header texts keep their contrast.
class SkyBackdrop extends StatefulWidget {
  final Timings timings;
  final bool dark;
  const SkyBackdrop({super.key, required this.timings, required this.dark});

  @override
  State<SkyBackdrop> createState() => _SkyBackdropState();
}

class _SkyBackdropState extends State<SkyBackdrop> {
  Timer? _timer;
  double _lat = 30;

  @override
  void initState() {
    super.initState();
    SkyTheme.load();
    SharedPreferences.getInstance().then((p) {
      final l = p.getDouble('home_loc_lat') ?? p.getDouble('last_latitude');
      if (l != null && mounted) setState(() => _lat = l);
    });
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: SkyTheme.enabled,
      builder: (context, on, _) {
        if (!on) return const SizedBox.shrink();
        final s = SkyTheme.compute(DateTime.now(), widget.timings, _lat);
        return IgnorePointer(
          child: SizedBox.expand(child: CustomPaint(painter: _SkyPainter(s, widget.dark))),
        );
      },
    );
  }
}

class _SkyPainter extends CustomPainter {
  final SkyState s;
  final bool dark;
  _SkyPainter(this.s, this.dark);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final a = dark ? 0.36 : 0.60;
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [s.top.withValues(alpha: a), s.mid.withValues(alpha: a * 0.9), s.bottom.withValues(alpha: a * 0.75)],
        ).createShader(Offset.zero & size),
    );

    // stars
    if (s.stars > 0.02) {
      final r = math.Random(11);
      final p = Paint();
      for (var i = 0; i < 46; i++) {
        final x = r.nextDouble() * w;
        final y = r.nextDouble() * h * 0.55;
        final rad = 0.5 + r.nextDouble() * 1.2;
        p.color = Colors.white.withValues(alpha: (0.35 + r.nextDouble() * 0.5) * s.stars);
        canvas.drawCircle(Offset(x, y), rad, p);
      }
    }

    // sun / moon on the real arc
    Offset arc(double t) => Offset(w * (0.12 + 0.76 * t), h * 0.47 - math.sin(math.pi * t) * h * 0.27);
    if (s.sunT != null) {
      final c = arc(s.sunT!);
      final elev = math.sin(math.pi * s.sunT!); // 0 at the horizon … 1 at noon
      final core = Color.lerp(const Color(0xFFFF8A3D), const Color(0xFFFFF3B0), elev)!;
      canvas.drawCircle(
        c,
        w * (0.16 - 0.04 * elev),
        Paint()
          ..shader = RadialGradient(colors: [core.withValues(alpha: 0.55), core.withValues(alpha: 0)])
              .createShader(Rect.fromCircle(center: c, radius: w * 0.16)),
      );
      canvas.drawCircle(c, w * 0.035, Paint()..color = core);
    } else if (s.moonT != null) {
      final c = arc(s.moonT!);
      final r = w * 0.034;
      canvas.drawCircle(
        c,
        r * 3.2,
        Paint()
          ..shader = RadialGradient(colors: [const Color(0x33F5F1E3), const Color(0x00F5F1E3)])
              .createShader(Rect.fromCircle(center: c, radius: r * 3.2)),
      );
      final moon = Path.combine(
        PathOperation.difference,
        Path()..addOval(Rect.fromCircle(center: c, radius: r)),
        Path()..addOval(Rect.fromCircle(center: c.translate(r * 0.55, -r * 0.2), radius: r * 0.9)),
      );
      canvas.drawPath(moon, Paint()..color = const Color(0xFFF5F1E3));
    }

    // season mark (top-right)
    final mark = switch (s.season) {
      Season.winter => '❄️',
      Season.spring => '🌸',
      Season.summer => '☀️',
      Season.autumn => '🍂',
      Season.none => '',
    };
    if (mark.isNotEmpty) {
      final tp = TextPainter(
        text: TextSpan(text: mark, style: const TextStyle(fontSize: 15)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(w - tp.width - 16, h * 0.10));
    }
  }

  @override
  bool shouldRepaint(_SkyPainter o) =>
      o.s.top != s.top || o.s.sunT != s.sunT || o.s.moonT != s.moonT || o.s.stars != s.stars || o.dark != dark;
}
