/// Cities the user can pick manually when GPS is unavailable / denied, and the
/// defaults used when nothing else is known. Coordinates are city centres.
class KnownCity {
  final String id;
  final String nameAr;
  final String nameEn;
  final double lat;
  final double lng;
  const KnownCity(this.id, this.nameAr, this.nameEn, this.lat, this.lng);
  String name(bool arabic) => arabic ? nameAr : nameEn;
}

class KnownCities {
  KnownCities._();

  /// Default when nothing else is known (was Makkah, which gave wrong times in Egypt).
  static const cairo = KnownCity('cairo', 'القاهرة، مصر', 'Cairo, Egypt', 30.0444, 31.2357);

  static const List<KnownCity> all = [
    cairo,
    KnownCity('giza', 'الجيزة، مصر', 'Giza, Egypt', 30.0131, 31.2089),
    KnownCity('alexandria', 'الإسكندرية، مصر', 'Alexandria, Egypt', 31.2001, 29.9187),
    KnownCity('shubra', 'شبرا الخيمة، مصر', 'Shubra El-Kheima, Egypt', 30.1286, 31.2422),
    KnownCity('port_said', 'بورسعيد، مصر', 'Port Said, Egypt', 31.2653, 32.3019),
    KnownCity('suez', 'السويس، مصر', 'Suez, Egypt', 29.9668, 32.5498),
    KnownCity('ismailia', 'الإسماعيلية، مصر', 'Ismailia, Egypt', 30.5965, 32.2715),
    KnownCity('mansoura', 'المنصورة، مصر', 'Mansoura, Egypt', 31.0409, 31.3785),
    KnownCity('tanta', 'طنطا، مصر', 'Tanta, Egypt', 30.7865, 31.0004),
    KnownCity('zagazig', 'الزقازيق، مصر', 'Zagazig, Egypt', 30.5877, 31.502),
    KnownCity('damietta', 'دمياط، مصر', 'Damietta, Egypt', 31.4165, 31.8133),
    KnownCity('fayoum', 'الفيوم، مصر', 'Fayoum, Egypt', 29.3084, 30.8428),
    KnownCity('beni_suef', 'بني سويف، مصر', 'Beni Suef, Egypt', 29.0661, 31.0994),
    KnownCity('minya', 'المنيا، مصر', 'Minya, Egypt', 28.1099, 30.7503),
    KnownCity('asyut', 'أسيوط، مصر', 'Asyut, Egypt', 27.1809, 31.1837),
    KnownCity('sohag', 'سوهاج، مصر', 'Sohag, Egypt', 26.5569, 31.6948),
    KnownCity('qena', 'قنا، مصر', 'Qena, Egypt', 26.1551, 32.716),
    KnownCity('luxor', 'الأقصر، مصر', 'Luxor, Egypt', 25.6872, 32.6396),
    KnownCity('aswan', 'أسوان، مصر', 'Aswan, Egypt', 24.0889, 32.8998),
    KnownCity('hurghada', 'الغردقة، مصر', 'Hurghada, Egypt', 27.2579, 33.8116),
    KnownCity('sharm', 'شرم الشيخ، مصر', 'Sharm El-Sheikh, Egypt', 27.9158, 34.33),
    KnownCity('marsa_matruh', 'مرسى مطروح، مصر', 'Marsa Matruh, Egypt', 31.3543, 27.2373),
    KnownCity('makkah', 'مكة المكرمة، السعودية', 'Makkah, Saudi Arabia', 21.4225, 39.8262),
    KnownCity('madinah', 'المدينة المنورة، السعودية', 'Madinah, Saudi Arabia', 24.4709, 39.6122),
    KnownCity('riyadh', 'الرياض، السعودية', 'Riyadh, Saudi Arabia', 24.7136, 46.6753),
    KnownCity('jeddah', 'جدة، السعودية', 'Jeddah, Saudi Arabia', 21.4858, 39.1925),
    KnownCity('dubai', 'دبي، الإمارات', 'Dubai, UAE', 25.2048, 55.2708),
    KnownCity('abu_dhabi', 'أبوظبي، الإمارات', 'Abu Dhabi, UAE', 24.4539, 54.3773),
    KnownCity('kuwait', 'الكويت', 'Kuwait City, Kuwait', 29.3759, 47.9774),
    KnownCity('doha', 'الدوحة، قطر', 'Doha, Qatar', 25.2854, 51.531),
    KnownCity('manama', 'المنامة، البحرين', 'Manama, Bahrain', 26.2285, 50.586),
    KnownCity('muscat', 'مسقط، عُمان', 'Muscat, Oman', 23.588, 58.3829),
    KnownCity('amman', 'عمّان، الأردن', 'Amman, Jordan', 31.9454, 35.9284),
    KnownCity('jerusalem', 'القدس، فلسطين', 'Jerusalem, Palestine', 31.7683, 35.2137),
    KnownCity('beirut', 'بيروت، لبنان', 'Beirut, Lebanon', 33.8938, 35.5018),
    KnownCity('damascus', 'دمشق، سوريا', 'Damascus, Syria', 33.5138, 36.2765),
    KnownCity('baghdad', 'بغداد، العراق', 'Baghdad, Iraq', 33.3152, 44.3661),
    KnownCity('khartoum', 'الخرطوم، السودان', 'Khartoum, Sudan', 15.5007, 32.5599),
    KnownCity('tripoli', 'طرابلس، ليبيا', 'Tripoli, Libya', 32.8872, 13.1913),
    KnownCity('tunis', 'تونس', 'Tunis, Tunisia', 36.8065, 10.1815),
    KnownCity('algiers', 'الجزائر', 'Algiers, Algeria', 36.7538, 3.0588),
    KnownCity('casablanca', 'الدار البيضاء، المغرب', 'Casablanca, Morocco', 33.5731, -7.5898),
    KnownCity('rabat', 'الرباط، المغرب', 'Rabat, Morocco', 34.0209, -6.8416),
    KnownCity('sanaa', 'صنعاء، اليمن', 'Sanaa, Yemen', 15.3694, 44.191),
    KnownCity('istanbul', 'إسطنبول، تركيا', 'Istanbul, Türkiye', 41.0082, 28.9784),
    KnownCity('london', 'لندن، المملكة المتحدة', 'London, UK', 51.5074, -0.1278),
    KnownCity('paris', 'باريس، فرنسا', 'Paris, France', 48.8566, 2.3522),
    KnownCity('berlin', 'برلين، ألمانيا', 'Berlin, Germany', 52.52, 13.405),
    KnownCity('new_york', 'نيويورك، أمريكا', 'New York, USA', 40.7128, -74.006),
    KnownCity('toronto', 'تورنتو، كندا', 'Toronto, Canada', 43.6532, -79.3832),
  ];

  /// Default city by the device's IANA time-zone (so a user in Riyadh doesn't get Cairo).
  static KnownCity byTimeZone(String? tzName) {
    switch (tzName) {
      case 'Asia/Riyadh':
        return all.firstWhere((c) => c.id == 'riyadh');
      case 'Asia/Dubai':
        return all.firstWhere((c) => c.id == 'dubai');
      case 'Asia/Kuwait':
        return all.firstWhere((c) => c.id == 'kuwait');
      case 'Asia/Qatar':
        return all.firstWhere((c) => c.id == 'doha');
      case 'Asia/Amman':
        return all.firstWhere((c) => c.id == 'amman');
      case 'Asia/Baghdad':
        return all.firstWhere((c) => c.id == 'baghdad');
      case 'Africa/Khartoum':
        return all.firstWhere((c) => c.id == 'khartoum');
      case 'Africa/Tripoli':
        return all.firstWhere((c) => c.id == 'tripoli');
      case 'Africa/Tunis':
        return all.firstWhere((c) => c.id == 'tunis');
      case 'Africa/Algiers':
        return all.firstWhere((c) => c.id == 'algiers');
      case 'Africa/Casablanca':
        return all.firstWhere((c) => c.id == 'casablanca');
      case 'Europe/Istanbul':
        return all.firstWhere((c) => c.id == 'istanbul');
      default:
        return cairo; // Africa/Cairo and everything unknown
    }
  }
}
