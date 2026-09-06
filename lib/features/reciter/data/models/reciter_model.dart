class ReciterModel {
  final int id;
  final String name;
  final String letter;
  final String date;
  final List<MoshafModel> moshaf;

  ReciterModel({
    required this.id,
    required this.name,
    required this.letter,
    required this.date,
    required this.moshaf,
  });

  factory ReciterModel.fromJson(Map<String, dynamic> json) {
    var moshafJson = json['moshaf'] as List? ?? [];
    return ReciterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      letter: json['letter'] ?? '',
      date: json['date'] ?? '',
      moshaf: moshafJson.map((m) => MoshafModel.fromJson(m)).toList(),
    );
  }
}

class MoshafModel {
  final int id;
  final String name;
  final String server;
  final int surahTotal;
  final int moshafType;
  final String surahList;

  MoshafModel({
    required this.id,
    required this.name,
    required this.server,
    required this.surahTotal,
    required this.moshafType,
    required this.surahList,
  });

  factory MoshafModel.fromJson(Map<String, dynamic> json) {
    return MoshafModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      server: json['server'] ?? '',
      surahTotal: json['surah_total'] ?? 0,
      moshafType: json['moshaf_type'] ?? 0,
      surahList: json['surah_list'] ?? '',
    );
  }
}
