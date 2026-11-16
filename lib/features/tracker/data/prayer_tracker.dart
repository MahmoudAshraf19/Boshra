import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/notifications/notification_coordinator.dart';
import '../../../core/notifications/notification_ids.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/telemetry.dart';
import 'pattern_analyzer.dart';

/// Prayer tracker data: one bit-mask per day (bit 0 = Fajr … bit 4 = Isha), stored as JSON in
/// `tracker_v1`. The notification "I prayed ✓" button writes the same key natively.
class PrayerTracker {
  PrayerTracker._();

  static const _key = 'tracker_v1';
  static Timer? _rescheduleTimer;
  static const full = 31;

  static String dayKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static DateTime _day(DateTime d) => DateTime(d.year, d.month, d.day);

  static Future<Map<String, int>> load() async {
    final p = await SharedPreferences.getInstance();
    try {
      await p.reload(); // the native notification button may have written to it
    } catch (_) {}
    try {
      final m = (jsonDecode(p.getString(_key) ?? '{}') as Map).cast<String, dynamic>();
      return m.map((k, v) => MapEntry(k, (v as num).toInt() & full));
    } catch (_) {
      return {};
    }
  }

  static Future<void> _save(Map<String, int> map) async {
    // keep ~13 months only
    final cutoff = dayKey(DateTime.now().subtract(const Duration(days: 400)));
    map.removeWhere((k, v) => k.compareTo(cutoff) < 0 || v == 0);
    final p = await SharedPreferences.getInstance();
    await p.setString(_key, jsonEncode(map));
  }

  static const _timesKey = 'tracker_times_v1';

  /// Minute of the day each prayer was marked ("yyyy-MM-dd" → [Fajr..Isha], -1 = no time).
  static Future<Map<String, List<int>>> loadMarkTimes() async {
    final p = await SharedPreferences.getInstance();
    try {
      final m = (jsonDecode(p.getString(_timesKey) ?? '{}') as Map).cast<String, dynamic>();
      return m.map((k, v) => MapEntry(k, (v as List).map((e) => (e as num).toInt()).toList()));
    } catch (_) {
      return {};
    }
  }

  static Future<void> _saveMarkTime(DateTime date, int i, bool done) async {
    final p = await SharedPreferences.getInstance();
    final all = await loadMarkTimes();
    final k = dayKey(date);
    final arr = all[k] ?? List.filled(5, -1);
    final now = DateTime.now();
    // only meaningful when marked on the same day it was prayed
    arr[i] = done && _day(date) == _day(now) ? now.hour * 60 + now.minute : -1;
    all[k] = arr;
    final cutoff = dayKey(now.subtract(const Duration(days: 60)));
    all.removeWhere((key, v) => key.compareTo(cutoff) < 0);
    await p.setString(_timesKey, jsonEncode(all));
  }

  static bool isDone(Map<String, int> m, DateTime d, int i) => ((m[dayKey(d)] ?? 0) >> i) & 1 == 1;

  /// Marks / unmarks a prayer. Marking today's prayer removes its "did you pray?" nudge;
  /// unmarking re-creates it (via a re-schedule).
  static Future<Map<String, int>> setDone(DateTime date, int i, bool done) async {
    final m = await load();
    final k = dayKey(date);
    final cur = m[k] ?? 0;
    m[k] = done ? (cur | (1 << i)) : (cur & ~(1 << i));
    await _save(m);
    await _saveMarkTime(date, i, done);
    PatternAnalyzer.invalidate();
    final p = await SharedPreferences.getInstance();
    await p.setBool('tracker_used', true);
    Telemetry.log(done ? 'prayer_marked' : 'prayer_unmarked', {'i': i});
    final today = _day(DateTime.now());
    if (_day(date) == today && done) {
      await NotificationService().cancelId(NotificationIds.nudge(date, i));
    }
    // Weekly-summary text, nudges and learned habits all depend on the log → refresh (debounced).
    _rescheduleTimer?.cancel();
    _rescheduleTimer = Timer(const Duration(seconds: 4), () {
      NotificationCoordinator.instance.rescheduleAll(force: true);
    });
    return m;
  }

  // ------------------------------------------------------------------ statistics
  /// Consecutive days (ending today, or yesterday while today is still open) on which prayer
  /// [i] was prayed.
  static int streakFor(Map<String, int> m, int i) {
    var d = _day(DateTime.now());
    if (!isDone(m, d, i)) d = d.subtract(const Duration(days: 1));
    var n = 0;
    while (isDone(m, d, i)) {
      n++;
      d = d.subtract(const Duration(days: 1));
      if (n > 400) break;
    }
    return n;
  }

  /// Consecutive days with all five prayers.
  static int streakAll(Map<String, int> m) {
    var d = _day(DateTime.now());
    if ((m[dayKey(d)] ?? 0) != full) d = d.subtract(const Duration(days: 1));
    var n = 0;
    while ((m[dayKey(d)] ?? 0) == full) {
      n++;
      d = d.subtract(const Duration(days: 1));
      if (n > 400) break;
    }
    return n;
  }

  static int bestStreakAll(Map<String, int> m) {
    final keys = m.entries.where((e) => e.value == full).map((e) => e.key).toList()..sort();
    var best = 0, cur = 0;
    DateTime? prev;
    for (final k in keys) {
      final d = DateTime.parse(k);
      cur = (prev != null && d.difference(prev).inDays == 1) ? cur + 1 : 1;
      if (cur > best) best = cur;
      prev = d;
    }
    return best;
  }

  static int _bits(int v) {
    var n = 0;
    while (v > 0) {
      n += v & 1;
      v >>= 1;
    }
    return n;
  }

  /// Prayers per day for the last 7 days, oldest → today.
  static List<int> weekCounts(Map<String, int> m) {
    final t = _day(DateTime.now());
    return [for (var k = 6; k >= 0; k--) _bits(m[dayKey(t.subtract(Duration(days: k)))] ?? 0)];
  }

  static int weekPercent(Map<String, int> m) {
    final c = weekCounts(m);
    final total = c.fold<int>(0, (a, b) => a + b);
    return (total * 100 / 35).round();
  }

  static int totalPrayed(Map<String, int> m) => m.values.fold<int>(0, (a, b) => a + _bits(b));

  /// Tree growth level 0..5 from a streak of days.
  static double treeLevel(int streak) {
    if (streak <= 0) return 0;
    if (streak < 3) return 1 + (streak - 1) * 0.5; // 1.0 .. 1.5
    if (streak < 7) return 2 + (streak - 3) / 4; // 2 .. 3
    if (streak < 14) return 3 + (streak - 7) / 7; // 3 .. 4
    if (streak < 30) return 4 + (streak - 14) / 16 * 0.8; // 4 .. 4.8
    return 5;
  }


  static Future<bool> nudgeEnabled() async =>
      (await SharedPreferences.getInstance()).getBool('tracker_nudge') ?? true;

  static Future<void> setNudge(bool v) async {
    await (await SharedPreferences.getInstance()).setBool('tracker_nudge', v);
    NotificationCoordinator.instance.rescheduleAll(force: true);
  }
}
