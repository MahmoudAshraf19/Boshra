import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../prayer/data/repositories/prayer_repository.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../data/pattern_analyzer.dart';
import '../../data/prayer_tracker.dart';
import 'weekly_summary_screen.dart';
import '../widgets/prayer_tree.dart';

/// Prayer tracker: mark prayers, see your streak, weekly stats — and watch one tree per
/// prayer grow with your consistency.
class PrayerTrackerScreen extends StatefulWidget {
  const PrayerTrackerScreen({super.key});

  @override
  State<PrayerTrackerScreen> createState() => _PrayerTrackerScreenState();
}

class _PrayerTrackerScreenState extends State<PrayerTrackerScreen> with WidgetsBindingObserver {
  Map<String, int> _m = {};
  List<DateTime?> _times = List.filled(5, null);
  int _dayOffset = 0; // 0 = today … 6 = six days ago
  final List<int> _bounce = List.filled(5, 0);
  bool _nudge = true;
  bool _loaded = false;
  PatternInsights _ins = PatternInsights.empty;
  PatternSettings? _ps;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;
  DateTime get _date {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day - _dayOffset);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _load(); // the notification button may have marked one
  }

  DateTime? _parse(String raw) {
    final m = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
    if (m == null) return null;
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day, int.parse(m.group(1)!), int.parse(m.group(2)!));
  }

  Future<void> _load() async {
    final m = await PrayerTracker.load();
    final prayer = await PrayerRepository().getTodayPrayerTimes(skipLocationFetch: true);
    final nudge = await PrayerTracker.nudgeEnabled();
    final ps = await PatternSettings.load();
    final ins = ps.learning ? await PatternAnalyzer.analyze() : PatternInsights.empty;
    if (!mounted) return;
    setState(() {
      _m = m;
      _nudge = nudge;
      _ps = ps;
      _ins = ins;
      if (prayer != null) {
        final x = prayer.timings;
        _times = [_parse(x.fajr), _parse(x.dhuhr), _parse(x.asr), _parse(x.maghrib), _parse(x.isha)];
      }
      _loaded = true;
    });
  }

  bool _started(int i) {
    if (_dayOffset > 0) return true;
    final tm = _times[i];
    return tm == null || !tm.isAfter(DateTime.now());
  }

  Future<void> _toggle(int i) async {
    final done = PrayerTracker.isDone(_m, _date, i);
    if (!done && !_started(i)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(t('لسه ما دخلش وقتها 🌙', 'Its time has not started yet 🌙'))));
      return;
    }
    HapticFeedback.mediumImpact();
    final m = await PrayerTracker.setDone(_date, i, !done);
    if (!mounted) return;
    setState(() {
      _m = m;
      _bounce[i]++;
    });
  }

  // ------------------------------------------------------------ learned habits
  String _hm(int minutes) {
    final h = minutes ~/ 60, m = minutes % 60;
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return '$h12:${m.toString().padLeft(2, '0')} ${h < 12 ? t('ص', 'AM') : t('م', 'PM')}';
  }

  Future<void> _enableSleep([int? minutes]) async {
    await PatternSettings.setSleep(true, minutes: minutes);
    await NotificationCoordinator.instance.rescheduleAll(force: true);
    await _load();
  }

  Future<void> _pickSleepTime() async {
    final cur = _ps?.sleepMinutes ?? 22 * 60;
    final tod = await showTimePicker(context: context, initialTime: TimeOfDay(hour: cur ~/ 60, minute: cur % 60));
    if (tod != null) await _enableSleep(tod.hour * 60 + tod.minute);
  }

  Widget _insightsCard(List<String> names, ColorScheme cs) {
    final ps = _ps;
    if (ps == null || !ps.learning) return const SizedBox.shrink();
    final ins = _ins;
    Widget box(Color c, List<Widget> children) => Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: c.withValues(alpha: 0.35)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
        );

    if (!ins.enoughData) {
      return box(cs.primary, [
        Text(t('🧠 بنتعرّف على أنماطك', '🧠 Learning your habits'), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(t('سجّل صلواتك 5 أيام على الأقل، وهنقترح عليك تحسينات تناسبك أنت (كل التحليل على جهازك فقط).',
            'Log your prayers for at least 5 days and we will suggest improvements tailored to you (all analysis stays on your device).'),
            style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant, height: 1.4)),
      ]);
    }

    final cards = <Widget>[];
    final snoozed = ps.snoozedUntil != null && ps.snoozedUntil!.isAfter(DateTime.now());

    if (ins.fajrWeak) {
      cards.add(box(Colors.deepOrange, [
        Text(t('🌅 الفجر بيفوتك: ${ins.missed[0]} من آخر ${ins.trackedDays} يوم', '🌅 Fajr slips away: ${ins.missed[0]} of the last ${ins.trackedDays} days'),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          ps.sleepOn
              ? t('تذكير النوم المبكر شغال الساعة ${_hm(ps.sleepMinutes)} كل ليلة. الله يعينك 🌿', 'Your early-sleep reminder is on at ${_hm(ps.sleepMinutes)} every night 🌿')
              : t('أغلب اللي بيفوّتوا الفجر بيكون السبب السهر. تحب نذكّرك كل ليلة تنام بدري؟', 'Missing Fajr is usually about sleeping late. Want a nightly reminder to sleep early?'),
          style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant, height: 1.4),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          if (!ps.sleepOn && !snoozed) ...[
            FilledButton(onPressed: () => _enableSleep(), child: Text(t('فعّل (${_hm(ps.sleepMinutes)})', 'Turn on (${_hm(ps.sleepMinutes)})'))),
            TextButton(
              onPressed: () async {
                await PatternSettings.snooze(const Duration(days: 14));
                await _load();
              },
              child: Text(t('مش دلوقتي', 'Not now')),
            ),
          ],
          if (ps.sleepOn) ...[
            OutlinedButton(onPressed: _pickSleepTime, child: Text(t('غيّر الوقت', 'Change time'))),
            TextButton(
              onPressed: () async {
                await PatternSettings.setSleep(false);
                await NotificationCoordinator.instance.rescheduleAll(force: true);
                await _load();
              },
              child: Text(t('إيقاف', 'Turn off')),
            ),
          ] else if (!snoozed)
            OutlinedButton(onPressed: _pickSleepTime, child: Text(t('اختر وقتًا آخر', 'Pick another time'))),
        ]),
      ]));
    }

    for (var i = 0; i < 5; i++) {
      if (ins.lateProne(i)) {
        cards.add(box(Colors.amber.shade800, [
          Text(t('⏰ ${names[i]} غالبًا في آخر وقتها', '⏰ ${names[i]} is usually near the end of its time'), style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(t('خلّينا التذكير اللطيف لـ ${names[i]} يجيلك أبكر من المعتاد (منتصف الوقت بدل آخره).', 'Your gentle reminder for ${names[i]} now arrives earlier (mid-window instead of near the end).'),
              style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant, height: 1.4)),
        ]));
      }
    }

    if (cards.isEmpty) {
      final w = ins.weakest;
      cards.add(box(Colors.green, [
        Text(w == null ? t('✨ مواظبتك ممتازة', '✨ Great consistency') : t('🌿 أضعف صلواتك: ${names[w]}', '🌿 Your weakest prayer: ${names[w]}'), style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(w == null ? t('مفيش صلاة بتفوتك بشكل متكرر. استمر!', 'No prayer is slipping repeatedly. Keep going!') : t('فاتتك ${ins.missed[w]} مرات في آخر ${ins.trackedDays} يوم. التذكير اللطيف بيساعدك عليها.', 'Missed ${ins.missed[w]} times in the last ${ins.trackedDays} days. The gentle reminder helps.'),
            style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant, height: 1.4)),
      ]));
    }
    return Column(children: cards);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final names = [l.fajr, l.dhuhr, l.asr, l.maghrib, l.isha];
    final streak = PrayerTracker.streakAll(_m);
    final best = PrayerTracker.bestStreakAll(_m);
    final week = PrayerTracker.weekCounts(_m);
    final pct = PrayerTracker.weekPercent(_m);
    final isToday = _dayOffset == 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(t('متتبّع الصلوات', 'Prayer tracker')),
        actions: [
          IconButton(
            tooltip: t('ملخّصك الأسبوعي', 'Weekly summary'),
            icon: const Icon(Icons.insights_rounded),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WeeklySummaryScreen())),
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert_rounded),
            onSelected: (v) async {
              if (v == 2) {
                final on = !(_ps?.learning ?? true);
                await PatternSettings.setLearning(on);
                NotificationCoordinator.instance.rescheduleAll(force: true);
                await _load();
                return;
              }
              await PrayerTracker.setNudge(!_nudge);
              if (mounted) setState(() => _nudge = !_nudge);
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 1,
                child: Row(children: [
                  Icon(_nudge ? Icons.notifications_active_rounded : Icons.notifications_off_rounded, size: 20),
                  const SizedBox(width: 10),
                  Text(_nudge ? t('إيقاف التذكير اللطيف', 'Turn off gentle reminder') : t('تفعيل التذكير اللطيف', 'Turn on gentle reminder')),
                ]),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(children: [
                  Icon((_ps?.learning ?? true) ? Icons.psychology_rounded : Icons.psychology_alt_rounded, size: 20),
                  const SizedBox(width: 10),
                  Text((_ps?.learning ?? true) ? t('إيقاف تعلّم أنماطي', 'Stop learning my habits') : t('تفعيل تعلّم أنماطي', 'Learn my habits')),
                ]),
              ),
            ],
          ),
        ],
      ),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ---- hero: streak
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(colors: [cs.primary, cs.primary.withValues(alpha: 0.78)]),
                  ),
                  child: Row(children: [
                    const Text('🔥', style: TextStyle(fontSize: 38)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          streak == 0
                              ? t('ابدأ سلسلتك اليوم', 'Start your streak today')
                              : t('$streak ${streak == 1 ? 'يوم' : 'أيام'} متتالية بكل الصلوات', '$streak-day streak, all five prayers'),
                          style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(t('أفضل سلسلة: $best — هذا الأسبوع: $pct%', 'Best streak: $best — this week: $pct%'),
                            style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ]),
                    ),
                  ]),
                ),
                const SizedBox(height: 14),
                _insightsCard(names, cs),
                // ---- day chips
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, k) {
                      final d = DateTime.now().subtract(Duration(days: k));
                      final cnt = week[6 - k];
                      return ChoiceChip(
                        selected: _dayOffset == k,
                        label: Text(k == 0 ? t('اليوم', 'Today') : k == 1 ? t('أمس', 'Yesterday') : '${d.day}/${d.month}  ·  $cnt/5'),
                        onSelected: (_) => setState(() => _dayOffset = k),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18),
                // ---- garden: 5 trees
                Text(t('حديقتك 🌳', 'Your garden 🌳'), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(t('كل صلاة ليها شجرة بتكبر مع كل يوم تواظب فيه عليها', 'Every prayer has a tree that grows with each day you keep it'),
                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12.5)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < 5; i++)
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => _toggle(i),
                            child: Column(children: [
                              TreeBounce(
                                trigger: _bounce[i],
                                child: PrayerTree(
                                  level: PrayerTracker.treeLevel(PrayerTracker.streakFor(_m, i)),
                                  size: 62,
                                  doneToday: PrayerTracker.isDone(_m, DateTime.now(), i),
                                  thirsty: isToday && _started(i) && !PrayerTracker.isDone(_m, _date, i),
                                ),
                              ),
                              Text(names[i], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                              Text(
                                PrayerTree.stageName(PrayerTracker.treeLevel(PrayerTracker.streakFor(_m, i)), _ar),
                                style: TextStyle(fontSize: 10.5, color: cs.onSurfaceVariant),
                              ),
                              Text('${PrayerTracker.streakFor(_m, i)} ${t('يوم', 'd')}',
                                  style: TextStyle(fontSize: 10.5, color: cs.primary, fontWeight: FontWeight.w600)),
                            ]),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                // ---- the day's prayers
                Text(isToday ? t('صلوات اليوم', "Today's prayers") : t('صلوات ${_date.day}/${_date.month}', 'Prayers ${_date.day}/${_date.month}'),
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                for (var i = 0; i < 5; i++)
                  Builder(builder: (_) {
                    final done = PrayerTracker.isDone(_m, _date, i);
                    final tm = _times[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      elevation: 0,
                      color: done ? Colors.green.withValues(alpha: 0.12) : cs.surfaceContainerLow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: done ? Colors.green.withValues(alpha: 0.5) : Colors.transparent)),
                      child: ListTile(
                        onTap: () => _toggle(i),
                        leading: Icon(done ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                            color: done ? Colors.green.shade600 : cs.outline, size: 28),
                        title: Text(names[i], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: isToday && tm != null
                            ? Text('${tm.hour.toString().padLeft(2, '0')}:${tm.minute.toString().padLeft(2, '0')}')
                            : null,
                        trailing: Text(done ? t('صلّيت ✓', 'Prayed ✓') : t('لم تُسجَّل', 'Not marked'),
                            style: TextStyle(color: done ? Colors.green.shade700 : cs.onSurfaceVariant, fontSize: 12.5)),
                      ),
                    );
                  }),
                const SizedBox(height: 14),
                // ---- weekly stats
                Text(t('إحصائيات الأسبوع', 'This week'), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 110,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    for (var k = 0; k < 7; k++)
                      Expanded(
                        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                          Text('${week[k]}', style: const TextStyle(fontSize: 11)),
                          const SizedBox(height: 3),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            height: 6 + week[k] * 14.0,
                            decoration: BoxDecoration(
                              color: week[k] == 5 ? Colors.green.shade600 : cs.primary.withValues(alpha: 0.55),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            (_ar ? ['س', 'ح', 'ن', 'ث', 'ر', 'خ', 'ج'] : ['S', 'S', 'M', 'T', 'W', 'T', 'F'])[
                                (DateTime.now().subtract(Duration(days: 6 - k)).weekday + 1) % 7],
                            style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant),
                          ),
                        ]),
                      ),
                  ]),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(t('إجمالي ما سجّلته: ${PrayerTracker.totalPrayed(_m)} صلاة', 'Total logged: ${PrayerTracker.totalPrayed(_m)} prayers'),
                      style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12.5)),
                ),
                const SizedBox(height: 24),
              ],
            ),
    );
  }
}
