import 'package:dio/dio.dart';
import '../../features/prayer/data/models/prayer_times_model.dart';
import 'package:intl/intl.dart';

class PrayerApiService {
  final Dio _dio;
  
  PrayerApiService() : _dio = Dio() {
    _dio.options.baseUrl = 'https://api.aladhan.com/v1';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  /// Fetch prayer times by latitude and longitude for today's date.
  /// Note: The default method 5 (Egyptian General Authority) can be changed or set to auto (e.g. method=auto).
  Future<PrayerTimesModel?> getPrayerTimes({
    required double latitude,
    required double longitude,
    dynamic method = 'auto', // Default calculation method auto-detect based on location
  }) async {
    try {
      // Get today's date formatted as DD-MM-YYYY
      final DateTime now = DateTime.now();
      final String dateStr = DateFormat('dd-MM-yyyy').format(now);

      final response = await _dio.get(
        '/timings/$dateStr',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          if (method != 'auto') 'method': method,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        return PrayerTimesModel.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error fetching prayer times: $e');
      return null;
    }
  }

  /// Fetch prayer times for an entire month
  Future<List<PrayerTimesModel>> getPrayerCalendar({
    required double latitude,
    required double longitude,
    required int month,
    required int year,
    dynamic method = 'auto', 
  }) async {
    try {
      final response = await _dio.get(
        '/calendar',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          if (method != 'auto') 'method': method,
          'month': month,
          'year': year,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => PrayerTimesModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching prayer calendar: $e');
      return [];
    }
  }
}
