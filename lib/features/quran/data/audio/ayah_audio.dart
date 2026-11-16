import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../quran_meta.dart';
import 'audio_download_manager.dart';

/// Single place that decides "play from disk or stream?".
/// Always uses the GLOBAL ayah number (1..6236) the CDN expects.
class AyahAudio {
  AyahAudio._();

  static Future<AudioSource> source({
    required String reciterId,
    required int surah,
    required int ayahInSurah,
    required MediaItem tag,
  }) async {
    final global = QuranMeta.globalAyah(surah, ayahInSurah);
    if (kIsWeb) {
      return AudioSource.uri(Uri.parse(AudioDownloadManager.urlFor(reciterId, global)), tag: tag);
    }
    final m = AudioDownloadManager.instance;
    await m.ensureReciter(reciterId);
    return _build(m, reciterId, global, tag);
  }

  /// Playlist for a whole surah. Ayahs already downloaded play from disk,
  /// the rest stream — so a half-downloaded surah still works offline-first.
  static Future<List<AudioSource>> playlist({
    required String reciterId,
    required int surah,
    required MediaItem Function(int ayahInSurah) tagFor,
  }) async {
    final n = QuranMeta.ayahCount(surah);
    if (kIsWeb) {
      return [
        for (var a = 1; a <= n; a++)
          AudioSource.uri(
            Uri.parse(AudioDownloadManager.urlFor(reciterId, QuranMeta.globalAyah(surah, a))),
            tag: tagFor(a),
          ),
      ];
    }
    final m = AudioDownloadManager.instance;
    await m.ensureReciter(reciterId);
    return [
      for (var a = 1; a <= n; a++) _build(m, reciterId, QuranMeta.globalAyah(surah, a), tagFor(a)),
    ];
  }

  static AudioSource _build(AudioDownloadManager m, String reciterId, int global, MediaItem tag) {
    if (kIsWeb) {
      return AudioSource.uri(Uri.parse(AudioDownloadManager.urlFor(reciterId, global)), tag: tag);
    }
    final f = m.localFile(reciterId, global);
    return f != null
        ? AudioSource.file(f.path, tag: tag)
        : AudioSource.uri(Uri.parse(AudioDownloadManager.urlFor(reciterId, global)), tag: tag);
  }
}
