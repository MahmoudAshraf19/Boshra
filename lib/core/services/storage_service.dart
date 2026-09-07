import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageInfo {
  final int systemBytes;
  final int downloadedSurahsBytes;
  final int azkarBytes;
  final int appDataBytes;
  final int cacheBytes;

  const StorageInfo({
    required this.systemBytes,
    required this.downloadedSurahsBytes,
    required this.azkarBytes,
    required this.appDataBytes,
    required this.cacheBytes,
  });

  int get totalUsedBytes => systemBytes + downloadedSurahsBytes + azkarBytes + appDataBytes + cacheBytes;
}

class StorageService {
  // Max storage limit: 3 GB
  static const int maxStorageBytes = 3 * 1024 * 1024 * 1024;

  /// Returns total sizes of various app directories
  Future<StorageInfo> getStorageInfo() async {
    if (kIsWeb) {
      return const StorageInfo(systemBytes: 0, downloadedSurahsBytes: 0, azkarBytes: 0, appDataBytes: 0, cacheBytes: 0);
    }

    final docDir = await getApplicationDocumentsDirectory();
    final tempDir = await getTemporaryDirectory();
    
    // Calculate Support directory (system cache/files) + Base App Size (e.g., 133MB as seen in OS)
    int supportSize = 0;
    try {
      final supportDir = await getApplicationSupportDirectory();
      supportSize = await _getDirectorySize(supportDir);
    } catch (_) {}
    
    final systemBytes = supportSize;

    // 1. Downloaded Surahs (Quran Text cache)
    final quranTextDir = Directory('${docDir.path}/downloads/quran_text');
    final downloadedSurahsBytes = await _getDirectorySize(quranTextDir);

    // 2. App Data (Metadata, DBs)
    final appDataDir = Directory('${docDir.path}/app_data');
    final appDataBytes = await _getDirectorySize(appDataDir);

    // 2. Azkar (From bundled assets)
    int azkarBytes = 0;
    azkarBytes += await _getAssetSize('assets/data/azkar.json');
    azkarBytes += await _getAssetSize('assets/data/azkar_en.json');
    azkarBytes += await _getAssetSize('assets/data/boshra_120_quran_verses.json');

    // 3. General App Cache (Temporary directory & OS Code Cache)
    int cacheBytes = await _getDirectorySize(tempDir);
    try {
      if (Platform.isAndroid) {
        final codeCacheDir = Directory('${tempDir.parent.path}/code_cache');
        cacheBytes += await _getDirectorySize(codeCacheDir);
      }
    } catch (_) {}

    return StorageInfo(
      systemBytes: systemBytes,
      downloadedSurahsBytes: downloadedSurahsBytes,
      azkarBytes: azkarBytes,
      appDataBytes: appDataBytes,
      cacheBytes: cacheBytes,
    );
  }

  /// Calculates size of an asset bundle file
  Future<int> _getAssetSize(String assetPath) async {
    try {
      final data = await rootBundle.load(assetPath);
      return data.lengthInBytes;
    } catch (e) {
      return 0;
    }
  }

  /// Calculates size of a directory recursively
  Future<int> _getDirectorySize(Directory dir) async {
    int totalSize = 0;
    try {
      if (await dir.exists()) {
        await for (var entity in dir.list(recursive: true, followLinks: false)) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
      }
    } catch (e) {
      print('Error calculating size for ${dir.path}: $e');
    }
    return totalSize;
  }

  /// Checks if there is enough space for an estimated download size.
  /// Example: Surah text is ~100KB (100 * 1024 bytes)
  Future<bool> hasEnoughSpace(int estimatedBytesNeeded) async {
    final info = await getStorageInfo();
    return (info.totalUsedBytes + estimatedBytesNeeded) <= maxStorageBytes;
  }

  /// Deletes all downloaded Quran texts (and audios/azkar in the future)
  Future<void> clearAllDownloads() async {
    if (kIsWeb) return;
    try {
      final docDir = await getApplicationDocumentsDirectory();
      
      final downloadsDir = Directory('${docDir.path}/downloads');
      if (await downloadsDir.exists()) {
        await downloadsDir.delete(recursive: true);
      }
      
      // Keep old path clear just in case
      final quranTextDir = Directory('${docDir.path}/quran_cache');
      if (await quranTextDir.exists()) {
        await quranTextDir.delete(recursive: true);
      }
    } catch (e) {
      print('Error clearing downloads: $e');
    }
  }

  /// Clears the temporary cache
  Future<void> clearCache() async {
    if (kIsWeb) return;
    try {
      final tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
      if (Platform.isAndroid) {
        final codeCacheDir = Directory('${tempDir.parent.path}/code_cache');
        if (await codeCacheDir.exists()) {
          await codeCacheDir.delete(recursive: true);
        }
      }
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }
  
  /// Clears all app data (Cache, Downloads, Settings, Files)
  Future<void> clearAllData() async {
    await clearCache();
    await clearAllDownloads();
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final appDataDir = Directory('${docDir.path}/app_data');
      if (await appDataDir.exists()) {
        await appDataDir.delete(recursive: true);
      }
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      
      final supportDir = await getApplicationSupportDirectory();
      if (await supportDir.exists()) {
        await supportDir.delete(recursive: true);
      }
    } catch (e) {
      print('Error clearing preferences: $e');
    }
  }
}
