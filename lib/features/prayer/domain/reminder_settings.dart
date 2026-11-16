import 'package:shared_preferences/shared_preferences.dart';

/// Optional daily reminders: Morning Azkar, Evening Azkar, Ayah of the day.
/// Each one is OFF-able and has its own sound mode ('silent' | 'short').
class ReminderSettings {
  final bool morningEnabled;
  final String morningSound;
  final int morningAfterFajrMin; // default 120 = two hours after Fajr

  final bool eveningEnabled;
  final String eveningSound;
  final int eveningAfterAsrMin; // default 30, always clamped before Maghrib

  /// Friday: Salawat verse + Surat Al-Kahf reminders (5 alerts, Thursday night → Friday Asr).
  final bool fridayEnabled;
  final String fridaySound; // 'short' (own chime) | 'silent'

  final bool ayahEnabled;
  final String ayahSound;
  final int ayahHour;
  final int ayahMinute;

  const ReminderSettings({
    this.morningEnabled = true,
    this.morningSound = 'short',
    this.morningAfterFajrMin = 120,
    this.eveningEnabled = true,
    this.eveningSound = 'short',
    this.eveningAfterAsrMin = 30,
    this.fridayEnabled = true,
    this.fridaySound = 'short',
    this.ayahEnabled = true,
    this.ayahSound = 'short',
    this.ayahHour = 9,
    this.ayahMinute = 0,
  });

  ReminderSettings copyWith({
    bool? morningEnabled,
    String? morningSound,
    int? morningAfterFajrMin,
    bool? eveningEnabled,
    String? eveningSound,
    int? eveningAfterAsrMin,
    bool? fridayEnabled,
    String? fridaySound,
    bool? ayahEnabled,
    String? ayahSound,
    int? ayahHour,
    int? ayahMinute,
  }) =>
      ReminderSettings(
        morningEnabled: morningEnabled ?? this.morningEnabled,
        morningSound: morningSound ?? this.morningSound,
        morningAfterFajrMin: morningAfterFajrMin ?? this.morningAfterFajrMin,
        eveningEnabled: eveningEnabled ?? this.eveningEnabled,
        eveningSound: eveningSound ?? this.eveningSound,
        eveningAfterAsrMin: eveningAfterAsrMin ?? this.eveningAfterAsrMin,
        fridayEnabled: fridayEnabled ?? this.fridayEnabled,
        fridaySound: fridaySound ?? this.fridaySound,
        ayahEnabled: ayahEnabled ?? this.ayahEnabled,
        ayahSound: ayahSound ?? this.ayahSound,
        ayahHour: ayahHour ?? this.ayahHour,
        ayahMinute: ayahMinute ?? this.ayahMinute,
      );

  static ReminderSettings? _cached;
  static ReminderSettings get current => _cached ?? const ReminderSettings();

  static Future<ReminderSettings> load({bool fresh = false}) async {
    if (_cached != null && !fresh) return _cached!;
    final prefs = await SharedPreferences.getInstance();
    if (fresh) await prefs.reload();
    String snd(String? s) => s == 'silent' ? 'silent' : 'short';
    const d = ReminderSettings();
    _cached = ReminderSettings(
      morningEnabled: prefs.getBool('rem_morning_on') ?? d.morningEnabled,
      morningSound: snd(prefs.getString('rem_morning_sound')),
      morningAfterFajrMin: prefs.getInt('rem_morning_after') ?? d.morningAfterFajrMin,
      eveningEnabled: prefs.getBool('rem_evening_on') ?? d.eveningEnabled,
      eveningSound: snd(prefs.getString('rem_evening_sound')),
      eveningAfterAsrMin: prefs.getInt('rem_evening_after') ?? d.eveningAfterAsrMin,
      fridayEnabled: prefs.getBool('rem_friday_on') ?? d.fridayEnabled,
      fridaySound: snd(prefs.getString('rem_friday_sound')),
      ayahEnabled: prefs.getBool('rem_ayah_on') ?? d.ayahEnabled,
      ayahSound: snd(prefs.getString('rem_ayah_sound')),
      ayahHour: prefs.getInt('rem_ayah_h') ?? d.ayahHour,
      ayahMinute: prefs.getInt('rem_ayah_m') ?? d.ayahMinute,
    );
    return _cached!;
  }

  Future<void> save() async {
    _cached = this;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rem_morning_on', morningEnabled);
    await prefs.setString('rem_morning_sound', morningSound);
    await prefs.setInt('rem_morning_after', morningAfterFajrMin);
    await prefs.setBool('rem_evening_on', eveningEnabled);
    await prefs.setString('rem_evening_sound', eveningSound);
    await prefs.setInt('rem_evening_after', eveningAfterAsrMin);
    await prefs.setBool('rem_friday_on', fridayEnabled);
    await prefs.setString('rem_friday_sound', fridaySound);
    await prefs.setBool('rem_ayah_on', ayahEnabled);
    await prefs.setString('rem_ayah_sound', ayahSound);
    await prefs.setInt('rem_ayah_h', ayahHour);
    await prefs.setInt('rem_ayah_m', ayahMinute);
  }
}
