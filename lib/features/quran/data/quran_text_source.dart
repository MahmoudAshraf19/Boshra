import 'dart:collection';
import 'package:quran/quran.dart' as q;
import 'models/quran_models.dart';
import 'quran_meta.dart';

/// Builds [SurahModel]s straight from the bundled `quran` package.
///
/// * 100% offline, no disk, no network, no JSON.
/// * Memoised (LRU) — building a surah twice costs nothing.
/// * `AyahModel.number` is the GLOBAL ayah number (1..6236) so audio URLs,
///   sharing and navigation are always correct.
class QuranTextSource {
  QuranTextSource._();

  static const int _maxCached = 16;
  static final LinkedHashMap<int, SurahModel> _cache = LinkedHashMap();

  static String _arabicName(int s) {
    final n = q.getSurahNameArabic(s);
    return n.startsWith('سُورَةُ') || n.startsWith('سورة') ? n : 'سُورَةُ $n';
  }

  static String _revelation(int s) =>
      q.getPlaceOfRevelation(s).toLowerCase().startsWith('mak') ? 'Meccan' : 'Medinan';

  static SurahMetaModel meta(int s) => SurahMetaModel(
        number: s,
        name: _arabicName(s),
        englishName: q.getSurahNameEnglish(s),
        englishNameTranslation: q.getSurahNameEnglish(s),
        numberOfAyahs: QuranMeta.ayahCount(s),
        revelationType: _revelation(s),
      );

  /// Synchronous and fast. Never returns null for 1..114.
  static SurahModel surah(int n, {String edition = 'quran-uthmani'}) {
    final s = n.clamp(1, 114);
    final hit = _cache.remove(s);
    if (hit != null) {
      _cache[s] = hit; // refresh LRU
      return hit;
    }
    final count = QuranMeta.ayahCount(s);
    final name = _arabicName(s);
    final en = q.getSurahNameEnglish(s);
    final ayahs = List<AyahModel>.generate(count, (i) {
      final a = i + 1;
      return AyahModel(
        number: QuranMeta.globalAyah(s, a),
        text: q.getVerse(s, a, verseEndSymbol: false),
        numberInSurah: a,
        juz: q.getJuzNumber(s, a),
        manzil: 0,
        page: q.getPageNumber(s, a),
        ruku: 0,
        hizbQuarter: 0,
        sajda: q.isSajdahVerse(s, a),
        surahName: name,
        surahEnglishName: en,
        surahNumber: s,
      );
    }, growable: false);

    final model = SurahModel(
      number: s,
      name: name,
      englishName: en,
      englishNameTranslation: en,
      revelationType: _revelation(s),
      numberOfAyahs: count,
      ayahs: ayahs,
      edition: edition,
    );
    _cache[s] = model;
    while (_cache.length > _maxCached) {
      _cache.remove(_cache.keys.first);
    }
    return model;
  }

  static AyahModel ayahByGlobal(int global) {
    final (s, a) = QuranMeta.fromGlobal(global);
    return surah(s).ayahs[a - 1];
  }
}
