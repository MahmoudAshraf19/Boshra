import '../models/reciter_model.dart';
import '../../../../core/services/reciter_api_service.dart';

class ReciterRepository {
  final ReciterApiService _apiService;

  ReciterRepository({ReciterApiService? apiService}) 
      : _apiService = apiService ?? ReciterApiService();

  /// Gets all reciters (can be filtered by language, reciterId, rewayaId, or suraId)
  Future<List<ReciterModel>> getReciters({
    String language = 'ar',
    int? reciterId,
    int? rewayaId,
    int? suraId,
  }) async {
    return await _apiService.getReciters(
      language: language,
      reciterId: reciterId,
      rewayaId: rewayaId,
      suraId: suraId,
    );
  }

  /// Helper: Generate a direct playable audio URL for a specific surah by a specific reciter's moshaf.
  /// Server URL usually ends with '/' and surah number needs to be 3 digits (e.g. '001', '018', '114').
  String getSurahAudioUrl(MoshafModel moshaf, int surahNumber) {
    // Format surah number to 3 digits
    String formattedSurah = surahNumber.toString().padLeft(3, '0');
    
    // Ensure server URL ends with '/'
    String baseUrl = moshaf.server;
    if (!baseUrl.endsWith('/')) {
      baseUrl += '/';
    }
    
    return '$baseUrl$formattedSurah.mp3';
  }
}
