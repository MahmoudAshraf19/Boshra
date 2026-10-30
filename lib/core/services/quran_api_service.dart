import '../network/dio_factory.dart';
import '../utils/app_logger.dart';
import 'package:dio/dio.dart';
import '../../features/quran/data/models/quran_models.dart';

class QuranApiService {
  final Dio _dio;

  QuranApiService() : _dio = DioFactory.create() {
    _dio.options.baseUrl = 'https://api.alquran.cloud';
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
  }

  /// Fetches Quran metadata (Surahs list, Juzs, Hizbs)
  Future<QuranMetaModel?> getQuranMetadata() async {
    try {
      final response = await _dio.get('/v1/meta');
      if (response.statusCode == 200 && response.data != null) {
        return QuranMetaModel.fromJson(response.data['data']);
      }
    } catch (e) {
      appLog('Error fetching Quran metadata from API: $e');
    }
    return null;
  }

  /// Fetches a complete Surah by its number and edition.
  /// Example editions: 'quran-uthmani', 'quran-simple'
  Future<SurahModel?> getSurah(int surahNumber, {String edition = 'quran-uthmani'}) async {
    try {
      final response = await _dio.get('/v1/surah/$surahNumber/$edition');
      if (response.statusCode == 200 && response.data != null) {
        return SurahModel.fromJson(response.data['data']);
      }
    } catch (e) {
      appLog('Error fetching surah from API: $e');
    }
    return null;
  }

  /// Fetches a random Ayah.
  Future<AyahModel?> getRandomAyah({String edition = 'quran-uthmani'}) async {
    try {
      final response = await _dio.get('/v1/ayah/random/$edition');
      if (response.statusCode == 200 && response.data != null) {
        return AyahModel.fromJson(response.data['data']);
      }
    } catch (e) {
      appLog('Error fetching random ayah from API: $e');
    }
    return null;
  }

  /// Searches for a word in the Quran.
  /// Language defaults to Arabic ('ar'). For English translations use 'en'.
  Future<SearchResultModel?> search(String keyword, {String language = 'ar'}) async {
    try {
      // The API takes /search/{word}/all/{language}
      // 'all' means all surahs. 
      final response = await _dio.get('/v1/search/${Uri.encodeComponent(keyword)}/all/$language');
      if (response.statusCode == 200 && response.data != null) {
        return SearchResultModel.fromJson(response.data['data']);
      }
    } catch (e) {
      appLog('Error searching Quran API: $e');
    }
    return null;
  }

  /// Fetches general information about a Surah using Wikipedia API.
  Future<String?> getSurahInfo(String surahName, String englishName, String language) async {
    try {
      String url;
      if (language == 'ar' || language == 'ur' || language == 'fa') {
        // Use Arabic Wikipedia for Arabic, Urdu, Persian. 
        // We must strip diacritics (Tashkeel) because Wikipedia URLs don't use them.
        final strippedName = surahName.replaceAll(RegExp(r'[\u064B-\u065F\u0670]'), '').replaceAll('ٱ', 'ا');
        final formattedName = strippedName.replaceAll(' ', '_');
        url = 'https://ar.wikipedia.org/api/rest_v1/page/summary/$formattedName';
      } else {
        // English Wikipedia using englishName, e.g. "Al-Baqara"
        final formattedName = englishName.replaceAll(' ', '_');
        url = 'https://en.wikipedia.org/api/rest_v1/page/summary/$formattedName';
      }
      
      final response = await _dio.get(url);
      if (response.statusCode == 200 && response.data != null) {
        return response.data['extract'];
      }
    } catch (e) {
      appLog('Error fetching surah info from Wikipedia API: $e');
    }
    return null;
  }
}
