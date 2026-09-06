class PrayerTimesModel {
  final Timings timings;
  final DateInfo dateInfo;
  final Meta meta;

  PrayerTimesModel({
    required this.timings,
    required this.dateInfo,
    required this.meta,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimesModel(
      timings: Timings.fromJson(json['timings']),
      dateInfo: DateInfo.fromJson(json['date']),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timings': timings.toJson(),
      'date': dateInfo.toJson(),
      'meta': meta.toJson(),
    };
  }
}

class Timings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstThird;
  final String lastThird;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstThird,
    required this.lastThird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json['Fajr'] ?? '',
      sunrise: json['Sunrise'] ?? '',
      dhuhr: json['Dhuhr'] ?? '',
      asr: json['Asr'] ?? '',
      sunset: json['Sunset'] ?? '',
      maghrib: json['Maghrib'] ?? '',
      isha: json['Isha'] ?? '',
      imsak: json['Imsak'] ?? '',
      midnight: json['Midnight'] ?? '',
      firstThird: json['Firstthird'] ?? '',
      lastThird: json['Lastthird'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Sunrise': sunrise,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Sunset': sunset,
      'Maghrib': maghrib,
      'Isha': isha,
      'Imsak': imsak,
      'Midnight': midnight,
      'Firstthird': firstThird,
      'Lastthird': lastThird,
    };
  }
}

class DateInfo {
  final String readable;
  final HijriDate hijri;
  final GregorianDate gregorian;

  DateInfo({
    required this.readable,
    required this.hijri,
    required this.gregorian,
  });

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      readable: json['readable'] ?? '',
      hijri: HijriDate.fromJson(json['hijri']),
      gregorian: GregorianDate.fromJson(json['gregorian']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'readable': readable,
      'hijri': hijri.toJson(),
      'gregorian': gregorian.toJson(),
    };
  }
}

class HijriDate {
  final String date;
  final String format;
  final String day;
  final String year;
  final String monthAr;
  final String monthEn;
  final String weekdayAr;
  final String weekdayEn;

  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.year,
    required this.monthAr,
    required this.monthEn,
    required this.weekdayAr,
    required this.weekdayEn,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      date: json['date'] ?? '',
      format: json['format'] ?? '',
      day: json['day'] ?? '',
      year: json['year'] ?? '',
      monthAr: json['month']?['ar'] ?? '',
      monthEn: json['month']?['en'] ?? '',
      weekdayAr: json['weekday']?['ar'] ?? '',
      weekdayEn: json['weekday']?['en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'year': year,
      'month': {
        'ar': monthAr,
        'en': monthEn,
      },
      'weekday': {
        'ar': weekdayAr,
        'en': weekdayEn,
      },
    };
  }
}

class GregorianDate {
  final String date;
  final String format;
  final String day;
  final String year;
  final String monthEn;
  final String weekdayEn;

  GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.year,
    required this.monthEn,
    required this.weekdayEn,
  });

  factory GregorianDate.fromJson(Map<String, dynamic> json) {
    return GregorianDate(
      date: json['date'] ?? '',
      format: json['format'] ?? '',
      day: json['day'] ?? '',
      year: json['year'] ?? '',
      monthEn: json['month']?['en'] ?? '',
      weekdayEn: json['weekday']?['en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'year': year,
      'month': {
        'en': monthEn,
      },
      'weekday': {
        'en': weekdayEn,
      },
    };
  }
}

class Meta {
  final String timezone;
  final String method;

  Meta({
    required this.timezone,
    required this.method,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      timezone: json['timezone'] ?? '',
      method: json['method']?['name'] ?? json['method'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timezone': timezone,
      'method': {
        'name': method,
      },
    };
  }
}
