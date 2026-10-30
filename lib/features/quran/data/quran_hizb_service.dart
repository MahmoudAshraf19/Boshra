import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/app_logger.dart';
import 'models/quran_models.dart';
import 'quran_meta.dart';

/// Hizb start positions. Juz starts are bundled (exact). The 60 hizb starts are
/// fetched ONCE from api.alquran.cloud/v1/meta (hizbQuarters, every 4th quarter)
/// and cached forever. Until then we show the 30 hizbs that coincide with a juz
/// start (1,3,5,…,59) which are exact too — nothing is ever guessed.
class QuranHizbService {
  QuranHizbService._();
  static const _key = 'quran_hizb_starts_v1';
  static List<HizbMetaModel>? _mem;
  static Future<void>? _refreshing;

  static List<HizbMetaModel> _fallback() => [
        for (var j = 0; j < 30; j++)
          HizbMetaModel(
              number: j * 2 + 1,
              surah: QuranMeta.juzStarts[j].$1,
              ayah: QuranMeta.juzStarts[j].$2),
      ];

  static Future<List<HizbMetaModel>> load() async {
    if (_mem != null) return _mem!;
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_key);
      if (raw != null && raw.length == 60) {
        _mem = [
          for (var i = 0; i < 60; i++)
            HizbMetaModel(
              number: i + 1,
              surah: int.parse(raw[i].split(':')[0]),
              ayah: int.parse(raw[i].split(':')[1]),
            ),
        ];
        return _mem!;
      }
    } catch (_) {}
    unawaited(refresh()); // background, never blocks the UI
    return _fallback();
  }

  /// Fire-and-forget safe: swallows all errors.
  static Future<void> refresh() => _refreshing ??= _doRefresh().whenComplete(() => _refreshing = null);

  static Future<void> _doRefresh() async {
    final client = HttpClient()..connectionTimeout = const Duration(seconds: 10);
    try {
      final req = await client.getUrl(Uri.parse('https://api.alquran.cloud/v1/meta'));
      final res = await req.close().timeout(const Duration(seconds: 15));
      if (res.statusCode != 200) return;
      final body = await res.transform(utf8.decoder).join();
      final refs = (jsonDecode(body)['data']['hizbQuarters']['references']) as List;
      if (refs.length != 240) return;
      final starts = <String>[
        for (var i = 0; i < 60; i++) '${refs[i * 4]['surah']}:${refs[i * 4]['ayah']}',
      ];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, starts);
      _mem = null; // next load() picks the cached list
    } catch (e, s) {
      AppLogger.e('QuranHizb', e, s, 'refresh');
    } finally {
      client.close(force: true);
    }
  }
}
