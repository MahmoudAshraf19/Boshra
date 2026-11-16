/// Stable, collision-free notification IDs.
///
///   1..2             LEGACY fixed azkar ids (only cancelled, never used again)
///   1000..1099       Ayah of the day
///   100000..199999   prayer + pre-prayer notifications (day-based)
///   200000..209999   Azkar (morning / evening, day-based)
///   210000..219999   Friday reminders (Salawat / Al-Kahf, 5 slots per day)
///   220000..229999   Iqama alerts (5 per day)
///   230000..239999   Gentle "did you pray?" nudges (5 per day)
///   240000..249999   Prayer-mode (auto silence) ON/OFF events (10 per day)
class NotificationIds {
  NotificationIds._();

  static const List<int> legacy = [1, 2];

  static const int quranBase = 1000;
  static const int quranMax = 1099;

  static const int prayerMin = 100000;
  static const int prayerMax = 199999;

  static const int azkarMin = 200000;
  static const int azkarMax = 209999;

  static const int fridayMin = 210000;
  static const int fridayMax = 219999;

  static const int iqamaMin = 220000;
  static const int iqamaMax = 229999;
  static const int nudgeMin = 230000;
  static const int nudgeMax = 239999;
  static const int modeMin = 240000;
  static const int modeMax = 249999;
  static const int zakatMin = 250000; // 250001 = 7 days before, 250002 = on the day
  static const int zakatMax = 250099;
  static const int sleepMin = 251000; // "sleep early for Fajr", one per day
  static const int sleepMax = 251999;
  static const int weeklyMin = 252000; // Friday weekly summary, one per week
  static const int weeklyMax = 252999;

  static int _dayNumber(DateTime d) =>
      DateTime.utc(d.year, d.month, d.day).difference(DateTime.utc(2024, 1, 1)).inDays;

  /// [prayerIndex] 0..4 (Fajr..Isha). [pre] = pre-prayer reminder.
  static int prayer(DateTime date, int prayerIndex, {bool pre = false}) {
    final slot = (_dayNumber(date) % 9999) * 10 + prayerIndex * 2 + (pre ? 1 : 0);
    return prayerMin + slot % (prayerMax - prayerMin);
  }

  static int azkar(DateTime date, {required bool evening}) =>
      azkarMin + (_dayNumber(date) % 4999) * 2 + (evening ? 1 : 0);

  /// [slot] 0..4 = Thu-Isha, pre-Fajr, sunrise, after-Dhuhr, after-Asr.
  static int friday(DateTime date, int slot) =>
      fridayMin + (_dayNumber(date) % 1999) * 5 + slot;

  static int iqama(DateTime date, int prayerIndex) =>
      iqamaMin + (_dayNumber(date) % 1999) * 5 + prayerIndex;

  static int nudge(DateTime date, int prayerIndex) =>
      nudgeMin + (_dayNumber(date) % 1999) * 5 + prayerIndex;

  /// ON = even, OFF = odd.
  static int mode(DateTime date, int prayerIndex, {required bool off}) =>
      modeMin + (_dayNumber(date) % 999) * 10 + prayerIndex * 2 + (off ? 1 : 0);

  static int get zakatBefore => zakatMin + 1;
  static int get zakatOn => zakatMin + 2;
  static int sleep(DateTime date) => sleepMin + _dayNumber(date) % 999;
  static int weekly(DateTime date) => weeklyMin + (_dayNumber(date) ~/ 7) % 999;

  static bool isZakat(int id) => id >= zakatMin && id <= zakatMax;
  static bool isSleep(int id) => id >= sleepMin && id <= sleepMax;
  static bool isWeekly(int id) => id >= weeklyMin && id <= weeklyMax;

  static bool isIqama(int id) => id >= iqamaMin && id <= iqamaMax;
  static bool isNudge(int id) => id >= nudgeMin && id <= nudgeMax;
  static bool isMode(int id) => id >= modeMin && id <= modeMax;

  static bool isFriday(int id) => id >= fridayMin && id <= fridayMax;
  static bool isPrayer(int id) => id >= prayerMin && id <= prayerMax;
  static bool isQuran(int id) => id >= quranBase && id <= quranMax;
  static bool isAzkar(int id) => id >= azkarMin && id <= azkarMax;
  static bool isManaged(int id) =>
      isPrayer(id) || isQuran(id) || isAzkar(id) || isFriday(id) ||
      isIqama(id) || isNudge(id) || isMode(id) ||
      isZakat(id) || isSleep(id) || isWeekly(id) || legacy.contains(id);

  /// 0..4 for a prayer id (Fajr..Isha).
  static int prayerSlot(int id) => ((id - prayerMin) % 10) ~/ 2;
  static bool isPrePrayer(int id) => ((id - prayerMin) % 10) % 2 == 1;
}
