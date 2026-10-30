import '../network/dio_factory.dart';
import '../utils/app_logger.dart';
import 'package:dio/dio.dart';
import '../../features/reciter/data/models/reciter_model.dart';

class ReciterApiService {
  final Dio _dio;

  ReciterApiService() : _dio = DioFactory.create() {
    _dio.options.baseUrl = 'https://mp3quran.net';
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  /// Fetches the list of all available reciters with various filter options.
  Future<List<ReciterModel>> getReciters({
    String language = 'ar',
    int? reciterId,
    int? rewayaId,
    int? suraId,
  }) async {
    try {
      final queryParams = <String, dynamic>{'language': language};
      
      if (reciterId != null) queryParams['reciter'] = reciterId;
      if (rewayaId != null) queryParams['rewaya'] = rewayaId;
      if (suraId != null) queryParams['sura'] = suraId;

      final response = await _dio.get('/api/v3/reciters', queryParameters: queryParams);

      if (response.statusCode == 200 && response.data != null) {
        final recitersJson = response.data['reciters'] as List? ?? [];
        return recitersJson.map((r) => ReciterModel.fromJson(r)).toList();
      }
    } catch (e) {
      appLog('Error fetching reciters: $e');
    }
    return [];
  }
}
