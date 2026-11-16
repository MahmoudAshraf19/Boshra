import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Condition of one prayer's plant on one day.
enum PlantState {
  /// Prayed — grows with the streak.
  grown,
  /// A past day without the prayer — bare, waiting for water.
  withered,
  /// Time has started and it is not marked yet — thirsty.
  pending,
  /// Not yet reached: a seed in the soil.
  upcoming,
}

/// One tree species per prayer — each with its own silhouette and colours:
///   0 Fajr   🌸 cherry blossom      1 Dhuhr 🌴 date palm       2 Asr 🍊 orange tree
///   3 Maghrib 🍁 pomegranate/maple  4 Isha  🌲 cypress of the night (with fireflies)
class Species {
  Species._();

  static const accent = [Color(0xFFF06292), Color(0xFFD4A017), Color(0xFFFB8C00), Color(0xFFD84315), Color(0xFF26A69A)];

  static String name(int i, bool ar) => (ar
      ? ['شجرة الكرز', 'النخلة', 'شجرة البرتقال', 'شجرة الرمان', 'السروة']
      : ['Cherry blossom', 'Date palm', 'Orange tree', 'Pomegranate', 'Cypress'])[i];

  static String emoji(int i) => ['🌸', '🌴', '🍊', '🍎', '🌲'][i];
}

class GardenPlant extends StatelessWidget {
  final int species;
  final double level; // 0..5 growth
  final PlantState state;
  final double size;
  final bool animate;
  final bool glow;

  const GardenPlant({
    super.key,
    required this.species,
    required this.level,
    required this.state,
    this.size = 64,
    this.animate = true,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    final target = state == PlantState.grown ? level.clamp(0.0, 5.0).toDouble() : (state == PlantState.pending ? level.clamp(0.0, 5.0).toDouble() : 0.0);
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: animate ? 0 : target, end: target),
      duration: Duration(milliseconds: animate ? 900 : 1),
      curve: Curves.easeOutBack,
      builder: (_, g, __) => SizedBox(
        width: size,
        height: size * 1.12,
        child: CustomPaint(painter: _PlantPainter(species, g, state, glow)),
      ),
    );
  }
}

class _PlantPainter extends CustomPainter {
  final int sp;
  final double g;
  final PlantState state;
  final bool glow;
  _PlantPainter(this.sp, this.g, this.state, this.glow);

  static const _trunk = Color(0xFF7A5230);
  static const _dead = Color(0xFF9A8F80);

  Color _c(Color c) => state == PlantState.withered ? Color.lerp(c, const Color(0xFF8D8576), 0.85)! : c;

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final gy = h * 0.9;
    final t = (g / 5).clamp(0.0, 1.0).toDouble();

    // soil mound
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w / 2, gy + 2), width: w * 0.66, height: h * 0.11),
      Paint()..color = const Color(0xFF6D4C41).withValues(alpha: state == PlantState.upcoming ? 0.35 : 0.6),
    );

    if (glow && state == PlantState.grown) {
      final c = Offset(w / 2, gy - h * 0.3);
      canvas.drawCircle(c, w * 0.52,
          Paint()..shader = const RadialGradient(colors: [Color(0x55FFD54F), Color(0x00FFD54F)]).createShader(Rect.fromCircle(center: c, radius: w * 0.52)));
    }

    switch (state) {
      case PlantState.upcoming:
        // a tiny seed marker
        canvas.drawCircle(Offset(w / 2, gy - 2), 2.4, Paint()..color = _trunk.withValues(alpha: 0.5));
        return;
      case PlantState.withered:
        _bare(canvas, w, h, gy);
        return;
      case PlantState.pending:
      case PlantState.grown:
        break;
    }

    if (g < 0.35) {
      canvas.drawOval(Rect.fromCenter(center: Offset(w / 2, gy - 3), width: w * 0.12, height: h * 0.07), Paint()..color = _trunk);
    } else if (g < 1.7) {
      _sprout(canvas, w, h, gy, ((g - 0.35) / 1.35).clamp(0.0, 1.0));
    } else {
      switch (sp) {
        case 0:
          _cherry(canvas, w, h, gy, t);
          break;
        case 1:
          _palm(canvas, w, h, gy, t);
          break;
        case 2:
          _orange(canvas, w, h, gy, t);
          break;
        case 3:
          _pomegranate(canvas, w, h, gy, t);
          break;
        default:
          _cypress(canvas, w, h, gy, t);
      }
    }

    if (state == PlantState.pending) {
      final c = Offset(w * 0.86, h * 0.14);
      final path = Path()
        ..moveTo(c.dx, c.dy - h * 0.09)
        ..quadraticBezierTo(c.dx + h * 0.07, c.dy, c.dx, c.dy + h * 0.05)
        ..quadraticBezierTo(c.dx - h * 0.07, c.dy, c.dx, c.dy - h * 0.09);
      canvas.drawPath(path, Paint()..color = const Color(0xFF42A5F5));
    }
  }

  // ------------------------------------------------------------------ shared bits
  void _trunkRect(Canvas c, double w, double gy, double th, double tw, {Color? color}) {
    final r = RRect.fromRectAndRadius(Rect.fromLTWH(w / 2 - tw / 2, gy - th, tw, th), Radius.circular(tw / 2));
    c.drawRRect(r, Paint()..color = _c(color ?? _trunk));
  }

  void _leaf(Canvas c, Offset b, double a, double len, Color col) {
    c.save();
    c.translate(b.dx, b.dy);
    c.rotate(a);
    final p = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(len * 0.5, -len * 0.45, 0, -len)
      ..quadraticBezierTo(-len * 0.5, -len * 0.45, 0, 0);
    c.drawPath(p, Paint()..color = _c(col));
    c.restore();
  }

  void _sprout(Canvas c, double w, double h, double gy, double k) {
    final th = h * (0.10 + 0.16 * k);
    _trunkRect(c, w, gy, th, w * 0.04, color: const Color(0xFF6B8E3A));
    final top = Offset(w / 2, gy - th);
    final col = [const Color(0xFFF48FB1), const Color(0xFF9CCC65), const Color(0xFF7CB342), const Color(0xFFE57373), const Color(0xFF4DB6AC)][sp];
    _leaf(c, top, -0.75, w * (0.10 + 0.08 * k), const Color(0xFF6BBF3B));
    _leaf(c, top, 0.75, w * (0.10 + 0.08 * k), col);
  }

  void _bare(Canvas c, double w, double h, double gy) {
    final th = h * 0.30;
    _trunkRect(c, w, gy, th, w * 0.05, color: _dead);
    final p = Paint()
      ..color = _dead
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final top = Offset(w / 2, gy - th);
    c.drawLine(top, top + Offset(-w * 0.16, -h * 0.12), p);
    c.drawLine(top, top + Offset(w * 0.15, -h * 0.10), p);
    c.drawLine(top + Offset(0, h * 0.06), top + Offset(w * 0.12, -h * 0.01), p);
    final leaf = Paint()..color = const Color(0xFFB59B6C).withValues(alpha: 0.8);
    c.drawCircle(top + Offset(-w * 0.17, -h * 0.13), 2.2, leaf);
    c.drawCircle(Offset(w * 0.36, gy - 1), 2, leaf);
    c.drawCircle(Offset(w * 0.6, gy - 2), 1.8, leaf);
  }

  // ---------------------------------------------------------------------- species
  void _cherry(Canvas c, double w, double h, double gy, double t) {
    final th = h * (0.18 + 0.30 * t);
    final tw = w * (0.045 + 0.07 * t);
    _trunkRect(c, w, gy, th, tw, color: const Color(0xFF5D4037));
    final top = Offset(w / 2, gy - th);
    final r = h * (0.08 + 0.2 * t);
    final cx = top.dx, cy = top.dy - r * 0.3;
    final pinks = [_c(const Color(0xFFF8BBD0)), _c(const Color(0xFFF48FB1)), _c(const Color(0xFFFFE0EA))];
    c.drawCircle(Offset(cx - r * 0.7, cy + r * 0.15), r * 0.7, Paint()..color = pinks[1]);
    c.drawCircle(Offset(cx + r * 0.7, cy + r * 0.15), r * 0.7, Paint()..color = pinks[1]);
    c.drawCircle(Offset(cx, cy), r, Paint()..color = pinks[0]);
    if (g >= 2.8) {
      c.drawCircle(Offset(cx - r * 0.3, cy - r * 0.5), r * 0.55, Paint()..color = pinks[2]);
      c.drawCircle(Offset(cx + r * 0.45, cy - r * 0.3), r * 0.45, Paint()..color = pinks[2]);
    }
    if (g >= 3.5) {
      // falling petals
      final p = Paint()..color = pinks[0];
      final rnd = math.Random(3);
      for (var i = 0; i < 7; i++) {
        c.drawCircle(Offset(cx + (rnd.nextDouble() - 0.5) * r * 2.6, cy + r * 0.9 + rnd.nextDouble() * (gy - cy - r)), 1.4, p);
      }
    }
  }

  void _palm(Canvas c, double w, double h, double gy, double t) {
    final th = h * (0.22 + 0.42 * t);
    final path = Path()
      ..moveTo(w / 2, gy)
      ..quadraticBezierTo(w / 2 + w * 0.10, gy - th * 0.55, w / 2 + w * 0.03, gy - th);
    c.drawPath(
      path,
      Paint()
        ..color = _c(const Color(0xFF8D6E4A))
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * (0.05 + 0.04 * t)
        ..strokeCap = StrokeCap.round,
    );
    final top = Offset(w / 2 + w * 0.03, gy - th);
    final n = g < 2.5 ? 4 : 7;
    final len = w * (0.22 + 0.20 * t);
    for (var i = 0; i < n; i++) {
      final a = -math.pi * 0.95 + (math.pi * 0.9) * (i / (n - 1));
      final end = top + Offset(math.cos(a) * len, math.sin(a) * len * 0.75 + len * 0.25);
      final ctrl = top + Offset(math.cos(a) * len * 0.5, math.sin(a) * len * 0.9 - len * 0.15);
      final p = Path()
        ..moveTo(top.dx, top.dy)
        ..quadraticBezierTo(ctrl.dx, ctrl.dy, end.dx, end.dy);
      c.drawPath(
        p,
        Paint()
          ..color = _c(i.isEven ? const Color(0xFF558B2F) : const Color(0xFF7CB342))
          ..style = PaintingStyle.stroke
          ..strokeWidth = w * 0.05
          ..strokeCap = StrokeCap.round,
      );
    }
    if (g >= 4.4) {
      final d = Paint()..color = _c(const Color(0xFFC77D1A));
      for (var i = 0; i < 4; i++) {
        c.drawCircle(top + Offset((i - 1.5) * w * 0.035, w * 0.05 + (i.isEven ? 0 : w * 0.03)), w * 0.028, d);
      }
    }
  }

  void _orange(Canvas c, double w, double h, double gy, double t) {
    final th = h * (0.14 + 0.2 * t);
    _trunkRect(c, w, gy, th, w * (0.06 + 0.07 * t));
    final r = h * (0.09 + 0.21 * t);
    final cx = w / 2, cy = gy - th - r * 0.45;
    c.drawCircle(Offset(cx, cy), r, Paint()..color = _c(const Color(0xFF2E7D32)));
    c.drawCircle(Offset(cx - r * 0.3, cy - r * 0.3), r * 0.6, Paint()..color = _c(const Color(0xFF43A047)));
    c.drawCircle(Offset(cx + r * 0.45, cy + r * 0.1), r * 0.45, Paint()..color = _c(const Color(0xFF388E3C)));
    if (g >= 3.0 && g < 4.3) {
      final bl = Paint()..color = Colors.white.withValues(alpha: 0.9);
      for (final o in [const Offset(-0.5, -0.2), const Offset(0.3, -0.5), const Offset(0.55, 0.25), const Offset(-0.15, 0.4)]) {
        c.drawCircle(Offset(cx + o.dx * r, cy + o.dy * r), 1.8, bl);
      }
    }
    if (g >= 4.3) {
      final f = Paint()..color = _c(const Color(0xFFFF9800));
      for (final o in [const Offset(-0.55, 0.0), const Offset(0.1, -0.5), const Offset(0.5, 0.2), const Offset(-0.2, 0.45), const Offset(0.62, -0.25), const Offset(-0.1, 0.05)]) {
        c.drawCircle(Offset(cx + o.dx * r, cy + o.dy * r), r * 0.13, f);
      }
    }
  }

  void _pomegranate(Canvas c, double w, double h, double gy, double t) {
    final th = h * (0.16 + 0.26 * t);
    _trunkRect(c, w, gy, th, w * (0.05 + 0.06 * t), color: const Color(0xFF6D4C41));
    final r = h * (0.08 + 0.2 * t);
    final cx = w / 2, cy = gy - th - r * 0.4;
    final cols = [_c(const Color(0xFFBF360C)), _c(const Color(0xFFE64A19)), _c(const Color(0xFFFF7043))];
    c.drawCircle(Offset(cx - r * 0.65, cy + r * 0.2), r * 0.7, Paint()..color = cols[0]);
    c.drawCircle(Offset(cx + r * 0.65, cy + r * 0.2), r * 0.7, Paint()..color = cols[0]);
    c.drawCircle(Offset(cx, cy), r, Paint()..color = cols[1]);
    c.drawCircle(Offset(cx - r * 0.25, cy - r * 0.4), r * 0.55, Paint()..color = cols[2]);
    // fallen leaves
    final lf = Paint()..color = cols[1].withValues(alpha: 0.8);
    c.drawCircle(Offset(w * 0.3, gy - 1), 2, lf);
    c.drawCircle(Offset(w * 0.68, gy - 2), 1.8, lf);
    if (g >= 4.4) {
      final f = Paint()..color = _c(const Color(0xFFB71C1C));
      for (final o in [const Offset(-0.4, 0.15), const Offset(0.35, -0.1), const Offset(0.05, 0.45)]) {
        c.drawCircle(Offset(cx + o.dx * r, cy + o.dy * r), r * 0.16, f);
        c.drawCircle(Offset(cx + o.dx * r, cy + o.dy * r - r * 0.16), r * 0.05, Paint()..color = _c(const Color(0xFFFFC107)));
      }
    }
  }

  void _cypress(Canvas c, double w, double h, double gy, double t) {
    final th = h * (0.08 + 0.1 * t);
    _trunkRect(c, w, gy, th, w * 0.05, color: const Color(0xFF4E342E));
    final bodyH = h * (0.14 + 0.52 * t);
    final bodyW = w * (0.16 + 0.20 * t);
    final cx = w / 2, base = gy - th * 0.6;
    final body = Path()
      ..moveTo(cx, base - bodyH)
      ..quadraticBezierTo(cx + bodyW, base - bodyH * 0.45, cx + bodyW * 0.75, base)
      ..lineTo(cx - bodyW * 0.75, base)
      ..quadraticBezierTo(cx - bodyW, base - bodyH * 0.45, cx, base - bodyH)
      ..close();
    c.drawPath(
      body,
      Paint()
        ..shader = LinearGradient(colors: [_c(const Color(0xFF00695C)), _c(const Color(0xFF004D40))])
            .createShader(Rect.fromLTWH(cx - bodyW, base - bodyH, bodyW * 2, bodyH)),
    );
    // lighter side
    c.drawPath(
      Path()
        ..moveTo(cx, base - bodyH)
        ..quadraticBezierTo(cx - bodyW, base - bodyH * 0.45, cx - bodyW * 0.75, base)
        ..lineTo(cx - bodyW * 0.1, base)
        ..quadraticBezierTo(cx - bodyW * 0.3, base - bodyH * 0.5, cx, base - bodyH)
        ..close(),
      Paint()..color = _c(const Color(0xFF26A69A)).withValues(alpha: 0.55),
    );
    if (g >= 3.2) {
      // fireflies
      final ff = Paint()..color = const Color(0xFFFFEE58).withValues(alpha: state == PlantState.withered ? 0 : 0.95);
      final rnd = math.Random(9);
      for (var i = 0; i < 6; i++) {
        c.drawCircle(Offset(cx + (rnd.nextDouble() - 0.5) * w * 0.8, base - rnd.nextDouble() * bodyH * 1.05), 1.3, ff);
      }
    }
  }

  @override
  bool shouldRepaint(_PlantPainter o) => o.g != g || o.state != state || o.sp != sp || o.glow != glow;
}
