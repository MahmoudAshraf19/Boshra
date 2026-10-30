import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer_times_model.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/prayer_api_service.dart';
import '../../../../core/utils/app_logger.dart';

class PrayerRepository {
  final LocationService _locationService;
  final PrayerApiService _apiService;

  PrayerRepository({
    LocationService? locationService,
    PrayerApiService? apiService,
  })  : _locationService = locationService ?? LocationService(),
        _apiService = apiService ?? PrayerApiService();

  Future<PrayerTimesModel?> getTodayPrayerTimes({bool skipLocationFetch = false}) async {
    final now = DateTime.now();
    final times = await getPrayerTimesForDate(now, skipLocationFetch: skipLocationFetch);
    return times;
  }

  // Location memo: avoids a GPS fix per scheduled day (30+ calls in a loop).
  static ({double lat, double lng})? _memoCoords;
  static DateTime? _memoAt;
  static const _makkah = (lat: 21.4225, lng: 39.8262);

  Future<({double lat, double lng})> _resolveCoords(SharedPreferences prefs, bool skipFetch) async {
    // skipFetch → use the last saved coordinates (never touches GPS).
    if (skipFetch) {
      final lat = prefs.getDouble('last_latitude');
      final lng = prefs.getDouble('last_longitude');
      return (lat != null && lng != null) ? (lat: lat, lng: lng) : _makkah;
    }
    if (_memoCoords != null && _memoAt != null &&
        DateTime.now().difference(_memoAt!) < const Duration(minutes: 10)) {
      return _memoCoords!;
    }
    final pos = await _locationService.getCurrentLocation();
    final c = pos != null ? (lat: pos.latitude, lng: pos.longitude) : _makkah;
    _memoCoords = c;
    _memoAt = DateTime.now();
    return c;
  }

  /// Returns PrayerTimesModel for a specific date. The month is cached PER LOCATION
  /// (the old key ignored location, so travelling showed the wrong city's times).
  Future<PrayerTimesModel?> getPrayerTimesForDate(DateTime date,
      {bool skipLocationFetch = false, bool savedLocationOnly = false}) async {
    final prefs = await SharedPreferences.getInstance();
    // savedLocationOnly: background tasks use the last known coordinates but may still
    // call the API (skipLocationFetch = cache-only).
    final c = await _resolveCoords(prefs, skipLocationFetch || savedLocationOnly);
    final locKey = '${c.lat.toStringAsFixed(2)}_${c.lng.toStringAsFixed(2)}';
    final cacheKey = 'prayer_times_v3_${locKey}_${date.month}_${date.year}';

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

    if (skipLocationFetch) return null; // cache-only fast path

    final models = await _apiService.getPrayerCalendar(
      latitude: c.lat, longitude: c.lng, month: date.month, year: date.year);
    if (models.isEmpty) return null;

    await prefs.setString(cacheKey, jsonEncode(models.map((m) => m.toJson()).toList()));
    // Drop the legacy location-less caches (v2) once.
    for (final k in prefs.getKeys().where((k) => k.startsWith('prayer_times_v2_')).toList()) {
      await prefs.remove(k);
    }
    return pick(models);
  }
}
