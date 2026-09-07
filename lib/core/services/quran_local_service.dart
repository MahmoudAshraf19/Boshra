import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/quran/data/models/quran_models.dart';

class QuranLocalService {
  /// Gets the directory where we will store the Quran JSON files.
  Future<Directory?> _getStorageDirectory() async {
    if (kIsWeb) return null;
    final directory = await getApplicationDocumentsDirectory();
    final quranDir = Directory('${directory.path}/downloads/quran_text');
    if (!await quranDir.exists()) {
      await quranDir.create(recursive: true);
    }
    
    // Migrate old cache if it exists
    final oldDir = Directory('${directory.path}/quran_cache');
    if (await oldDir.exists()) {
      try {
        final files = oldDir.listSync();
        for (var file in files) {
          if (file is File) {
            await file.rename('${quranDir.path}/${file.uri.pathSegments.last}');
          }
        }
        await oldDir.delete(recursive: true);
      } catch (e) {
        print('Migration error: $e');
      }
    }
    
    return quranDir;
  }

  /// Gets the file path for a specific surah and edition.
  Future<File?> _getSurahFile(int surahNumber, String edition) async {
    final dir = await _getStorageDirectory();
    if (dir == null) return null;
    return File('${dir.path}/surah_${surahNumber}_$edition.json');
  }

  /// Check if a surah exists locally.
  Future<bool> isSurahCached(int surahNumber, String edition) async {
    final file = await _getSurahFile(surahNumber, edition);
    if (file == null) return false;
    return file.exists();
  }

  /// Get a set of all currently cached Surah numbers for a specific edition.
  Future<Set<int>> getCachedSurahs(String edition) async {
    final dir = await _getStorageDirectory();
    if (dir == null || !(await dir.exists())) return {};

    final cachedSurahs = <int>{};
    final files = dir.listSync();
    for (final file in files) {
      if (file is File) {
        final filename = file.uri.pathSegments.last;
        // filename format: surah_{number}_{edition}.json
        if (filename.startsWith('surah_') && filename.endsWith('_$edition.json')) {
          final numberStr = filename.replaceAll('surah_', '').replaceAll('_$edition.json', '');
          final number = int.tryParse(numberStr);
          if (number != null) {
            cachedSurahs.add(number);
          }
        }
      }
    }
    return cachedSurahs;
  }

  /// Get the file path for Quran metadata
  Future<File?> _getMetadataFile() async {
    if (kIsWeb) return null;
    final directory = await getApplicationDocumentsDirectory();
    final appDataDir = Directory('${directory.path}/app_data');
    if (!await appDataDir.exists()) {
      await appDataDir.create(recursive: true);
    }
    return File('${appDataDir.path}/quran_metadata.json');
  }

  /// Save Quran metadata to local storage
  Future<void> saveMetadata(QuranMetaModel meta) async {
    final file = await _getMetadataFile();
    if (file == null) return;
    final jsonString = jsonEncode(meta.toJson());
    await file.writeAsString(jsonString);
  }

  /// Get Quran metadata from local storage
  Future<QuranMetaModel?> getMetadata() async {
    try {
      final file = await _getMetadataFile();
      if (file != null && await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonMap = jsonDecode(jsonString);
        return QuranMetaModel.fromJson(jsonMap);
      }
    } catch (e) {
      print('Error reading local metadata: $e');
    }
    return null;
  }

  /// Save Surah to local storage.
  Future<void> saveSurah(SurahModel surah, String edition) async {
    final file = await _getSurahFile(surah.number, edition);
    if (file == null) return;
    final jsonString = jsonEncode(surah.toJson());
    await file.writeAsString(jsonString);
  }

  /// Get Surah from local storage.
  Future<SurahModel?> getSurah(int surahNumber, String edition) async {
    try {
      final file = await _getSurahFile(surahNumber, edition);
      if (file != null && await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonMap = jsonDecode(jsonString);
        return SurahModel.fromJson(jsonMap);
      }
    } catch (e) {
      print('Error reading local surah: $e');
    }
    return null;
  }
}
