import 'package:shared_preferences/shared_preferences.dart';

class HijriDate {
  final int year;
  final int month; // 1..12
  final int day;
  const HijriDate(this.year, this.month, this.day);

  @override
  bool operator ==(Object o) => o is HijriDate && o.year == year && o.month == month && o.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);
}

/// Offline Hijri calendar (tabular / "Kuwaiti" algorithm) calibrated against the date the prayer-times
/// API returns for today (Umm al-Qura), so it matches the date shown on Home. The calibration is a
/// ±2 day shift saved on the device; month lengths follow the tabular rule (29/30).
class HijriCalendar {
  HijriCalendar._();

  static int _adjust = 0;
  static bool _loaded = false;

  static Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    _adjust = (await SharedPreferences.getInstance()).getInt('hijri_adjust') ?? 0;
  }

  static const monthsAr = [
    'محرم', 'صفر', 'ربيع الأول', 'ربيع الآخر', 'جمادى الأولى', 'جمادى الآخرة',
    'رجب', 'شعبان', 'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة',
  ];
  static const monthsEn = [
    'Muharram', 'Safar', "Rabi' al-awwal", "Rabi' al-thani", 'Jumada al-ula', 'Jumada al-akhira',
    'Rajab', "Sha'ban", 'Ramadan', 'Shawwal', "Dhu al-Qi'dah", 'Dhu al-Hijjah',
  ];

  static String monthName(int month, bool ar) => (ar ? monthsAr : monthsEn)[(month - 1).clamp(0, 11)];

  // ---------------------------------------------------------------- calendars maths
  static int _gregorianToJdn(int y, int m, int d) {
    final a = (14 - m) ~/ 12;
    final y2 = y + 4800 - a;
    final m2 = m + 12 * a - 3;
    return d + (153 * m2 + 2) ~/ 5 + 365 * y2 + y2 ~/ 4 - y2 ~/ 100 + y2 ~/ 400 - 32045;
  }

  static DateTime _jdnToGregorian(int jdn) {
    final a = jdn + 32044;
    final b = (4 * a + 3) ~/ 146097;
    final c = a - 146097 * b ~/ 4;
    final d = (4 * c + 3) ~/ 1461;
    final e = c - 1461 * d ~/ 4;
    final m = (5 * e + 2) ~/ 153;
    final day = e - (153 * m + 2) ~/ 5 + 1;
    final month = m + 3 - 12 * (m ~/ 10);
    final year = 100 * b + d - 4800 + m ~/ 10;
    return DateTime(year, month, day);
  }

  static HijriDate _jdnToHijri(int jd) {
    var l = jd - 1948440 + 10632;
    final n = (l - 1) ~/ 10631;
    l = l - 10631 * n + 354;
    final j = ((10985 - l) ~/ 5316) * ((50 * l) ~/ 17719) + (l ~/ 5670) * ((43 * l) ~/ 15238);
    l = l - ((30 - j) ~/ 15) * ((17719 * j) ~/ 50) - (j ~/ 16) * ((15238 * j) ~/ 43) + 29;
    final m = (24 * l) ~/ 709;
    final d = l - (709 * m) ~/ 24;
    final y = 30 * n + j - 30;
    return HijriDate(y, m, d);
  }

  static int _hijriToJdn(int y, int m, int d) =>
      d + (29.5 * (m - 1)).ceil() + (y - 1) * 354 + (3 + 11 * y) ~/ 30 + 1948439;

  // ---------------------------------------------------------------------- public
  static HijriDate fromGregorian(DateTime d) =>
      _jdnToHijri(_gregorianToJdn(d.year, d.month, d.day) + _adjust);

  static DateTime toGregorian(int year, int month, int day) =>
      _jdnToGregorian(_hijriToJdn(year, month, day) - _adjust);

  /// 29 or 30 days (tabular rule).
  static int monthLength(int year, int month) {
    final ny = month == 12 ? year + 1 : year;
    final nm = month == 12 ? 1 : month + 1;
    return _hijriToJdn(ny, nm, 1) - _hijriToJdn(year, month, 1);
  }

  /// Month before / after.
  static (int, int) shift(int year, int month, int delta) {
    final idx = year * 12 + (month - 1) + delta;
    return (idx ~/ 12, idx % 12 + 1);
  }

  /// Calibrates with the Hijri date the API returned for [gregorianToday] ("dd-MM-yyyy").
  static Future<void> calibrate(DateTime gregorianToday, String apiHijriDate) async {
    final m = RegExp(r'^(\d{1,2})-(\d{1,2})-(\d{4})$').firstMatch(apiHijriDate.trim());
    if (m == null) return;
    final d = int.parse(m.group(1)!), mo = int.parse(m.group(2)!), y = int.parse(m.group(3)!);
    if (mo < 1 || mo > 12 || d < 1 || d > 30) return;
    final tab = _jdnToHijri(_gregorianToJdn(gregorianToday.year, gregorianToday.month, gregorianToday.day));
    final diff = _hijriToJdn(y, mo, d) - _hijriToJdn(tab.year, tab.month, tab.day);
    final adj = diff.clamp(-2, 2);
    if (adj != _adjust) {
      _adjust = adj;
      await (await SharedPreferences.getInstance()).setInt('hijri_adjust', adj);
    }
  }
}
