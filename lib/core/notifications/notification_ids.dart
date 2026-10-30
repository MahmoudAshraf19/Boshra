/// Stable, collision-free notification IDs.
///
/// Ranges (never overlap):
///   1..9          fixed reminders (azkar)
///   1000..1099    daily Quran messages
///   100000..199999 prayer notifications (day-based, see [prayer])
class NotificationIds {
  NotificationIds._();

  static const int azkarMorning = 1;
  static const int azkarEvening = 2;

  static const int quranBase = 1000;
  static const int quranMax = 1099;

  static const int prayerMin = 100000;
  static const int prayerMax = 199999;

  /// [prayerIndex] 0..4 (Fajr..Isha). [pre] = pre-prayer reminder.
  /// Unique for any 9,999-day window (≈27 years) – far more than we schedule.
  static int prayer(DateTime date, int prayerIndex, {bool pre = false}) {
    final dayNumber =
        DateTime.utc(date.year, date.month, date.day)
            .difference(DateTime.utc(2024, 1, 1))
            .inDays;
    final slot = (dayNumber % 9999) * 10 + prayerIndex * 2 + (pre ? 1 : 0);
    return prayerMin + slot % (prayerMax - prayerMin);
  }

  static bool isPrayer(int id) => id >= prayerMin && id <= prayerMax;
  static bool isQuran(int id) => id >= quranBase && id <= quranMax;
}
