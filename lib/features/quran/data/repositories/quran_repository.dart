import 'dart:async';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quran_models.dart';
import '../quran_hizb_service.dart';
import '../quran_meta.dart';
import '../quran_text_source.dart';
import '../audio/audio_download_manager.dart';
import '../../../../core/services/quran_api_service.dart';
import '../../../../core/services/quran_local_service.dart';
import '../../../../core/services/tafsir_api_service.dart';

/// Two clearly separated responsibilities:
///
///  1. BROWSE / READ  → [getSurahSync], [getQuranMetadata]
///     Instant and always offline: the text ships with the app.
///     Never touches the network or the disk.
///
///  2. DOWNLOAD / OFFLINE → [AudioDownloadManager]
///     Only audio needs downloading. Use the manager directly.
///
/// Network is used only for things that truly need it: search, tafsir,
/// translations, surah info and streaming audio that isn't downloaded yet.
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

  // ───────────────────────── browse / read (offline, instant) ─────────────────────────

  static QuranMetaModel? _metaMemo;

  /// 114 surahs + 30 juz (exact) + hizbs. Synchronous part is instant; hizb
  /// positions are upgraded from the cache when available.
  Future<QuranMetaModel?> getQuranMetadata() async {
    _metaMemo ??= QuranMetaModel(
      surahs: [for (var s = 1; s <= 114; s++) QuranTextSource.meta(s)],
      juzs: [
        for (var j = 0; j < 30; j++)
          JuzMetaModel(
              number: j + 1,
              surah: QuranMeta.juzStarts[j].$1,
              ayah: QuranMeta.juzStarts[j].$2),
      ],
    );
    final hizbs = await QuranHizbService.load();
    return QuranMetaModel(
        surahs: _metaMemo!.surahs, juzs: _metaMemo!.juzs, hizbs: hizbs);
  }

  /// Instant metadata of one surah (for the reader's app-bar).
  SurahMetaModel getSurahMeta(int n) => QuranTextSource.meta(n.clamp(1, 114));

  /// Instant, offline, never null for 1..114.
  SurahModel getSurahSync(int surahNumber, {bool useUthmani = true}) =>
      QuranTextSource.surah(surahNumber,
          edition: useUthmani ? 'quran-uthmani' : 'quran-simple');

  /// Kept for call-sites that still `await` it. Resolves immediately.
  /// [saveToCache] is ignored on purpose: text needs no download.
  Future<SurahModel?> getSurah(int surahNumber,
      {bool useUthmani = true, bool saveToCache = false}) async {
    if (surahNumber < 1 || surahNumber > 114) return null;
    return getSurahSync(surahNumber, useUthmani: useUthmani);
  }

  /// Offline random ayah (was API-only, so it failed without internet).
  Future<AyahModel?> getRandomAyah({bool useUthmani = true}) async {
    final g = Random().nextInt(QuranMeta.totalAyahs) + 1;
    return QuranTextSource.ayahByGlobal(g);
  }

  // ───────────────────────── last read / bookmark ─────────────────────────

  Future<void> saveLastRead(int surah, int ayah) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('last_read_surah', surah);
    await p.setInt('last_read_ayah', ayah);
  }

  Future<void> saveBookmark(int surah, int ayah) async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('bookmark_surah', surah);
    await p.setInt('bookmark_ayah', ayah);
  }

  Future<(int, int)?> getBookmark() async {
    final p = await SharedPreferences.getInstance();
    final s = p.getInt('bookmark_surah');
    final a = p.getInt('bookmark_ayah');
    return (s == null || a == null) ? null : (s, a);
  }

  // ───────────────────────── download / offline (audio) ─────────────────────────

  Future<String> selectedReciterId() async {
    final p = await SharedPreferences.getInstance();
    return p.getString('selected_reciter_id') ?? 'ar.abdulsamad';
  }

  /// Surahs whose audio is fully on the device for the selected reciter.
  Future<Set<int>> getDownloadedSurahs({bool useUthmani = true}) async {
    final id = await selectedReciterId();
    await AudioDownloadManager.instance.ensureReciter(id);
    return AudioDownloadManager.instance.completeSurahs(id);
  }

  /// Starts an audio download (non-blocking). Prefer the manager directly.
  Future<bool> downloadSurah(int surahNumber, {bool useUthmani = true}) async {
    final id = await selectedReciterId();
    await AudioDownloadManager.instance.enqueueSurah(id, surahNumber);
    return true;
  }

  // ───────────────────────── network features ─────────────────────────

  Future<SurahModel?> getSurahTranslation(int surahNumber, String translationEdition) async {
    final local = await _localService.getSurah(surahNumber, translationEdition);
    if (local != null) return local;
    final api = await _apiService.getSurah(surahNumber, edition: translationEdition);
    if (api != null) await _localService.saveSurah(api, translationEdition);
    return api;
  }

  Future<SurahModel?> getSurahAudio(int surahNumber, String reciterEdition) =>
      _apiService.getSurah(surahNumber, edition: reciterEdition);

  Future<SearchResultModel?> search(String keyword, {String language = 'ar'}) =>
      _apiService.search(keyword, language: language);

  Future<String?> getAyahTafsir(
          int surahNumber, int ayahNumberInSurah, String editionKey, bool isUmmahApi) =>
      _tafsirApiService.getAyahTafsir(
          surahNumber, ayahNumberInSurah, editionKey, isUmmahApi);
}
