import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer_times_model.dart';
import '../../../../core/services/local_prayer_calculator.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/prayer_api_service.dart';
import '../../../../core/utils/app_logger.dart';
import '../../domain/prayer_settings.dart';

class PrayerRepository {
  final LocationService _locationService;
  final PrayerApiService _apiService;

  PrayerRepository({
    LocationService? locationService,
    PrayerApiService? apiService,
  })  : _locationService = locationService ?? LocationService(),
        _apiService = apiService ?? PrayerApiService();

  /// Today's times AS THE USER CONFIGURED THEM (calculation method, Asr school and the
  /// ±minutes fine-tune), so Home shows exactly the time the notification fires at.
  /// The scheduler uses [getPrayerTimesForDate] (raw) and applies the offsets itself.
  Future<PrayerTimesModel?> getTodayPrayerTimes({bool skipLocationFetch = false}) async {
    final st = await PrayerSettings.load();
    final raw = await getPrayerTimesForDate(DateTime.now(),
        skipLocationFetch: skipLocationFetch, method: st.calcMethod, school: st.asrSchool);
    if (raw == null) return null;
    return withOffsets(raw, st.offsets);
  }

  /// "04:58" / "04:58 (EET)" shifted by [minutes]; unparsable values are returned unchanged.
  static String _shift(String raw, int minutes) {
    if (minutes == 0) return raw;
    final m = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
    if (m == null) return raw;
    var total = int.parse(m.group(1)!) * 60 + int.parse(m.group(2)!) + minutes;
    total = ((total % 1440) + 1440) % 1440;
    final hh = (total ~/ 60).toString().padLeft(2, '0');
    final mm = (total % 60).toString().padLeft(2, '0');
    return raw.replaceFirst(m.group(0)!, '$hh:$mm');
  }

  static PrayerTimesModel withOffsets(PrayerTimesModel m, List<int> o) {
    if (o.every((v) => v == 0)) return m;
    final t = m.timings;
    return PrayerTimesModel(
      timings: Timings(
        fajr: _shift(t.fajr, o[0]),
        sunrise: t.sunrise,
        dhuhr: _shift(t.dhuhr, o[1]),
        asr: _shift(t.asr, o[2]),
        sunset: t.sunset,
        maghrib: _shift(t.maghrib, o[3]),
        isha: _shift(t.isha, o[4]),
        imsak: t.imsak,
        midnight: t.midnight,
        firstThird: t.firstThird,
        lastThird: t.lastThird,
      ),
      dateInfo: m.dateInfo,
      meta: m.meta,
    );
  }

  /// Offline mode: keeps the current + next 2 months cached for the current location/method,
  /// at most once every 12 h, and deletes months that are over. Never throws, never blocks UI.
  Future<void> prefetchMonths() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final last = prefs.getInt('prefetch_ms') ?? 0;
      final now = DateTime.now();
      if (now.millisecondsSinceEpoch - last < const Duration(hours: 12).inMilliseconds) return;
      final st = await PrayerSettings.load();
      var ok = true;
      for (var i = 0; i < 3; i++) {
        final d = DateTime(now.year, now.month + i, 15);
        final before = prefs.getKeys().where((k) => k.startsWith('prayer_times_v5_')).length;
        final m = await getPrayerTimesForDate(d,
            savedLocationOnly: true, method: st.calcMethod, school: st.asrSchool);
        final after = (await SharedPreferences.getInstance())
            .getKeys().where((k) => k.startsWith('prayer_times_v5_')).length;
        // a model came back but nothing new was cached and it is not already cached → API was down
        if (m != null && m.meta.method == 'Local calculation') ok = false;
        appLog('prefetch month ${d.month}/${d.year}: cache $before→$after');
      }
      if (ok) await prefs.setInt('prefetch_ms', now.millisecondsSinceEpoch);
      // cleanup: months before the current one
      for (final k in prefs.getKeys().where((k) => k.startsWith('prayer_times_v5_')).toList()) {
        final parts = k.split('_');
        if (parts.length < 2) continue;
        final y = int.tryParse(parts.last);
        final mo = int.tryParse(parts[parts.length - 2]);
        if (y == null || mo == null) continue;
        if (DateTime(y, mo).isBefore(DateTime(now.year, now.month))) await prefs.remove(k);
      }
    } catch (e, s) {
      AppLogger.e('PrayerRepo', e, s, 'prefetch');
    }
  }

  /// Number of cached months for the current setup (Diagnostics: "offline ready for N months").
  Future<int> cachedMonthsCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().where((k) => k.startsWith('prayer_times_v5_')).length;
  }

  // Location memo: avoids a GPS fix per scheduled day (30+ calls in a loop).
  static ResolvedLocation? _memo;
  static DateTime? _memoAt;

  /// Forget the memo (user picked a city / moved / granted permission).
  static void invalidateLocation() {
    _memo = null;
    _memoAt = null;
  }

  Future<ResolvedLocation> _resolve(SharedPreferences prefs, bool cacheOnly) async {
    final m = _memo;
    if (m != null && _memoAt != null) {
      // a default city is only memoised briefly so a later GPS fix is picked up quickly
      final ttl = m.isReal ? const Duration(minutes: 10) : const Duration(seconds: 30);
      if (DateTime.now().difference(_memoAt!) < ttl) return m;
    }
    final r = await _locationService.resolve(allowGps: !cacheOnly);
    await prefs.setBool('prayer_location_fallback', !r.isReal);
    await prefs.setString('prayer_location_source', r.source.name);
    _memo = r;
    _memoAt = DateTime.now();
    return r;
  }

  /// Returns PrayerTimesModel for a specific date. The month is cached PER LOCATION
  /// and PER METHOD. Order: cache → Aladhan API (3 tries) → offline calculation, so a
  /// day is never left without prayer times just because the network was down.
  Future<PrayerTimesModel?> getPrayerTimesForDate(DateTime date,
      {bool skipLocationFetch = false,
      bool savedLocationOnly = false,
      int method = -1,
      int school = 0}) async {
    final prefs = await SharedPreferences.getInstance();
    final c = await _resolve(prefs, skipLocationFetch || savedLocationOnly);
    final effMethod = method >= 0 ? method : LocationService.suggestMethod(c.lat, c.lng);
    final locKey = '${c.lat.toStringAsFixed(2)}_${c.lng.toStringAsFixed(2)}';
    final cacheKey = 'prayer_times_v5_${locKey}_m${effMethod}_s${school}_${date.month}_${date.year}';

    PrayerTimesModel? pick(List<PrayerTimesModel> models) {
      for (final m in models) {
        if (int.tryParse(m.dateInfo.gregorian.day) == date.day) return m;
      }
      return null;
    }

    final cached = prefs.getString(cacheKey);
    if (cached != null) {
      try {
        final hit = pick((jsonDecode(cached) as List)
            .map((j) => PrayerTimesModel.fromJson(j)).toList());
        if (hit != null) return hit;
      } catch (e, s) {
        AppLogger.e('PrayerRepo', e, s, 'bad cache, refetching');
        await prefs.remove(cacheKey);
      }
    }

    if (skipLocationFetch) return null; // cache-only fast path (Home first paint)

    final models = await _apiService.getPrayerCalendar(
      latitude: c.lat, longitude: c.lng, month: date.month, year: date.year,
      method: effMethod < 0 ? 'auto' : effMethod, school: school);

    if (models.isNotEmpty) {
      await prefs.setString(cacheKey, jsonEncode(models.map((m) => m.toJson()).toList()));
      // Drop legacy caches (v2-v4) once.
      for (final k in prefs.getKeys()
          .where((k) => k.startsWith('prayer_times_v2_') ||
              k.startsWith('prayer_times_v3_') || k.startsWith('prayer_times_v4_'))
          .toList()) {
        await prefs.remove(k);
      }
      final hit = pick(models);
      if (hit != null) return hit;
    }

    // Offline fallback: never cached, so the API is retried on the next run.
    AppLogger.w('PrayerRepo', 'API unavailable → offline calculation for $date');
    return LocalPrayerCalculator.compute(
      date: date,
      lat: c.lat,
      lng: c.lng,
      method: effMethod < 0 ? 3 : effMethod,
      school: school,
    );
  }
}
