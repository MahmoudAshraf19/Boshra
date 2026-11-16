import 'dart:convert';
import 'dart:ui' show PlatformDispatcher;
import 'package:shared_preferences/shared_preferences.dart';

class Currency {
  final String code;
  final String ar;
  final String en;
  const Currency(this.code, this.ar, this.en);
  String name(bool arabic) => arabic ? ar : en;
}

/// Currencies offered in the calculator + device-country → currency guess.
class Currencies {
  Currencies._();

  static const all = <Currency>[
    Currency('EGP', 'جنيه مصري', 'Egyptian pound'),
    Currency('SAR', 'ريال سعودي', 'Saudi riyal'),
    Currency('AED', 'درهم إماراتي', 'UAE dirham'),
    Currency('KWD', 'دينار كويتي', 'Kuwaiti dinar'),
    Currency('QAR', 'ريال قطري', 'Qatari riyal'),
    Currency('BHD', 'دينار بحريني', 'Bahraini dinar'),
    Currency('OMR', 'ريال عُماني', 'Omani rial'),
    Currency('JOD', 'دينار أردني', 'Jordanian dinar'),
    Currency('IQD', 'دينار عراقي', 'Iraqi dinar'),
    Currency('MAD', 'درهم مغربي', 'Moroccan dirham'),
    Currency('DZD', 'دينار جزائري', 'Algerian dinar'),
    Currency('TND', 'دينار تونسي', 'Tunisian dinar'),
    Currency('LYD', 'دينار ليبي', 'Libyan dinar'),
    Currency('SDG', 'جنيه سوداني', 'Sudanese pound'),
    Currency('YER', 'ريال يمني', 'Yemeni rial'),
    Currency('ILS', 'شيكل', 'Shekel'),
    Currency('TRY', 'ليرة تركية', 'Turkish lira'),
    Currency('PKR', 'روبية باكستانية', 'Pakistani rupee'),
    Currency('INR', 'روبية هندية', 'Indian rupee'),
    Currency('BDT', 'تاكا بنغلاديشية', 'Bangladeshi taka'),
    Currency('IDR', 'روبية إندونيسية', 'Indonesian rupiah'),
    Currency('MYR', 'رينغيت ماليزي', 'Malaysian ringgit'),
    Currency('USD', 'دولار أمريكي', 'US dollar'),
    Currency('EUR', 'يورو', 'Euro'),
    Currency('GBP', 'جنيه إسترليني', 'British pound'),
    Currency('CAD', 'دولار كندي', 'Canadian dollar'),
    Currency('AUD', 'دولار أسترالي', 'Australian dollar'),
  ];

  static const _byCountry = <String, String>{
    'EG': 'EGP', 'SA': 'SAR', 'AE': 'AED', 'KW': 'KWD', 'QA': 'QAR', 'BH': 'BHD', 'OM': 'OMR',
    'JO': 'JOD', 'IQ': 'IQD', 'MA': 'MAD', 'DZ': 'DZD', 'TN': 'TND', 'LY': 'LYD', 'SD': 'SDG',
    'YE': 'YER', 'PS': 'ILS', 'IL': 'ILS', 'TR': 'TRY', 'PK': 'PKR', 'IN': 'INR', 'BD': 'BDT',
    'ID': 'IDR', 'MY': 'MYR', 'US': 'USD', 'GB': 'GBP', 'CA': 'CAD', 'AU': 'AUD',
    'DE': 'EUR', 'FR': 'EUR', 'ES': 'EUR', 'IT': 'EUR', 'NL': 'EUR', 'BE': 'EUR', 'AT': 'EUR',
    'PT': 'EUR', 'IE': 'EUR', 'FI': 'EUR', 'GR': 'EUR',
  };

  static Currency byCode(String code) => all.firstWhere((c) => c.code == code, orElse: () => all.first);

  /// From the phone's region (falls back to USD).
  static String guess() {
    final cc = PlatformDispatcher.instance.locale.countryCode;
    return _byCountry[cc?.toUpperCase()] ?? 'USD';
  }
}

/// Zakat calculator settings: chosen currency / nisab type, and the yearly reminder
/// (the date the nisab was first owned → the lunar year ("hawl") is complete one year later).
class ZakatSettings {
  final String currency;
  final String nisab; // 'gold' | 'silver'
  final bool remind;
  final DateTime? hawlStart;

  const ZakatSettings({
    required this.currency,
    required this.nisab,
    required this.remind,
    required this.hawlStart,
  });

  static const lunarYearDays = 354.367;

  ZakatSettings copyWith({String? currency, String? nisab, bool? remind, DateTime? hawlStart, bool clearHawl = false}) =>
      ZakatSettings(
        currency: currency ?? this.currency,
        nisab: nisab ?? this.nisab,
        remind: remind ?? this.remind,
        hawlStart: clearHawl ? null : (hawlStart ?? this.hawlStart),
      );

  /// Next hawl completion strictly after [now] (day precision), or null if no start date.
  DateTime? nextDue(DateTime now) {
    final s = hawlStart;
    if (s == null) return null;
    final base = DateTime(s.year, s.month, s.day);
    final today = DateTime(now.year, now.month, now.day);
    var n = 1;
    while (n < 200) {
      final due = base.add(Duration(days: (lunarYearDays * n).round()));
      if (!due.isBefore(today)) return due;
      n++;
    }
    return null;
  }

  static Future<ZakatSettings> load() async {
    final p = await SharedPreferences.getInstance();
    final ms = p.getInt('zakat_hawl_ms');
    return ZakatSettings(
      currency: p.getString('zakat_currency') ?? Currencies.guess(),
      nisab: p.getString('zakat_nisab') ?? 'gold',
      remind: p.getBool('zakat_remind') ?? false,
      hawlStart: ms == null ? null : DateTime.fromMillisecondsSinceEpoch(ms),
    );
  }

  Future<void> save() async {
    final p = await SharedPreferences.getInstance();
    await p.setString('zakat_currency', currency);
    await p.setString('zakat_nisab', nisab);
    await p.setBool('zakat_remind', remind);
    if (hawlStart == null) {
      await p.remove('zakat_hawl_ms');
    } else {
      await p.setInt('zakat_hawl_ms', hawlStart!.millisecondsSinceEpoch);
    }
  }

  // ---- last typed amounts (so the user does not retype every year)
  static Future<Map<String, String>> loadInputs() async {
    final p = await SharedPreferences.getInstance();
    try {
      return (jsonDecode(p.getString('zakat_inputs_v1') ?? '{}') as Map).map((k, v) => MapEntry('$k', '$v'));
    } catch (_) {
      return {};
    }
  }

  static Future<void> saveInputs(Map<String, String> m) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('zakat_inputs_v1', jsonEncode(m));
  }
}
