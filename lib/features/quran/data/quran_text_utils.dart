/// Text helpers for Quran strings.
class QuranText {
  QuranText._();

  static final RegExp _marks =
      RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED\u0640]');

  /// Letters only (no tashkeel/tatweel), alef-wasla normalised.
  static String plain(String s) =>
      s.replaceAll(_marks, '').replaceAll('ٱ', 'ا').trim();

  /// The API prepends the Bismillah to ayah 1 of every surah except Al-Fatiha
  /// and At-Tawbah. The old code removed it with an exact-string match that
  /// silently failed whenever the API's diacritics/tatweel differed, so the
  /// Bismillah appeared twice. This version matches by letters only.
  static String stripBismillah(String text, {required int surahNumber, required int ayahNumber}) {
    if (ayahNumber != 1 || surahNumber == 1 || surahNumber == 9) return text;
    final words = text.trim().split(RegExp(r'\s+'));
    if (words.length > 4 &&
        plain(words[0]) == 'بسم' &&
        plain(words[1]) == 'الله' &&
        plain(words[2]).startsWith('الرحم') &&
        plain(words[3]) == 'الرحيم') {
      return words.skip(4).join(' ');
    }
    return text;
  }
}
