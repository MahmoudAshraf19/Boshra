import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/services/location_service.dart';
import '../../../prayer/data/models/prayer_times_model.dart';
import '../../../prayer/data/repositories/prayer_repository.dart';
import '../../../prayer/domain/prayer_scheduler_service.dart';
import '../../../../core/services/hijri_api_service.dart';
import '../../../../core/services/quran_api_service.dart';
import '../../../quran/data/models/quran_models.dart';

class HomeController extends ChangeNotifier {
  final PrayerRepository _prayerRepo = PrayerRepository();
  final LocationService _locationService = LocationService();
  final HijriApiService _hijriService = HijriApiService();
  final QuranApiService _quranService = QuranApiService();

  PrayerTimesModel? prayerTimes;
  HijriDateModel? hijriDate;
  AyahModel? dailyAyah;
  String locationName = '...';
  bool isLoading = true;

  String nextPrayerName = '';
  Duration timeUntilNextPrayer = Duration.zero;
  Timer? _timer;

  HomeController() {
    _init();
  }

  Future<void> _init() async {
    // 1. Load instantly from cache
    await _loadFromCache();
    
    // 2. Show UI immediately
    isLoading = false;
    notifyListeners();
    
    // 3. Start Timer for next prayer countdown
    if (prayerTimes != null) {
      _calculateNextPrayer();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _calculateNextPrayer();
      });
    }

    // 4. Fetch fresh data in background
    _syncDataInBackground();
  }

  Future<void> _loadFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load location name
    locationName = prefs.getString('cached_location_name') ?? '...';
    
    // Load Prayer Times (uses its own cache)
    prayerTimes = await _prayerRepo.getTodayPrayerTimes(skipLocationFetch: true);
    
    // Load Hijri Date
    final cachedHijri = prefs.getString('cached_hijri_date');
    if (cachedHijri != null) {
      try {
        hijriDate = HijriDateModel.fromJson(json.decode(cachedHijri));
      } catch (_) {}
    }

    // Load Ayah of the day
    await _fetchAyahOfTheDay(fromCacheOnly: true);
  }

  Future<void> _syncDataInBackground() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 1. Fetch Location
    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        final name = await _locationService.getLocationName(position.latitude, position.longitude);
        if (name != null) {
          locationName = name;
          prefs.setString('cached_location_name', name);
        }
        PrayerSchedulerService().schedulePrayersForNextDays(3);
      } else {
        if (locationName == '...') locationName = 'Makkah (Default)';
        PrayerSchedulerService().schedulePrayersForNextDays(3);
      }
    } catch (e) {
      print('Location sync error: $e');
      if (locationName == '...') locationName = 'Makkah (Default)';
      PrayerSchedulerService().schedulePrayersForNextDays(3);
    }
    
    // 2. Fetch Prayer Times fresh (now with location)
    prayerTimes = await _prayerRepo.getTodayPrayerTimes();
    
    // 3. Fetch Hijri Date
    final todayStr = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final newHijri = await _hijriService.convertDate(todayStr);
    if (newHijri != null) {
      hijriDate = newHijri;
      prefs.setString('cached_hijri_date', json.encode(hijriDate!.toJson()));
    }

    // 4. Fetch Ayah of the day (network if needed)
    await _fetchAyahOfTheDay(fromCacheOnly: false);
    
    notifyListeners();
    
    if (_timer == null && prayerTimes != null) {
      _calculateNextPrayer();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _calculateNextPrayer();
      });
    }
  }

  void _calculateNextPrayer() {
    if (prayerTimes == null) return;

    final now = DateTime.now();
    final DateFormat format = DateFormat('HH:mm');
    
    final timings = prayerTimes!.timings;
    
    // Map prayer names to their times
    final Map<String, String> prayers = {
      'Fajr': timings.fajr,
      'Dhuhr': timings.dhuhr,
      'Asr': timings.asr,
      'Maghrib': timings.maghrib,
      'Isha': timings.isha,
    };

    DateTime? nextPrayerTime;
    String nextName = '';

    for (var entry in prayers.entries) {
      // Parse the time string (e.g. "05:30")
      final parts = entry.value.split(':');
      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]) ?? 0;
        final min = int.tryParse(parts[1].split(' ')[0]) ?? 0; // split space to handle '05:30 (EEST)' if present
        
        final prayerTime = DateTime(now.year, now.month, now.day, hour, min);
        
        if (prayerTime.isAfter(now)) {
          nextPrayerTime = prayerTime;
          nextName = entry.key;
          break;
        }
      }
    }

    // If all prayers today have passed, the next prayer is Fajr tomorrow
    if (nextPrayerTime == null) {
      final parts = timings.fajr.split(':');
      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]) ?? 0;
        final min = int.tryParse(parts[1].split(' ')[0]) ?? 0;
        
        // Add 1 day
        nextPrayerTime = DateTime(now.year, now.month, now.day + 1, hour, min);
        nextName = 'Fajr';
      }
    }

    if (nextPrayerTime != null) {
      nextPrayerName = nextName;
      timeUntilNextPrayer = nextPrayerTime.difference(now);
      notifyListeners();
    }
  }

  Future<void> _fetchAyahOfTheDay({bool fromCacheOnly = false}) async {
    final now = DateTime.now();
    int fajrHour = 5;
    int fajrMin = 0;
    
    if (prayerTimes != null) {
      final fajrTimeStr = prayerTimes!.timings.fajr.split(' ')[0];
      final parts = fajrTimeStr.split(':');
      fajrHour = int.tryParse(parts[0]) ?? 5;
      fajrMin = int.tryParse(parts[1]) ?? 0;
    }
    
    final fajrDateTime = DateTime(now.year, now.month, now.day, fajrHour, fajrMin);
    
    DateTime ayahDay = now;
    if (now.isBefore(fajrDateTime)) {
      ayahDay = now.subtract(const Duration(days: 1));
    }
    
    final dayKey = 'ayah_of_day_${ayahDay.year}_${ayahDay.month}_${ayahDay.day}';
    final prefs = await SharedPreferences.getInstance();
    
    final cachedAyahJson = prefs.getString(dayKey);
    if (cachedAyahJson != null) {
      try {
        final decoded = json.decode(cachedAyahJson);
        dailyAyah = AyahModel.fromJson(decoded);
        return;
      } catch (e) {
        debugPrint('Error decoding cached Ayah: $e');
      }
    }
    
    if (fromCacheOnly) return;
    
    // Fetch new Ayah if not cached
    final newAyah = await _quranService.getRandomAyah();
    if (newAyah != null) {
      dailyAyah = newAyah;
      prefs.setString(dayKey, json.encode(newAyah.toJson()));
    }
  }

  String get formattedCountdown {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(timeUntilNextPrayer.inHours);
    final minutes = twoDigits(timeUntilNextPrayer.inMinutes.remainder(60));
    final seconds = twoDigits(timeUntilNextPrayer.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
