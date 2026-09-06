import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/prayer_times_model.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/prayer_api_service.dart';

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

  /// Returns PrayerTimesModel for a specific date, attempting to fetch a full month from API if not cached
  Future<PrayerTimesModel?> getPrayerTimesForDate(DateTime date, {bool skipLocationFetch = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'prayer_times_${date.month}_${date.year}';

    // 1. Check cache first
    final cachedData = prefs.getString(cacheKey);
    if (cachedData != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(cachedData);
        final models = jsonList.map((j) => PrayerTimesModel.fromJson(j)).toList();
        
        // Find the exact day
        final dayModel = models.firstWhere((m) {
          return int.parse(m.dateInfo.gregorian.day) == date.day;
        }, orElse: () => throw Exception('Day not found'));
        
        return dayModel;
      } catch (e) {
        print('Error reading from cache: $e');
      }
    }

    // 2. If not in cache or error, fetch from API
    if (skipLocationFetch) return null; // Fast path for cache-only loading
    
    var position = await _locationService.getCurrentLocation();
    
    // Fallback to Makkah if location is unavailable
    double lat = position?.latitude ?? 21.4225;
    double lng = position?.longitude ?? 39.8262;

    final models = await _apiService.getPrayerCalendar(
      latitude: lat,
      longitude: lng,
      month: date.month,
      year: date.year,
    );

    if (models.isNotEmpty) {
      // Save to cache
      final jsonList = models.map((m) => m.toJson()).toList();
      await prefs.setString(cacheKey, jsonEncode(jsonList));

      // Find the exact day
      try {
        final dayModel = models.firstWhere((m) {
          return int.parse(m.dateInfo.gregorian.day) == date.day;
        });
        return dayModel;
      } catch (e) {
        return null;
      }
    }

    return null;
  }
}
