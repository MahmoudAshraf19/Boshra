import '../network/dio_factory.dart';
import '../utils/app_logger.dart';
import 'package:dio/dio.dart';

class HijriDateModel {
  final String date;
  final String day;
  final String monthAr;
  final String monthEn;
  final String year;
  final String weekdayAr;
  final String weekdayEn;

  HijriDateModel({
    required this.date,
    required this.day,
    required this.monthAr,
    required this.monthEn,
    required this.year,
    required this.weekdayAr,
    required this.weekdayEn,
  });

  factory HijriDateModel.fromJson(Map<String, dynamic> json) {
    return HijriDateModel(
      date: json['date'] ?? '',
      day: json['day'] ?? '',
      monthAr: json['month']?['ar'] ?? '',
      monthEn: json['month']?['en'] ?? '',
      year: json['year'] ?? '',
      weekdayAr: json['weekday']?['ar'] ?? '',
      weekdayEn: json['weekday']?['en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'day': day,
      'year': year,
      'month': {
        'ar': monthAr,
        'en': monthEn,
      },
      'weekday': {
        'ar': weekdayAr,
        'en': weekdayEn,
      },
    };
  }
}

class HijriApiService {
  final Dio _dio;

  HijriApiService() : _dio = DioFactory.create() {
    _dio.options.baseUrl = 'https://api.aladhan.com';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
  }

  /// Converts a specific Gregorian date to Hijri.
  /// Date format should be DD-MM-YYYY
  Future<HijriDateModel?> convertDate(String dateStr) async {
    try {
      final response = await _dio.get('/v1/gToH/$dateStr');
      if (response.statusCode == 200 && response.data != null) {
        return HijriDateModel.fromJson(response.data['data']['hijri']);
      }
    } catch (e) {
      appLog('Error converting date: $e');
    }
    return null;
  }
}
