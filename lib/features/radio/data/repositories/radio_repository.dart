import '../models/radio_model.dart';
import '../../../../core/services/radio_api_service.dart';

class RadioRepository {
  final RadioApiService _apiService;

  RadioRepository({RadioApiService? apiService}) 
      : _apiService = apiService ?? RadioApiService();

  /// Gets a list of available Radios in the specified language.
  Future<List<RadioModel>> getRadios({String language = 'ar'}) async {
    return await _apiService.getRadios(language: language);
  }
}
