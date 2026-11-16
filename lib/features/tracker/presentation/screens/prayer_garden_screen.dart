import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/sky_theme.dart';
import '../../../../core/utils/date_text.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer/data/repositories/prayer_repository.dart';
import '../../data/hijri_calendar.dart';
import '../../data/prayer_tracker.dart';
import '../widgets/garden_plants.dart';
import '../widgets/prayer_tree.dart';
import 'prayer_tracker_screen.dart';

class _Plant {
  final bool done;
  final int? markMin; // minute of the day when it was logged
  final int streak; // consecutive days up to (and including) this one
  final PlantState state;
  const _Plant(this.done, this.markMin, this.streak, this.state);
}

class _Day {
  final DateTime date;
  final int hijriDay;
  final bool isToday;
  final bool isFuture;
  final List<_Plant> plants;
  const _Day(this.date, this.hijriDay, this.isToday, this.isFuture, this.plants);
  bool get perfect => plants.every((p) => p.done);
}

/// Your personal garden — one Hijri month at a time ("Garden of Muharram 1448").
/// Every day is a plot with five plants, one species per prayer: a plant that was prayed grows
/// with your streak, a missed one stays bare, a thirsty one waits for today's prayer.
/// Tap any plant to see that prayer on that day.
class PrayerGardenScreen extends StatefulWidget {
  const PrayerGardenScreen({super.key});

  @override
  State<PrayerGardenScreen> createState() => _PrayerGardenScreenState();
}

class _PrayerGardenScreenState extends State<PrayerGardenScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _anim =
      AnimationController(vsync: this, duration: const Duration(seconds: 40))..repeat();

  int _hy = 0, _hm = 1;
  int _curY = 0, _curM = 1;
  List<_Day> _days = const [];
  List<DateTime?> _todayTimes = List.filled(5, null);
  SkyState? _sky;
  bool _loaded = false;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    await HijriCalendar.load();
    final h = HijriCalendar.fromGregorian(DateTime.now());
    _curY = h.year;
    _curM = h.month;
    _hy = h.year;
    _hm = h.month;
    await _load();
  }

  DateTime? _parse(String raw) {
    final m = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
    if (m == null) return null;
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day, int.parse(m.group(1)!), int.parse(m.group(2)!));
  }

  Future<void> _load() async {
    final map = await PrayerTracker.load();
    final marks = await PrayerTracker.loadMarkTimes();
    final model = await PrayerRepository().getTodayPrayerTimes(skipLocationFetch: true);
    if (model != null) {
      final x = model.timings;
      _todayTimes = [_parse(x.fajr), _parse(x.dhuhr), _parse(x.asr), _parse(x.maghrib), _parse(x.isha)];
      final sp = await SharedPreferences.getInstance();
      final lat = sp.getDouble('home_loc_lat') ?? sp.getDouble('last_latitude') ?? 30.0;
      _sky = SkyTheme.compute(DateTime.now(), x, lat);
    }

    final len = HijriCalendar.monthLength(_hy, _hm);
    final first = HijriCalendar.toGregorian(_hy, _hm, 1);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final streaks = List.filled(5, 0);
    final days = <_Day>[];

    // run-up of 45 days so streaks that started before this month are counted
    var dt = DateTime(first.year, first.month, first.day - 45);
    final end = DateTime(first.year, first.month, first.day + len - 1);
    while (!dt.isAfter(end)) {
      final mask = map[PrayerTracker.dayKey(dt)] ?? 0;
      final times = marks[PrayerTracker.dayKey(dt)];
      final plants = <_Plant>[];
      for (var i = 0; i < 5; i++) {
        final done = (mask >> i) & 1 == 1;
        streaks[i] = done ? streaks[i] + 1 : 0;
        final PlantState st;
        if (dt.isAfter(today)) {
          st = PlantState.upcoming;
        } else if (done) {
          st = PlantState.grown;
        } else if (dt == today) {
          final tm = _todayTimes[i];
          st = (tm == null || !tm.isAfter(now)) ? PlantState.pending : PlantState.upcoming;
        } else {
          st = PlantState.withered;
        }
        final mm = (times != null && times[i] >= 0) ? times[i] : null;
        plants.add(_Plant(done, mm, streaks[i], st));
      }
      if (!dt.isBefore(first)) {
        final hd = _hijriDayOf(dt);
        days.add(_Day(dt, hd, dt == today, dt.isAfter(today), plants));
      }
      dt = DateTime(dt.year, dt.month, dt.day + 1);
    }
    if (!mounted) return;
    setState(() {
      _days = days;
      _loaded = true;
    });
  }

  int _hijriDayOf(DateTime d) => HijriCalendar.fromGregorian(d).day;

  String _wd(DateTime d) => _ar
      ? const ['اثنين', 'ثلاثاء', 'أربعاء', 'خميس', 'جمعة', 'سبت', 'أحد'][d.weekday - 1]
      : DateText.weekday(d, false).substring(0, 3);

  void _go(int delta) {
    final (y, m) = HijriCalendar.shift(_hy, _hm, delta);
    if (y * 12 + m > _curY * 12 + _curM) return; // no future gardens
    setState(() {
      _hy = y;
      _hm = m;
      _loaded = false;
    });
    _load();
  }

  bool get _isCurrent => _hy == _curY && _hm == _curM;

  // ----------------------------------------------------------------------- stats
  int get _prayed => _days.fold<int>(0, (a, d) => a + d.plants.where((p) => p.done).length);
  int get _possible => _days.where((d) => !d.isFuture).length * 5;
  int get _perfectDays => _days.where((d) => d.perfect).length;
  int get _bestStreak {
    var best = 0, cur = 0;
    for (final d in _days) {
      cur = d.perfect ? cur + 1 : 0;
      if (cur > best) best = cur;
    }
    return best;
  }

  String _hm12(int minutes) {
    final h = minutes ~/ 60, m = minutes % 60;
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return '$h12:${m.toString().padLeft(2, '0')} ${h < 12 ? t('ص', 'AM') : t('م', 'PM')}';
  }

  // ------------------------------------------------------------------- bottom sheet
  Future<void> _openPlant(_Day d, int i, List<String> names) async {
    if (d.isFuture) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t('لسه بدري… البذرة بتستنّاك 🌱', 'Too early… the seed is waiting 🌱'))));
      return;
    }
    HapticFeedback.selectionClick();
    final p = d.plants[i];
    final canEdit = p.state != PlantState.upcoming &&
        DateTime.now().difference(d.date).inDays <= 7; // same rule as the tracker screen
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (ctx) => _PlantSheet(
        day: d,
        index: i,
        plant: p,
        prayerName: names[i],
        hijriText: '${d.hijriDay} ${HijriCalendar.monthName(_hm, _ar)} $_hy',
        canEdit: canEdit,
        ar: _ar,
        hm12: _hm12,
        onToggle: () async {
          Navigator.pop(ctx);
          await PrayerTracker.setDone(d.date, i, !p.done);
          if (mounted) _load();
        },
      ),
    );
  }

  Future<void> _pickMonth() async {
    final items = <(int, int)>[];
    for (var k = 0; k < 14; k++) {
      items.add(HijriCalendar.shift(_curY, _curM, -k));
    }
    final r = await showModalBottomSheet<(int, int)>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: ListView(shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
            child: Text(t('اختر الشهر', 'Choose the month'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          for (final it in items)
            ListTile(
              leading: const Text('🌿', style: TextStyle(fontSize: 20)),
              title: Text('${t('حديقة', 'Garden of')} ${HijriCalendar.monthName(it.$2, _ar)} ${it.$1} ${t('هـ', 'AH')}'),
              selected: it.$1 == _hy && it.$2 == _hm,
              onTap: () => Navigator.pop(ctx, it),
            ),
        ]),
      ),
    );
    if (r != null) {
      setState(() {
        _hy = r.$1;
        _hm = r.$2;
        _loaded = false;
      });
      _load();
    }
  }

  // ------------------------------------------------------------------------ build
  @override
  Widget build(BuildContext context) {
    if (_hy == 0) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final names = [l.fajr, l.dhuhr, l.asr, l.maghrib, l.isha];
    final sky = _sky;
    final top = sky?.top ?? const Color(0xFF3B7FB0);
    final mid = sky?.mid ?? const Color(0xFF79B4C9);
    final bottom = sky?.bottom ?? const Color(0xFFE8D9A8);
    final night = (sky?.stars ?? 0) > 0.4;

    final pct = _possible == 0 ? 0 : (_prayed * 100 / _possible).round();
    final gardenLevel = (pct / 100 * 5.5).clamp(0.0, 5.0).toDouble();

    return Scaffold(
      body: Stack(children: [
        // sky → meadow
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.16, 0.30, 1],
                colors: dark
                    ? [top, mid, const Color(0xFF1E3B2B), const Color(0xFF17301F)]
                    : [top, bottom, const Color(0xFFCFE8B8), const Color(0xFF9FCF7E)],
              ),
            ),
          ),
        ),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: top,
              foregroundColor: Colors.white,
              elevation: 0,
              title: Text(t('حديقتي', 'My garden')),
              actions: [
                IconButton(
                  tooltip: t('الإحصائيات', 'Statistics'),
                  icon: const Icon(Icons.bar_chart_rounded),
                  onPressed: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerTrackerScreen()));
                    if (mounted) _load();
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(child: _hero(cs, pct, gardenLevel, night)),
            if (!_loaded)
              const SliverFillRemaining(hasScrollBody: false, child: Center(child: CircularProgressIndicator()))
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, idx) => _row(idx, names, dark),
                  childCount: _days.length,
                ),
              ),
            if (_loaded) SliverToBoxAdapter(child: _footer(cs, pct)),
          ],
        ),
        // butterflies by day, fireflies by night
        Positioned.fill(
          child: IgnorePointer(
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _anim,
                builder: (_, __) => CustomPaint(painter: _AmbientPainter(_anim.value, night)),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _hero(ColorScheme cs, int pct, double level, bool night) {
    final len = HijriCalendar.monthLength(_hy, _hm);
    final a = HijriCalendar.toGregorian(_hy, _hm, 1);
    final b = HijriCalendar.toGregorian(_hy, _hm, len);
    Widget chip(String e, String v) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.20), borderRadius: BorderRadius.circular(20)),
          child: Text('$e $v', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
        );
    final finished = !_isCurrent && pct >= 90;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: Column(children: [
        Row(children: [
          IconButton(
            onPressed: () => _go(-1),
            tooltip: t('الشهر السابق', 'Previous month'),
            icon: const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 32),
          ),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _pickMonth,
              child: Column(children: [
                Text(t('حديقة', 'Garden of'), style: const TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 2),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: HijriCalendar.monthName(_hm, _ar),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [Shadow(blurRadius: 6, color: Colors.black26)],
                        ),
                      ),
                      TextSpan(
                        text: '  ($_hy ${t('هـ', 'AH')})',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.82),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          shadows: const [Shadow(blurRadius: 4, color: Colors.black26)],
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text('${DateText.dayMonth(a, _ar)} – ${DateText.date(b, _ar)}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ]),
            ),
          ),
          IconButton(
            onPressed: _isCurrent ? null : () => _go(1),
            tooltip: t('الشهر التالي', 'Next month'),
            icon: Icon(Icons.chevron_right_rounded,
                color: _isCurrent ? Colors.white24 : Colors.white, size: 32),
          ),
        ]),
        const SizedBox(height: 4),
        SizedBox(
          height: 150,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            // rolling hills
            Positioned.fill(child: CustomPaint(painter: _HillsPainter(night))),
            // the tree of the month
            PrayerTree(level: level, size: 138, doneToday: pct >= 60),
          ]),
        ),
        const SizedBox(height: 8),
        Wrap(alignment: WrapAlignment.center, spacing: 8, runSpacing: 8, children: [
          chip('🌳', '$_prayed/$_possible'),
          chip('⭐', t('$_perfectDays أيام كاملة', '$_perfectDays perfect days')),
          chip('🔥', t('أفضل سلسلة $_bestStreak', 'Best streak $_bestStreak')),
          if (finished) chip('🏆', t('غابة مباركة', 'A blessed forest')),
        ]),
      ]),
    );
  }

  Widget _row(int idx, List<String> names, bool dark) {
    final d = _days[idx];
    final weekIndex = idx ~/ 7;
    final isFriday = d.date.weekday == DateTime.friday;
    final showWeek = idx == 0 || _days[idx - 1].date.weekday == DateTime.friday;
    final grass = weekIndex.isEven
        ? [const Color(0xFFB7E08F), const Color(0xFF8CC465)]
        : [const Color(0xFFA6D67E), const Color(0xFF7DB85A)];

    return Column(children: [
      if (showWeek)
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 2),
          child: Row(children: [
            const Text('🌾', style: TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(t('الأسبوع ${weekIndex + 1}', 'Week ${weekIndex + 1}'),
                style: TextStyle(fontWeight: FontWeight.bold, color: dark ? Colors.white70 : const Color(0xFF3C5E27))),
          ]),
        ),
      Opacity(
        opacity: d.isFuture ? 0.62 : 1,
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 4, 12, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: grass),
            border: d.isToday
                ? Border.all(color: const Color(0xFFFFD54F), width: 2.4)
                : (isFriday ? Border.all(color: const Color(0xFFE9C46A).withValues(alpha: 0.9), width: 1.4) : null),
            boxShadow: [
              BoxShadow(
                color: (d.isToday ? const Color(0xFFFFD54F) : Colors.black).withValues(alpha: d.isToday ? 0.35 : 0.10),
                blurRadius: d.isToday ? 14 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: LayoutBuilder(builder: (context, c) {
            final plant = ((c.maxWidth - 64 - 12) / 5).clamp(44.0, 74.0).toDouble();
            return Padding(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 6),
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                SizedBox(
                  width: 58,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('${d.hijriDay}',
                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF2F4F1F))),
                    Text(_wd(d.date),
                        style: TextStyle(fontSize: 11, color: isFriday ? const Color(0xFF9A6B00) : const Color(0xFF4C6B38), fontWeight: FontWeight.w600)),
                    Text('${d.date.day}/${d.date.month}', style: const TextStyle(fontSize: 10, color: Color(0xFF58704A))),
                    if (d.isToday)
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(color: const Color(0xFFFFD54F), borderRadius: BorderRadius.circular(8)),
                        child: Text(t('اليوم', 'Today'), style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold)),
                      ),
                  ]),
                ),
                for (var i = 0; i < 5; i++)
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _openPlant(d, i, names),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        GardenPlant(
                          species: i,
                          level: PrayerTracker.treeLevel(d.plants[i].streak),
                          state: d.plants[i].state,
                          size: plant,
                          glow: d.isToday && d.plants[i].done,
                        ),
                        Text(names[i], style: const TextStyle(fontSize: 9.5, color: Color(0xFF2F4F1F), fontWeight: FontWeight.w600)),
                      ]),
                    ),
                  ),
              ]),
            );
          }),
        ),
      ),
    ]);
  }

  Widget _footer(ColorScheme cs, int pct) {
    final msg = pct >= 90
        ? t('ما شاء الله! حديقة عامرة مباركة 🌳🌳🌳', 'Masha Allah! A flourishing garden 🌳🌳🌳')
        : pct >= 60
            ? t('حديقتك جميلة — كمّل وهتبقى غابة 🌿', 'A lovely garden — keep going and it becomes a forest 🌿')
            : pct > 0
                ? t('كل صلاة بتسقي شجرة. ابدأ من النهارده 💧', 'Every prayer waters a tree. Start today 💧')
                : t('الحديقة مستنياك… أول صلاة تزرع أول شجرة 🌱', 'The garden is waiting… your first prayer plants the first tree 🌱');
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Column(children: [
        Text(msg, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, color: Color(0xFF2F4F1F), height: 1.5)),
        const SizedBox(height: 14),
        Wrap(alignment: WrapAlignment.center, spacing: 12, runSpacing: 6, children: [
          for (var i = 0; i < 5; i++)
            Text('${Species.emoji(i)} ${Species.name(i, _ar)}', style: const TextStyle(fontSize: 11.5, color: Color(0xFF3C5E27))),
        ]),
      ]),
    );
  }
}

// ======================================================================== plant sheet
class _PlantSheet extends StatelessWidget {
  final _Day day;
  final int index;
  final _Plant plant;
  final String prayerName;
  final String hijriText;
  final bool canEdit;
  final bool ar;
  final String Function(int) hm12;
  final VoidCallback onToggle;

  const _PlantSheet({
    required this.day,
    required this.index,
    required this.plant,
    required this.prayerName,
    required this.hijriText,
    required this.canEdit,
    required this.ar,
    required this.hm12,
    required this.onToggle,
  });

  String t(String a, String e) => ar ? a : e;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final level = PrayerTracker.treeLevel(plant.streak);
    final accent = Species.accent[index];
    final stage = PrayerTree.stageName(level, ar);

    String status;
    Color statusColor;
    switch (plant.state) {
      case PlantState.grown:
        status = plant.markMin != null ? t('صلّيتها ✓ الساعة ${hm12(plant.markMin!)}', 'Prayed ✓ at ${hm12(plant.markMin!)}') : t('صلّيتها ✓', 'Prayed ✓');
        statusColor = Colors.green.shade700;
        break;
      case PlantState.pending:
        status = t('وقتها دخل ولسه ما سجّلتهاش 💧', 'Its time has come — not logged yet 💧');
        statusColor = Colors.blue.shade700;
        break;
      case PlantState.withered:
        status = t('لم تُسجَّل — الشجرة محتاجة سقاية', 'Not logged — the tree needs water');
        statusColor = Colors.brown.shade600;
        break;
      case PlantState.upcoming:
        status = t('لسه وقتها ما جاش 🌱', 'Its time has not come yet 🌱');
        statusColor = cs.onSurfaceVariant;
    }

    String streakLine;
    if (plant.state == PlantState.grown) {
      streakLine = plant.streak >= 30
          ? t('شجرة مثمرة! ${plant.streak} يوم متواصل على $prayerName 🍎', 'A fruit-bearing tree! ${plant.streak} days in a row 🍎')
          : plant.streak >= 7
              ? t('أسبوع فأكثر — ${plant.streak} يوم متواصل على $prayerName 🔥', '${plant.streak} days in a row 🔥')
              : t('اليوم رقم ${plant.streak} من مواظبتك على $prayerName', 'Day ${plant.streak} of your streak');
    } else {
      streakLine = t('كل صلاة بتكبّر الشجرة — مواظبتك هي مياهها 💧', 'Every prayer grows the tree — consistency is its water 💧');
    }

    final weekday = DateText.weekday(day.date, ar);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 0, 22, 18),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [accent.withValues(alpha: 0.10), const Color(0xFFB7E08F).withValues(alpha: 0.45)]),
            ),
            child: Center(
              child: GardenPlant(species: index, level: level, state: plant.state, size: 150, glow: plant.state == PlantState.grown),
            ),
          ),
          const SizedBox(height: 12),
          Text('$prayerName ${Species.emoji(index)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text('${Species.name(index, ar)} · $stage', style: TextStyle(color: accent, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('$weekday $hijriText ${t('هـ', 'AH')}', style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600)),
          Text('(${DateText.date(day.date, ar)})', style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(14)),
            child: Text(status, textAlign: TextAlign.center, style: TextStyle(color: statusColor, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 10),
          Text(streakLine, textAlign: TextAlign.center, style: TextStyle(color: cs.onSurfaceVariant, height: 1.45)),
          if (canEdit) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: plant.done
                  ? OutlinedButton.icon(onPressed: onToggle, icon: const Icon(Icons.undo_rounded), label: Text(t('إلغاء التسجيل', 'Undo')))
                  : FilledButton.icon(
                      onPressed: onToggle,
                      icon: const Icon(Icons.water_drop_rounded),
                      label: Text(t('سجّلتها — اسقِ الشجرة 💧', 'I prayed it — water the tree 💧')),
                    ),
            ),
          ],
        ]),
      ),
    );
  }
}

// ============================================================================ scenery
class _HillsPainter extends CustomPainter {
  final bool night;
  _HillsPainter(this.night);

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    Path hill(double y, double amp, double phase) {
      final p = Path()..moveTo(0, h);
      for (double x = 0; x <= w; x += 6) {
        p.lineTo(x, y + math.sin(x / w * math.pi * 2 + phase) * amp);
      }
      return p..lineTo(w, h)..close();
    }
    canvas.drawPath(hill(h * 0.60, 9, 0.4), Paint()..color = (night ? const Color(0xFF1F4D36) : const Color(0xFF7CB85A)).withValues(alpha: 0.85));
    canvas.drawPath(hill(h * 0.74, 8, 2.2), Paint()..color = (night ? const Color(0xFF1B4330) : const Color(0xFF94CC6F)));
    canvas.drawPath(hill(h * 0.88, 6, 4.0), Paint()..color = (night ? const Color(0xFF17382A) : const Color(0xFFA9D882)));
  }

  @override
  bool shouldRepaint(_HillsPainter o) => o.night != night;
}

/// Butterflies by day, fireflies at night. Cheap: a handful of shapes driven by one controller.
class _AmbientPainter extends CustomPainter {
  final double t; // 0..1 looping
  final bool night;
  _AmbientPainter(this.t, this.night);

  @override
  void paint(Canvas canvas, Size s) {
    final r = math.Random(5);
    if (night) {
      for (var i = 0; i < 14; i++) {
        final bx = r.nextDouble() * s.width, by = s.height * (0.25 + r.nextDouble() * 0.7);
        final ph = r.nextDouble() * math.pi * 2;
        final x = bx + math.sin(t * math.pi * 2 * 2 + ph) * 18;
        final y = by + math.cos(t * math.pi * 2 * 3 + ph) * 14;
        final a = (0.35 + 0.6 * (0.5 + 0.5 * math.sin(t * math.pi * 2 * 6 + ph))).clamp(0.0, 1.0).toDouble();
        canvas.drawCircle(Offset(x, y), 5, Paint()..color = const Color(0xFFFFEE58).withValues(alpha: a * 0.25));
        canvas.drawCircle(Offset(x, y), 1.8, Paint()..color = const Color(0xFFFFF59D).withValues(alpha: a));
      }
      return;
    }
    final cols = [const Color(0xFFFF8A65), const Color(0xFFFFD54F), const Color(0xFF81D4FA)];
    for (var i = 0; i < 3; i++) {
      final ph = i * 2.1;
      final x = (t * (1.0 + i * 0.35) + i * 0.3) % 1.0 * (s.width + 60) - 30;
      final y = s.height * (0.30 + 0.18 * i) + math.sin(t * math.pi * 2 * (3 + i) + ph) * 26;
      final flap = (math.sin(t * math.pi * 2 * 40 + ph)).abs();
      final wing = 4.0 + 5.0 * flap;
      final p = Paint()..color = cols[i].withValues(alpha: 0.9);
      canvas.drawOval(Rect.fromCenter(center: Offset(x - 3, y), width: wing, height: 8), p);
      canvas.drawOval(Rect.fromCenter(center: Offset(x + 3, y), width: wing, height: 8), p);
      canvas.drawLine(Offset(x, y - 3), Offset(x, y + 3), Paint()..color = Colors.brown.shade700..strokeWidth = 1.4);
    }
  }

  @override
  bool shouldRepaint(_AmbientPainter o) => o.t != t || o.night != night;
}
