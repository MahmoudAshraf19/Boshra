import '../network/dio_factory.dart';
import '../utils/app_logger.dart';
import 'package:dio/dio.dart';
import '../../features/prayer/data/models/prayer_times_model.dart';
import 'package:intl/intl.dart';

class PrayerApiService {
  final Dio _dio;

  PrayerApiService() : _dio = DioFactory.create() {
    _dio.options.baseUrl = 'https://api.aladhan.com';
    _dio.options.connectTimeout = const Duration(seconds: 12);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  /// GET with 3 attempts (a single dropped packet used to mean "no prayer times at all").
  Future<Response<dynamic>?> _get(String path, Map<String, dynamic> q) async {
    for (var attempt = 1; attempt <= 3; attempt++) {
      try {
        final r = await _dio.get(path, queryParameters: q);
        if (r.statusCode == 200 && r.data != null) return r;
      } catch (e) {
        appLog('Prayer API attempt $attempt failed: $e');
      }
      if (attempt < 3) await Future.delayed(Duration(seconds: attempt * 2));
    }
    return null;
  }

  Future<PrayerTimesModel?> getPrayerTimes({
    required double latitude,
    required double longitude,
    dynamic method = 'auto',
  }) async {
    try {
      final dateStr = DateFormat('dd-MM-yyyy').format(DateTime.now());
      final r = await _get('/v1/timings/$dateStr', {
        'latitude': latitude,
        'longitude': longitude,
        if (method != 'auto') 'method': method,
      });
      if (r == null) return null;
      return PrayerTimesModel.fromJson(r.data['data']);
    } catch (e) {
      appLog('Error parsing prayer times: $e');
      return null;
    }
  }

  Future<List<PrayerTimesModel>> getPrayerCalendar({
    required double latitude,
    required double longitude,
    required int month,
    required int year,
    dynamic method = 'auto',
    int school = 0,
  }) async {
    try {
      final r = await _get('/v1/calendar', {
        'latitude': latitude,
        'longitude': longitude,
        if (method != 'auto') 'method': method,
        'school': school,
        'month': month,
        'year': year,
      });
      if (r == null) return [];
      final List<dynamic> data = r.data['data'];
      return data.map((json) => PrayerTimesModel.fromJson(json)).toList();
    } catch (e) {
      appLog('Error parsing prayer calendar: $e');
      return [];
    }
  }
}
