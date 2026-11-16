import 'dart:math' as math;
import '../../features/prayer/data/models/prayer_times_model.dart';

/// Offline prayer-time calculation (astronomical algorithm, same maths as PrayTimes.org).
///
/// Used ONLY when the Aladhan API is unreachable, so the Adhan is never lost because the
/// phone had no internet at the moment the schedule was built. Accuracy is within ~1-2
/// minutes of the API for the supported methods.
class LocalPrayerCalculator {
  LocalPrayerCalculator._();

  // method id (Aladhan numbering) → [fajr angle, isha angle, isha minutes after maghrib (0 = use angle)]
  static const Map<int, List<double>> _methods = {
    5: [19.5, 17.5, 0], // Egyptian General Authority of Survey
    4: [18.5, 0, 90], // Umm Al-Qura
    3: [18, 17, 0], // Muslim World League
    2: [15, 15, 0], // ISNA
    1: [18, 18, 0], // Karachi
    8: [19.5, 0, 90], // Gulf
    9: [18, 0, 90], // Kuwait
    10: [18, 0, 90], // Qatar
    13: [18, 17, 0], // Diyanet
    23: [18, 18, 0], // Jordan
    21: [19.1, 17, 0], // Morocco
    19: [18, 17, 0], // Algeria
    18: [18, 18, 0], // Tunisia
  };

  static double _rad(double d) => d * math.pi / 180;
  static double _deg(double r) => r * 180 / math.pi;
  static double _sin(double d) => math.sin(_rad(d));
  static double _cos(double d) => math.cos(_rad(d));
  static double _tan(double d) => math.tan(_rad(d));
  static double _fixAngle(double a) => (a - 360 * (a / 360).floor());
  static double _fixHour(double a) => (a - 24 * (a / 24).floor());

  static double _julian(int y, int m, int d) {
    if (m <= 2) {
      y -= 1;
      m += 12;
    }
    final a = (y / 100).floor();
    final b = 2 - a + (a / 4).floor();
    return (365.25 * (y + 4716)).floor() + (30.6001 * (m + 1)).floor() + d + b - 1524.5;
  }

  /// returns [declination, equation of time]
  static List<double> _sun(double jd) {
    final d = jd - 2451545.0;
    final g = _fixAngle(357.529 + 0.98560028 * d);
    final q = _fixAngle(280.459 + 0.98564736 * d);
    final l = _fixAngle(q + 1.915 * _sin(g) + 0.020 * _sin(2 * g));
    final e = 23.439 - 0.00000036 * d;
    final ra = _deg(math.atan2(_cos(e) * _sin(l), _cos(l))) / 15;
    final eqt = q / 15 - _fixHour(ra);
    final decl = _deg(math.asin(_sin(e) * _sin(l)));
    return [decl, eqt];
  }

  /// Computes the five prayers (+ sunrise/sunset) for [date] at [lat]/[lng].
  /// [tzHours] = UTC offset of the device for that date.
  static PrayerTimesModel compute({
    required DateTime date,
    required double lat,
    required double lng,
    required int method,
    int school = 0,
  }) {
    final cfg = _methods[method] ?? _methods[3]!;
    final tz = DateTime(date.year, date.month, date.day, 12).timeZoneOffset.inMinutes / 60.0;
    final jd = _julian(date.year, date.month, date.day) - lng / (15 * 24);

    double midDay(double t) => _fixHour(12 - _sun(jd + t)[1]);

    double angleTime(double angle, double t, {bool ccw = false}) {
      final decl = _sun(jd + t)[0];
      final noon = midDay(t);
      final x = (-_sin(angle) - _sin(decl) * _sin(lat)) / (_cos(decl) * _cos(lat));
      if (x < -1 || x > 1) return double.nan;
      final h = _deg(math.acos(x)) / 15;
      return noon + (ccw ? -h : h);
    }

    double asrTime(double factor, double t) {
      final decl = _sun(jd + t)[0];
      final a = -_deg(math.atan(1 / (factor + _tan((lat - decl).abs()))));
      return angleTime(a, t);
    }

    final fajr = angleTime(cfg[0], 5 / 24, ccw: true);
    final sunrise = angleTime(0.833, 6 / 24, ccw: true);
    final dhuhr = midDay(12 / 24);
    final asr = asrTime(school == 1 ? 2 : 1, 13 / 24);
    final sunset = angleTime(0.833, 18 / 24);
    final maghrib = sunset;
    final isha = cfg[2] > 0 ? maghrib + cfg[2] / 60 : angleTime(cfg[1], 18 / 24);

    final adj = tz - lng / 15;
    String fmt(double t) {
      if (t.isNaN) return '--:--';
      var v = _fixHour(t + adj + 0.5 / 60); // round to nearest minute
      final h = v.floor();
      final m = ((v - h) * 60).floor();
      return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
    }

    final dayStr = date.day.toString().padLeft(2, '0');
    return PrayerTimesModel(
      timings: Timings(
        fajr: fmt(fajr),
        sunrise: fmt(sunrise),
        dhuhr: fmt(dhuhr + 1 / 60), // +1 min safety after zenith (standard)
        asr: fmt(asr),
        sunset: fmt(sunset),
        maghrib: fmt(maghrib + 1 / 60),
        isha: fmt(isha),
        imsak: fmt(fajr - 10 / 60),
        midnight: '',
        firstThird: '',
        lastThird: '',
      ),
      dateInfo: DateInfo(
        readable: '',
        hijri: HijriDate(
            date: '', format: '', day: '', year: '', monthAr: '', monthEn: '', weekdayAr: '', weekdayEn: ''),
        gregorian: GregorianDate(
            date: '$dayStr-${date.month.toString().padLeft(2, '0')}-${date.year}',
            format: 'DD-MM-YYYY',
            day: dayStr,
            year: '${date.year}',
            monthEn: '',
            weekdayEn: ''),
      ),
      meta: Meta(timezone: '', method: 'Local calculation'),
    );
  }
}
