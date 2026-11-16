import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/prayer_tracker.dart';
import '../screens/prayer_garden_screen.dart';
import 'prayer_tree.dart';

/// Home card: today's five trees with a one-tap "I prayed" under each.
/// [times] = today's five prayer times as "HH:mm" (to forbid marking a prayer before its time).
class PrayerGardenCard extends StatefulWidget {
  final List<String?> times;
  const PrayerGardenCard({super.key, required this.times});

  @override
  State<PrayerGardenCard> createState() => _PrayerGardenCardState();
}

class _PrayerGardenCardState extends State<PrayerGardenCard> with WidgetsBindingObserver {
  Map<String, int> _m = {};
  final List<int> _bounce = List.filled(5, 0);

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';

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
    if (state == AppLifecycleState.resumed) _load();
  }

  Future<void> _load() async {
    final m = await PrayerTracker.load();
    if (mounted) setState(() => _m = m);
  }

  bool _started(int i) {
    final raw = i < widget.times.length ? widget.times[i] : null;
    if (raw == null) return true;
    final m = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
    if (m == null) return true;
    final n = DateTime.now();
    return !DateTime(n.year, n.month, n.day, int.parse(m.group(1)!), int.parse(m.group(2)!)).isAfter(n);
  }

  Future<void> _toggle(int i) async {
    final today = DateTime.now();
    final done = PrayerTracker.isDone(_m, today, i);
    if (!done && !_started(i)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_ar ? 'لسه ما دخلش وقتها 🌙' : 'Its time has not started yet 🌙')));
      return;
    }
    HapticFeedback.mediumImpact();
    final m = await PrayerTracker.setDone(today, i, !done);
    if (mounted) {
      setState(() {
        _m = m;
        _bounce[i]++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final names = [l.fajr, l.dhuhr, l.asr, l.maghrib, l.isha];
    final streak = PrayerTracker.streakAll(_m);
    final today = DateTime.now();
    final doneCount = [for (var i = 0; i < 5; i++) PrayerTracker.isDone(_m, today, i)].where((e) => e).length;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerGardenScreen()));
            _load();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(children: [
              Text(_ar ? 'حديقة صلواتك 🌳' : 'Your prayer garden 🌳',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Spacer(),
              if (streak > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                  child: Text('🔥 $streak', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                ),
              const SizedBox(width: 6),
              Text('$doneCount/5', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12.5)),
              Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant),
            ]),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 5; i++)
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => _toggle(i),
                  child: Column(children: [
                    TreeBounce(
                      trigger: _bounce[i],
                      child: PrayerTree(
                        level: PrayerTracker.treeLevel(PrayerTracker.streakFor(_m, i)),
                        size: 54,
                        doneToday: PrayerTracker.isDone(_m, today, i),
                        thirsty: _started(i) && !PrayerTracker.isDone(_m, today, i),
                      ),
                    ),
                    Text(names[i], style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Icon(
                      PrayerTracker.isDone(_m, today, i) ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                      size: 20,
                      color: PrayerTracker.isDone(_m, today, i) ? Colors.green.shade600 : cs.outline,
                    ),
                  ]),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: FilledButton.tonalIcon(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerGardenScreen()));
              _load();
            },
            icon: const Icon(Icons.park_rounded),
            label: Text(_ar ? 'ادخل حديقتك الكاملة 🌿' : 'Enter your full garden 🌿'),
          ),
        ),
      ]),
    );
  }
}
