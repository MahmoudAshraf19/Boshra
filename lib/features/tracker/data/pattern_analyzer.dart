import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../prayer/data/repositories/prayer_repository.dart';
import '../../prayer/domain/prayer_settings.dart';
import 'prayer_tracker.dart';

/// What the app learned about THIS user's prayer habits (computed on the device only, from the
/// last 14 days of the tracker).
class PatternInsights {
  /// Days (excluding today) on which the user logged at least one prayer.
  final int trackedDays;
  final List<int> missed; // per prayer
  final List<int> lateCount; // marked in the last part of the prayer window
  final List<int> markedInWindow; // marks that carry a time

  const PatternInsights(this.trackedDays, this.missed, this.lateCount, this.markedInWindow);

  static const empty = PatternInsights(0, [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]);

  bool get enoughData => trackedDays >= 5;

  /// Fajr missed in ≥ 40 % of the tracked days.
  bool get fajrWeak => enoughData && missed[0] / trackedDays >= 0.4 && missed[0] >= 3;

  /// Usually prays prayer [i] in the last 30 % of its time.
  bool lateProne(int i) => markedInWindow[i] >= 4 && lateCount[i] >= 3 && lateCount[i] / markedInWindow[i] >= 0.5;

  int? get weakest {
    if (!enoughData) return null;
    var w = 0;
    for (var i = 1; i < 5; i++) {
      if (missed[i] > missed[w]) w = i;
    }
    return missed[w] == 0 ? null : w;
  }

  Map<String, dynamic> toJson() => {'d': trackedDays, 'm': missed, 'l': lateCount, 'w': markedInWindow};

  factory PatternInsights.fromJson(Map<String, dynamic> j) => PatternInsights(
        (j['d'] as num).toInt(),
        (j['m'] as List).map((e) => (e as num).toInt()).toList(),
        (j['l'] as List).map((e) => (e as num).toInt()).toList(),
        (j['w'] as List).map((e) => (e as num).toInt()).toList(),
      );
}

/// User choices for the "learn my habits" feature.
class PatternSettings {
  final bool learning;
  final bool sleepOn;
  final int sleepMinutes; // minutes after midnight, default 22:00
  final DateTime? snoozedUntil;
  const PatternSettings(this.learning, this.sleepOn, this.sleepMinutes, this.snoozedUntil);

  static Future<PatternSettings> load() async {
    final p = await SharedPreferences.getInstance();
    final sn = p.getInt('pattern_snooze_ms');
    return PatternSettings(
      p.getBool('pattern_learning') ?? true,
      p.getBool('pattern_sleep_on') ?? false,
      p.getInt('pattern_sleep_min') ?? 22 * 60,
      sn == null ? null : DateTime.fromMillisecondsSinceEpoch(sn),
    );
  }

  static Future<void> setLearning(bool v) async =>
      (await SharedPreferences.getInstance()).setBool('pattern_learning', v);

  static Future<void> setSleep(bool on, {int? minutes}) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool('pattern_sleep_on', on);
    if (minutes != null) await p.setInt('pattern_sleep_min', minutes);
  }

  static Future<void> snooze(Duration d) async => (await SharedPreferences.getInstance())
      .setInt('pattern_snooze_ms', DateTime.now().add(d).millisecondsSinceEpoch);
}

class PatternAnalyzer {
  PatternAnalyzer._();

  static const _key = 'pattern_v1';
  static const _ttl = Duration(hours: 6);

  static Future<void> invalidate() async => (await SharedPreferences.getInstance()).remove(_key);

  static int? _minOf(String raw) {
    final m = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
    return m == null ? null : int.parse(m.group(1)!) * 60 + int.parse(m.group(2)!);
  }

  /// Cached for 6 h (the scheduler calls this on every run).
  static Future<PatternInsights> analyze({bool force = false}) async {
    final prefs = await SharedPreferences.getInstance();
    if (!force) {
      try {
        final raw = prefs.getString(_key);
        if (raw != null) {
          final j = (jsonDecode(raw) as Map).cast<String, dynamic>();
          if (DateTime.now().millisecondsSinceEpoch - (j['t'] as int) < _ttl.inMilliseconds) {
            return PatternInsights.fromJson(j);
          }
        }
      } catch (_) {}
    }
    final r = await _compute(prefs);
    try {
      await prefs.setString(_key, jsonEncode({...r.toJson(), 't': DateTime.now().millisecondsSinceEpoch}));
    } catch (_) {}
    return r;
  }

  static Future<PatternInsights> _compute(SharedPreferences prefs) async {
    final tracker = await PrayerTracker.load();
    final marks = await PrayerTracker.loadMarkTimes();
    final st = await PrayerSettings.load();
    final repo = PrayerRepository();
    final today = DateTime.now();
    var tracked = 0;
    final missed = List.filled(5, 0), late = List.filled(5, 0), inWin = List.filled(5, 0);

    for (var k = 1; k <= 14; k++) {
      final d = DateTime(today.year, today.month, today.day - k);
      final mask = tracker[PrayerTracker.dayKey(d)] ?? 0;
      if (mask == 0) continue; // the user did not use the tracker that day
      tracked++;
      for (var i = 0; i < 5; i++) {
        if ((mask >> i) & 1 == 0) missed[i]++;
      }
      // lateness needs the prayer times of that day (cache only, never the network)
      final times = marks[PrayerTracker.dayKey(d)];
      if (times == null) continue;
      final model = await repo.getPrayerTimesForDate(d,
          skipLocationFetch: true, method: st.calcMethod, school: st.asrSchool);
      if (model == null) continue;
      final x = model.timings;
      final start = [_minOf(x.fajr), _minOf(x.dhuhr), _minOf(x.asr), _minOf(x.maghrib), _minOf(x.isha)];
      final end = [_minOf(x.sunrise), _minOf(x.asr), _minOf(x.maghrib), _minOf(x.isha), null];
      for (var i = 0; i < 5; i++) {
        final m = times[i];
        final s = start[i];
        final e = end[i] ?? (s == null ? null : s + 240); // Isha window ≈ 4 h
        if (m < 0 || s == null || e == null || e <= s) continue;
        if (m < s || m > e) continue; // marked after the window → unknown, ignore
        inWin[i]++;
        if ((m - s) / (e - s) >= 0.7) late[i]++;
      }
    }
    return PatternInsights(tracked, missed, late, inWin);
  }
}
