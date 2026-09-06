import 'package:dio/dio.dart';
import '../../features/radio/data/models/radio_model.dart';

class RadioApiService {
  final Dio _dio;

  RadioApiService() : _dio = Dio() {
    _dio.options.baseUrl = 'https://data-rosy.vercel.app';
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  /// Fetches the list of all available radios from the new API.
  Future<List<RadioModel>> getRadios({String language = 'ar'}) async {
    try {
      final response = await _dio.get('/radio.json');

      if (response.statusCode == 200 && response.data != null) {
        // The API returns { "radios": [ ... ] } or just a direct array.
        // Based on testing, it returns { "radios": [...] }
        final data = response.data;
        List radiosJson = [];
        if (data is Map && data.containsKey('radios')) {
          radiosJson = data['radios'] as List? ?? [];
        } else if (data is List) {
          radiosJson = data;
        }
        return radiosJson.map((r) => RadioModel.fromJson(r)).toList();
      }
    } catch (e) {
      print('Error fetching radios: $e');
    }
    return [];
  }
}
