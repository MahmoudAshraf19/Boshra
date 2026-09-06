import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../data/models/azkar_model.dart';
import '../../data/repositories/azkar_repository.dart';

class AzkarProvider extends ChangeNotifier {
  final AzkarRepository _repository;
  
  AzkarProvider({AzkarRepository? repository}) 
      : _repository = repository ?? AzkarRepository();

  Map<String, List<AzkarModel>> _groupedAzkar = {};
  Map<String, List<AzkarModel>> get groupedAzkar => _groupedAzkar;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  /// Loads Azkar based on the current app language
  Future<void> loadAzkar(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // 1. Get the current app locale (e.g. 'en', 'ar', 'es')
      String languageCode = Localizations.localeOf(context).languageCode;
      
      // 2. Fetch the Azkar grouped by category for this specific language
      _groupedAzkar = await _repository.getGroupedAzkar(languageCode);
      
    } catch (e) {
      _error = 'Failed to load Azkar: $e';
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
