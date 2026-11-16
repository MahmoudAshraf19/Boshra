import '../utils/app_logger.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../features/azkar/data/models/azkar_model.dart';

class AzkarLocalService {
  /// Loads and parses the Azkar from the local JSON file.
  Future<List<AzkarModel>> getAzkar(String languageCode) async {
    try {
      final assetPath = (languageCode == 'en')
          ? 'assets/data/azkar_en.json'
          : 'assets/data/azkar.json';
      final jsonString = await rootBundle.loadString(assetPath);
      final Map<String, dynamic> data = json.decode(jsonString);
      
      final List<dynamic> rows = data['rows'] ?? [];
      
      return rows.map((row) => AzkarModel.fromJson(row)).toList();
    } catch (e) {
      appLog('Error loading Azkar from local JSON: $e');
      return [];
    }
  }

  /// Groups Azkar by their Category.
  Future<Map<String, List<AzkarModel>>> getAzkarGroupedByCategory(String languageCode) async {
    final azkarList = await getAzkar(languageCode);
    final Map<String, List<AzkarModel>> grouped = {};

    for (var zekr in azkarList) {
      if (!grouped.containsKey(zekr.category)) {
        grouped[zekr.category] = [];
      }
      grouped[zekr.category]!.add(zekr);
    }

    return grouped;
  }
}
