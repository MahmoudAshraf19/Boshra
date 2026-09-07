import '../models/quran_models.dart';
import '../../../../core/services/quran_api_service.dart';
import '../../../../core/services/quran_local_service.dart';
import '../../../../core/services/tafsir_api_service.dart';
class QuranRepository {
  final QuranApiService _apiService;
  final QuranLocalService _localService;
  final TafsirApiService _tafsirApiService;

  QuranRepository({
    QuranApiService? apiService,
    QuranLocalService? localService,
    TafsirApiService? tafsirApiService,
  })  : _apiService = apiService ?? QuranApiService(),
        _localService = localService ?? QuranLocalService(),
        _tafsirApiService = tafsirApiService ?? TafsirApiService();

  /// Fetches Quran metadata (Surahs, Juzs, Hizbs).
  /// Checks local cache first, if not found fetches from API and caches it.
  Future<QuranMetaModel?> getQuranMetadata() async {
    // 1. Check local cache
    final localMeta = await _localService.getMetadata();
    if (localMeta != null && localMeta.surahs.isNotEmpty && localMeta.juzs.isNotEmpty) {
      return localMeta;
    }

    // 2. Fetch from API
    final apiMeta = await _apiService.getQuranMetadata();
    
    // 3. Save to cache
    if (apiMeta != null && apiMeta.surahs.isNotEmpty) {
      await _localService.saveMetadata(apiMeta);
    }
    
    return apiMeta;
  }

  /// Gets a Surah. Checks local cache first, if not found fetches from API.
  /// If [saveToCache] is true, it will explicitly save the fetched Surah locally.
  Future<SurahModel?> getSurah(int surahNumber, {bool useUthmani = true, bool saveToCache = false}) async {
    final edition = useUthmani ? 'quran-uthmani' : 'quran-simple';

    // 1. Check local cache
    final localSurah = await _localService.getSurah(surahNumber, edition);
    if (localSurah != null) {
      return localSurah;
    }

    // 2. If not in cache, fetch from API
    final apiSurah = await _apiService.getSurah(surahNumber, edition: edition);
    
    // 3. Save to cache ONLY if explicitly requested (e.g. from Download button)
    if (apiSurah != null && saveToCache) {
      await _localService.saveSurah(apiSurah, edition);
    }

    return apiSurah;
  }

  /// Get a set of all currently downloaded (cached) Surah numbers.
  Future<Set<int>> getDownloadedSurahs({bool useUthmani = true}) async {
    final edition = useUthmani ? 'quran-uthmani' : 'quran-simple';
    return await _localService.getCachedSurahs(edition);
  }

  /// Gets a random Ayah. Always fetches fresh from API.
  Future<AyahModel?> getRandomAyah({bool useUthmani = true}) async {
    final edition = useUthmani ? 'quran-uthmani' : 'quran-simple';
    return await _apiService.getRandomAyah(edition: edition);
  }

  /// Gets a Surah in a specific language translation (e.g. 'en.asad').
  Future<SurahModel?> getSurahTranslation(int surahNumber, String translationEdition) async {
    // Check cache first
    final localSurah = await _localService.getSurah(surahNumber, translationEdition);
    if (localSurah != null) return localSurah;

    // Fetch from API
    final apiSurah = await _apiService.getSurah(surahNumber, edition: translationEdition);
    if (apiSurah != null) {
      await _localService.saveSurah(apiSurah, translationEdition);
    }
    return apiSurah;
  }

  /// Gets a Surah as an audio edition (e.g. 'ar.alafasy') to get the audio links for each Ayah.
  Future<SurahModel?> getSurahAudio(int surahNumber, String reciterEdition) async {
    // Audio links might change or expire, but generally we can cache them or fetch fresh.
    // For safety, let's fetch fresh for audio URLs.
    return await _apiService.getSurah(surahNumber, edition: reciterEdition);
  }

  /// Searches for a keyword in the Quran.
  Future<SearchResultModel?> search(String keyword, {String language = 'ar'}) async {
    return await _apiService.search(keyword, language: language);
  }

  /// Gets Tafsir for a specific Ayah
  Future<String?> getAyahTafsir(int surahNumber, int ayahNumberInSurah, String editionKey, bool isUmmahApi) async {
    return await _tafsirApiService.getAyahTafsir(surahNumber, ayahNumberInSurah, editionKey, isUmmahApi);
  }
}
