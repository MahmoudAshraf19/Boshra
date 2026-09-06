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
    final quranDir = Directory('${directory.path}/quran_cache');
    if (!await quranDir.exists()) {
      await quranDir.create(recursive: true);
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

  /// Get the file path for Quran metadata
  Future<File?> _getMetadataFile() async {
    final dir = await _getStorageDirectory();
    if (dir == null) return null;
    return File('${dir.path}/quran_metadata.json');
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
