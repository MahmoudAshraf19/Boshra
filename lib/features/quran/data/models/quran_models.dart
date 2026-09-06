class SurahMetaModel {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  SurahMetaModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory SurahMetaModel.fromJson(Map<String, dynamic> json) {
    return SurahMetaModel(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      englishName: json['englishName'] ?? '',
      englishNameTranslation: json['englishNameTranslation'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      revelationType: json['revelationType'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'numberOfAyahs': numberOfAyahs,
      'revelationType': revelationType,
    };
  }
}

class JuzMetaModel {
  final int number;
  final int surah;
  final int ayah;

  JuzMetaModel({required this.number, required this.surah, required this.ayah});

  factory JuzMetaModel.fromJson(Map<String, dynamic> json) {
    return JuzMetaModel(
      number: json['juz'] ?? json['number'] ?? 0,
      surah: json['surah'] ?? 0,
      ayah: json['ayah'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'surah': surah,
      'ayah': ayah,
    };
  }
}

class HizbMetaModel {
  final int number;
  final int surah;
  final int ayah;

  HizbMetaModel({required this.number, required this.surah, required this.ayah});

  factory HizbMetaModel.fromJson(Map<String, dynamic> json) {
    return HizbMetaModel(
      number: json['hizb'] ?? json['number'] ?? json['hizbQuarter'] ?? 0,
      surah: json['surah'] ?? 0,
      ayah: json['ayah'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'surah': surah,
      'ayah': ayah,
    };
  }
}

class QuranMetaModel {
  final List<SurahMetaModel> surahs;
  final List<JuzMetaModel> juzs;
  final List<HizbMetaModel> hizbs;
  
  QuranMetaModel({
    required this.surahs,
    this.juzs = const [],
    this.hizbs = const [],
  });
  
  factory QuranMetaModel.fromJson(Map<String, dynamic> json) {
    var surahsData = json['surahs'];
    List<dynamic> surahsList = [];
    if (surahsData is Map && surahsData.containsKey('references')) {
      surahsList = surahsData['references'] as List;
    } else if (surahsData is List) {
      surahsList = surahsData;
    }

    var juzsData = json['juzs'];
    List<dynamic> juzsList = [];
    if (juzsData is Map && juzsData.containsKey('references')) {
      juzsList = juzsData['references'] as List;
    } else if (juzsData is List) {
      juzsList = juzsData;
    }

    // Hizbs are usually hizbQuarters in the API, we'll take every 4th quarter or just all quarters.
    // The user asked for "Hizb" which usually means 60 Hizbs.
    var hizbsData = json['hizbs'] ?? json['hizbQuarters'];
    List<dynamic> hizbsList = [];
    if (hizbsData is Map && hizbsData.containsKey('references')) {
      hizbsList = hizbsData['references'] as List;
    } else if (hizbsData is List) {
      hizbsList = hizbsData;
    }

    return QuranMetaModel(
      surahs: surahsList.map((s) => SurahMetaModel.fromJson(s)).toList(),
      juzs: juzsList.map((j) => JuzMetaModel.fromJson(j)).toList(),
      hizbs: hizbsList.map((h) => HizbMetaModel.fromJson(h)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surahs': surahs.map((s) => s.toJson()).toList(),
      'juzs': juzs.map((j) => j.toJson()).toList(),
      'hizbs': hizbs.map((h) => h.toJson()).toList(),
    };
  }
}

class SurahModel {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final int numberOfAyahs;
  final List<AyahModel> ayahs;
  final String edition;

  SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.numberOfAyahs,
    required this.ayahs,
    required this.edition,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    var ayahsJson = json['ayahs'] as List? ?? [];
    return SurahModel(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      englishName: json['englishName'] ?? '',
      englishNameTranslation: json['englishNameTranslation'] ?? '',
      revelationType: json['revelationType'] ?? '',
      numberOfAyahs: json['numberOfAyahs'] ?? 0,
      edition: json['edition']?['identifier'] ?? '',
      ayahs: ayahsJson.map((a) => AyahModel.fromJson(a)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'revelationType': revelationType,
      'numberOfAyahs': numberOfAyahs,
      'edition': {'identifier': edition},
      'ayahs': ayahs.map((a) => a.toJson()).toList(),
    };
  }
}

class AyahModel {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final dynamic sajda;
  final String? audio;
  final List<String>? audioSecondary;
  final String? surahName;
  final String? surahEnglishName;
  final int? surahNumber;

  AyahModel({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
    this.audio,
    this.audioSecondary,
    this.surahName,
    this.surahEnglishName,
    this.surahNumber,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      number: json['number'] ?? 0,
      text: json['text'] ?? '',
      numberInSurah: json['numberInSurah'] ?? 0,
      juz: json['juz'] ?? 0,
      manzil: json['manzil'] ?? 0,
      page: json['page'] ?? 0,
      ruku: json['ruku'] ?? 0,
      hizbQuarter: json['hizbQuarter'] ?? 0,
      sajda: json['sajda'] ?? false,
      audio: json['audio'],
      audioSecondary: json['audioSecondary'] != null 
          ? (json['audioSecondary'] as List).map((e) => e.toString()).toList()
          : null,
      surahName: json['surah'] != null ? json['surah']['name'] : json['surahName'],
      surahEnglishName: json['surah'] != null ? json['surah']['englishName'] : json['surahEnglishName'],
      surahNumber: json['surah'] != null ? json['surah']['number'] : json['surahNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': text,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
      'sajda': sajda,
      'audio': audio,
      'audioSecondary': audioSecondary,
      'surahName': surahName,
      'surahEnglishName': surahEnglishName,
      'surahNumber': surahNumber,
    };
  }
}

class SearchResultModel {
  final int count;
  final List<AyahModel> matches;

  SearchResultModel({
    required this.count,
    required this.matches,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    var matchesJson = json['matches'] as List? ?? [];
    return SearchResultModel(
      count: json['count'] ?? 0,
      matches: matchesJson.map((m) => AyahModel.fromJson(m)).toList(),
    );
  }
}
