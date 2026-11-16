/// Locale-safe date text WITHOUT `DateFormat` (which throws if the locale data of that language
/// was not initialised — e.g. asking for 'ar' while the app runs in English).
class DateText {
  DateText._();

  static const _monthsAr = [
    'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
    'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
  ];
  static const _monthsEn = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  static const _weekdaysAr = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
  static const _weekdaysEn = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  static String month(int m, bool ar) => (ar ? _monthsAr : _monthsEn)[(m - 1).clamp(0, 11)];
  static String weekday(DateTime d, bool ar) => (ar ? _weekdaysAr : _weekdaysEn)[d.weekday - 1];

  /// "17 يونيو 2026" / "17 June 2026"
  static String date(DateTime d, bool ar) => '${d.day} ${month(d.month, ar)} ${d.year}';

  /// "17 Jun" style short form.
  static String dayMonth(DateTime d, bool ar) => '${d.day} ${month(d.month, ar)}';

  /// "17/6 14:05"
  static String shortStamp(DateTime d) =>
      '${d.day}/${d.month} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}
