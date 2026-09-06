import 'dart:convert';
import 'package:flutter/services.dart';
import '../../features/azkar/data/models/azkar_model.dart';

class AzkarLocalService {
  /// Loads and parses the Azkar from the local JSON file.
  Future<List<AzkarModel>> getAzkar(String languageCode) async {
    try {
      // Try to load the language specific file
      String jsonString;
      try {
        jsonString = await rootBundle.loadString('assets/data/azkar_$languageCode.json');
      } catch (_) {
        // Fallback to Arabic if the language file doesn't exist yet
        jsonString = await rootBundle.loadString('assets/data/azkar.json');
      }
      
      final Map<String, dynamic> data = json.decode(jsonString);
      
      final List<dynamic> rows = data['rows'] ?? [];
      
      return rows.map((row) => AzkarModel.fromJson(row)).toList();
    } catch (e) {
      print('Error loading Azkar from local JSON: $e');
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
