import 'prayer_tracker.dart';

/// Last-7-days numbers for the weekly summary (notification text, screen and share image).
class WeeklyStats {
  final int total; // prayers logged
  final List<int> perPrayer; // Fajr..Isha, each 0..7
  final List<int> perDay; // oldest → today, each 0..5
  final int perfectDays;
  final int streak;

  const WeeklyStats(this.total, this.perPrayer, this.perDay, this.perfectDays, this.streak);

  static const max = 35;
  int get percent => (total * 100 / max).round();

  /// Index of the prayer prayed most (earliest wins a tie), or null if nothing was logged.
  int? get best {
    if (total == 0) return null;
    var b = 0;
    for (var i = 1; i < 5; i++) {
      if (perPrayer[i] > perPrayer[b]) b = i;
    }
    return b;
  }

  /// Index of the prayer prayed least, or null when all are equal.
  int? get weakest {
    if (total == 0) return null;
    var w = 0;
    for (var i = 1; i < 5; i++) {
      if (perPrayer[i] < perPrayer[w]) w = i;
    }
    return perPrayer[w] == perPrayer[best!] ? null : w;
  }

  /// Level 0..5 of the "tree of the week" (80 %+ ⇒ a fruit-bearing tree).
  double get treeLevel => (percent / 100 * 5.6).clamp(0.0, 5.0).toDouble();

  static WeeklyStats from(Map<String, int> m, {DateTime? now}) {
    final t = now ?? DateTime.now();
    final days = [for (var k = 6; k >= 0; k--) DateTime(t.year, t.month, t.day - k)];
    final per = List.filled(5, 0);
    final perDay = <int>[];
    var perfect = 0;
    for (final d in days) {
      final mask = m[PrayerTracker.dayKey(d)] ?? 0;
      var c = 0;
      for (var i = 0; i < 5; i++) {
        if ((mask >> i) & 1 == 1) {
          per[i]++;
          c++;
        }
      }
      perDay.add(c);
      if (c == 5) perfect++;
    }
    return WeeklyStats(perDay.fold<int>(0, (a, b) => a + b), per, perDay, perfect, PrayerTracker.streakAll(m));
  }

  /// "صليت 31 من 35 — أفضل صلاة عندك: الظهر، وأضعفها: الفجر"
  String sentence(List<String> names, bool ar) {
    final b = best, w = weakest;
    if (ar) {
      var s = 'صليت $total من $max';
      if (b != null) s += ' — أفضل صلاة عندك: ${names[b]}';
      if (w != null) s += '، وأضعفها: ${names[w]}';
      return s;
    }
    var s = 'You prayed $total of $max';
    if (b != null) s += ' — strongest: ${names[b]}';
    if (w != null) s += ', weakest: ${names[w]}';
    return s;
  }
}
