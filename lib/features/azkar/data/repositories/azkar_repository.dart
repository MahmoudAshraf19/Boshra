import '../models/azkar_model.dart';
import '../../../../core/services/azkar_local_service.dart';

class AzkarRepository {
  final AzkarLocalService _localService;

  AzkarRepository({AzkarLocalService? localService})
      : _localService = localService ?? AzkarLocalService();

  /// Gets all Azkar as a flat list.
  Future<List<AzkarModel>> getAllAzkar(String languageCode) async {
    return await _localService.getAzkar(languageCode);
  }

  /// Gets all Azkar grouped by their categories (e.g. 'أذكار الصباح', 'أذكار المساء').
  Future<Map<String, List<AzkarModel>>> getGroupedAzkar(String languageCode) async {
    return await _localService.getAzkarGroupedByCategory(languageCode);
  }
}
