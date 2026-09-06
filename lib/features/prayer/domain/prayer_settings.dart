import 'package:shared_preferences/shared_preferences.dart';

class PrayerSettings {
  final bool enabledFajr;
  final bool enabledDhuhr;
  final bool enabledAsr;
  final bool enabledMaghrib;
  final bool enabledIsha;
  final int beforePrayerMinutes;

  PrayerSettings({
    required this.enabledFajr,
    required this.enabledDhuhr,
    required this.enabledAsr,
    required this.enabledMaghrib,
    required this.enabledIsha,
    required this.beforePrayerMinutes,
  });

  PrayerSettings copyWith({
    bool? enabledFajr,
    bool? enabledDhuhr,
    bool? enabledAsr,
    bool? enabledMaghrib,
    bool? enabledIsha,
    int? beforePrayerMinutes,
  }) {
    return PrayerSettings(
      enabledFajr: enabledFajr ?? this.enabledFajr,
      enabledDhuhr: enabledDhuhr ?? this.enabledDhuhr,
      enabledAsr: enabledAsr ?? this.enabledAsr,
      enabledMaghrib: enabledMaghrib ?? this.enabledMaghrib,
      enabledIsha: enabledIsha ?? this.enabledIsha,
      beforePrayerMinutes: beforePrayerMinutes ?? this.beforePrayerMinutes,
    );
  }

  factory PrayerSettings.defaultSettings() {
    return PrayerSettings(
      enabledFajr: true,
      enabledDhuhr: true,
      enabledAsr: true,
      enabledMaghrib: true,
      enabledIsha: true,
      beforePrayerMinutes: 10,
    );
  }

  static Future<PrayerSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    
    return PrayerSettings(
      enabledFajr: prefs.getBool('fajr_enabled') ?? true,
      enabledDhuhr: prefs.getBool('dhuhr_enabled') ?? true,
      enabledAsr: prefs.getBool('asr_enabled') ?? true,
      enabledMaghrib: prefs.getBool('maghrib_enabled') ?? true,
      enabledIsha: prefs.getBool('isha_enabled') ?? true,
      beforePrayerMinutes: prefs.getInt('before_prayer_min') ?? 10,
    );
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fajr_enabled', enabledFajr);
    await prefs.setBool('dhuhr_enabled', enabledDhuhr);
    await prefs.setBool('asr_enabled', enabledAsr);
    await prefs.setBool('maghrib_enabled', enabledMaghrib);
    await prefs.setBool('isha_enabled', enabledIsha);
    await prefs.setInt('before_prayer_min', beforePrayerMinutes);
  }
}
