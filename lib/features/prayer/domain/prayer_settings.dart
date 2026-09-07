import 'package:shared_preferences/shared_preferences.dart';

class PrayerSettings {
  final bool enabledFajr;
  final String fajrSound; // silent, short, adhan
  final bool enabledDhuhr;
  final String dhuhrSound;
  final bool enabledAsr;
  final String asrSound;
  final bool enabledMaghrib;
  final String maghribSound;
  final bool enabledIsha;
  final String ishaSound;
  final int beforePrayerMinutes;

  PrayerSettings({
    required this.enabledFajr,
    required this.fajrSound,
    required this.enabledDhuhr,
    required this.dhuhrSound,
    required this.enabledAsr,
    required this.asrSound,
    required this.enabledMaghrib,
    required this.maghribSound,
    required this.enabledIsha,
    required this.ishaSound,
    required this.beforePrayerMinutes,
  });

  PrayerSettings copyWith({
    bool? enabledFajr,
    String? fajrSound,
    bool? enabledDhuhr,
    String? dhuhrSound,
    bool? enabledAsr,
    String? asrSound,
    bool? enabledMaghrib,
    String? maghribSound,
    bool? enabledIsha,
    String? ishaSound,
    int? beforePrayerMinutes,
  }) {
    return PrayerSettings(
      enabledFajr: enabledFajr ?? this.enabledFajr,
      fajrSound: fajrSound ?? this.fajrSound,
      enabledDhuhr: enabledDhuhr ?? this.enabledDhuhr,
      dhuhrSound: dhuhrSound ?? this.dhuhrSound,
      enabledAsr: enabledAsr ?? this.enabledAsr,
      asrSound: asrSound ?? this.asrSound,
      enabledMaghrib: enabledMaghrib ?? this.enabledMaghrib,
      maghribSound: maghribSound ?? this.maghribSound,
      enabledIsha: enabledIsha ?? this.enabledIsha,
      ishaSound: ishaSound ?? this.ishaSound,
      beforePrayerMinutes: beforePrayerMinutes ?? this.beforePrayerMinutes,
    );
  }

  factory PrayerSettings.defaultSettings() {
    return PrayerSettings(
      enabledFajr: true,
      fajrSound: 'adhan',
      enabledDhuhr: true,
      dhuhrSound: 'adhan',
      enabledAsr: true,
      asrSound: 'adhan',
      enabledMaghrib: true,
      maghribSound: 'adhan',
      enabledIsha: true,
      ishaSound: 'adhan',
      beforePrayerMinutes: 10,
    );
  }

  static Future<PrayerSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    
    return PrayerSettings(
      enabledFajr: prefs.getBool('fajr_enabled') ?? true,
      fajrSound: prefs.getString('fajr_sound') ?? 'adhan',
      enabledDhuhr: prefs.getBool('dhuhr_enabled') ?? true,
      dhuhrSound: prefs.getString('dhuhr_sound') ?? 'adhan',
      enabledAsr: prefs.getBool('asr_enabled') ?? true,
      asrSound: prefs.getString('asr_sound') ?? 'adhan',
      enabledMaghrib: prefs.getBool('maghrib_enabled') ?? true,
      maghribSound: prefs.getString('maghrib_sound') ?? 'adhan',
      enabledIsha: prefs.getBool('isha_enabled') ?? true,
      ishaSound: prefs.getString('isha_sound') ?? 'adhan',
      beforePrayerMinutes: prefs.getInt('before_prayer_min') ?? 10,
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fajr_enabled', enabledFajr);
    await prefs.setString('fajr_sound', fajrSound);
    await prefs.setBool('dhuhr_enabled', enabledDhuhr);
    await prefs.setString('dhuhr_sound', dhuhrSound);
    await prefs.setBool('asr_enabled', enabledAsr);
    await prefs.setString('asr_sound', asrSound);
    await prefs.setBool('maghrib_enabled', enabledMaghrib);
    await prefs.setString('maghrib_sound', maghribSound);
    await prefs.setBool('isha_enabled', enabledIsha);
    await prefs.setString('isha_sound', ishaSound);
    await prefs.setInt('before_prayer_min', beforePrayerMinutes);
  }
}
