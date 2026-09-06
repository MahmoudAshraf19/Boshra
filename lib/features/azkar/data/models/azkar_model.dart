class AzkarModel {
  final String category;
  final String zekr;
  final String description;
  final String count;
  final String reference;
  final String search;

  AzkarModel({
    required this.category,
    required this.zekr,
    required this.description,
    required this.count,
    required this.reference,
    required this.search,
  });

  factory AzkarModel.fromJson(List<dynamic> jsonRow) {
    // The JSON rows are arrays of values mapping to the columns:
    // [category, zekr, description, count, reference, search]
    return AzkarModel(
      category: jsonRow[0]?.toString() ?? '',
      zekr: jsonRow[1]?.toString() ?? '',
      description: jsonRow[2]?.toString() ?? '',
      count: jsonRow[3]?.toString() ?? '1', // Sometimes count is empty string in the json
      reference: jsonRow[4]?.toString() ?? '',
      search: jsonRow[5]?.toString() ?? '',
    );
  }
}
