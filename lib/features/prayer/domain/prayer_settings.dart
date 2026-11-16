import 'package:shared_preferences/shared_preferences.dart';

/// Prayer-time notification settings (everything is under the user's control).
class PrayerSettings {
  static const keys = ['fajr', 'dhuhr', 'asr', 'maghrib', 'isha'];

  /// Per prayer (Fajr, Dhuhr, Asr, Maghrib, Isha).
  final List<bool> enabled;
  final List<String> sounds; // 'silent' | 'short' | 'adhan'
  final List<int> offsets; // minutes, -15..+15

  /// Optional alert BEFORE the prayer (off by default).
  final bool preEnabled;
  final int beforePrayerMinutes;
  final String preSound; // 'silent' | 'short'

  final String adhanReciter;
  /// Rich in-app banner (with Stop) while the app is open. The notification itself
  /// ALWAYS has a Stop button.
  final bool adhanBanner;

  /// Aladhan method id, -1 = automatic by location.
  final int calcMethod;
  /// 0 = Shafi'i/Maliki/Hanbali, 1 = Hanafi.
  final int asrSchool;

  const PrayerSettings({
    required this.enabled,
    required this.sounds,
    required this.offsets,
    required this.preEnabled,
    required this.beforePrayerMinutes,
    required this.preSound,
    required this.adhanReciter,
    required this.adhanBanner,
    required this.calcMethod,
    required this.asrSchool,
  });

  factory PrayerSettings.defaults() => PrayerSettings(
        enabled: List.filled(5, true),
        sounds: List.filled(5, 'adhan'),
        offsets: List.filled(5, 0),
        preEnabled: false,
        beforePrayerMinutes: 10,
        preSound: 'short',
        adhanReciter: 'mohammed_refat',
        adhanBanner: true,
        calcMethod: -1,
        asrSchool: 0,
      );

  PrayerSettings copyWith({
    bool? preEnabled,
    int? beforePrayerMinutes,
    String? preSound,
    String? adhanReciter,
    bool? adhanBanner,
    int? calcMethod,
    int? asrSchool,
  }) =>
      PrayerSettings(
        enabled: enabled,
        sounds: sounds,
        offsets: offsets,
        preEnabled: preEnabled ?? this.preEnabled,
        beforePrayerMinutes: beforePrayerMinutes ?? this.beforePrayerMinutes,
        preSound: preSound ?? this.preSound,
        adhanReciter: adhanReciter ?? this.adhanReciter,
        adhanBanner: adhanBanner ?? this.adhanBanner,
        calcMethod: calcMethod ?? this.calcMethod,
        asrSchool: asrSchool ?? this.asrSchool,
      );

  PrayerSettings _withLists({List<bool>? enabled, List<String>? sounds, List<int>? offsets}) =>
      PrayerSettings(
        enabled: enabled ?? this.enabled,
        sounds: sounds ?? this.sounds,
        offsets: offsets ?? this.offsets,
        preEnabled: preEnabled,
        beforePrayerMinutes: beforePrayerMinutes,
        preSound: preSound,
        adhanReciter: adhanReciter,
        adhanBanner: adhanBanner,
        calcMethod: calcMethod,
        asrSchool: asrSchool,
      );

  PrayerSettings withEnabled(int i, bool v) =>
      _withLists(enabled: [...enabled]..[i] = v);
  PrayerSettings withSound(int i, String v) =>
      _withLists(sounds: [...sounds]..[i] = v);
  PrayerSettings withOffset(int i, int v) =>
      _withLists(offsets: [...offsets]..[i] = v.clamp(-15, 15));

  /// Prayers that currently play the full Adhan.
  List<int> get adhanSlots =>
      [for (var i = 0; i < 5; i++) if (enabled[i] && sounds[i] == 'adhan') i];
  List<int> get enabledSlots => [for (var i = 0; i < 5; i++) if (enabled[i]) i];

  static PrayerSettings? _cached;
  static PrayerSettings get current => _cached ?? PrayerSettings.defaults();

  /// [fresh] re-reads the disk (needed when another isolate may have written).
  static Future<PrayerSettings> load({bool fresh = false}) async {
    if (_cached != null && !fresh) return _cached!;
    final prefs = await SharedPreferences.getInstance();
    if (fresh) await prefs.reload();
    String snd(String? s) => (s == 'silent' || s == 'short' || s == 'adhan') ? s! : 'adhan';
    _cached = PrayerSettings(
      enabled: [for (final k in keys) prefs.getBool('${k}_enabled') ?? true],
      sounds: [for (final k in keys) snd(prefs.getString('${k}_sound'))],
      offsets: [for (final k in keys) prefs.getInt('${k}_offset') ?? 0],
      preEnabled: prefs.getBool('pre_enabled') ?? false,
      beforePrayerMinutes: prefs.getInt('before_prayer_min') ?? 10,
      preSound: prefs.getString('pre_sound') == 'silent' ? 'silent' : 'short',
      adhanReciter: prefs.getString('adhan_reciter') ?? 'mohammed_refat',
      adhanBanner: prefs.getBool('adhan_banner_enabled') ?? true,
      calcMethod: prefs.getInt('calc_method') ?? -1,
      asrSchool: prefs.getInt('asr_school') ?? 0,
    );
    return _cached!;
  }

  Future<void> save() async {
    _cached = this;
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < 5; i++) {
      await prefs.setBool('${keys[i]}_enabled', enabled[i]);
      await prefs.setString('${keys[i]}_sound', sounds[i]);
      await prefs.setInt('${keys[i]}_offset', offsets[i]);
    }
    await prefs.setBool('pre_enabled', preEnabled);
    await prefs.setInt('before_prayer_min', beforePrayerMinutes);
    await prefs.setString('pre_sound', preSound);
    await prefs.setString('adhan_reciter', adhanReciter);
    await prefs.setBool('adhan_banner_enabled', adhanBanner);
    await prefs.setInt('calc_method', calcMethod);
    await prefs.setInt('asr_school', asrSchool);
  }
}
