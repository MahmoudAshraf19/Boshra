import 'package:shared_preferences/shared_preferences.dart';

/// Prayer mode = auto-silence the phone for a few minutes after the Adhan, then restore it.
class PrayerModeSettings {
  final bool enabled;
  /// Minutes after the prayer time when silence starts (lets the Adhan finish first).
  final int startAfterMin;
  /// How long the phone stays silent.
  final int durationMin;
  final List<bool> perPrayer;

  const PrayerModeSettings({
    required this.enabled,
    required this.startAfterMin,
    required this.durationMin,
    required this.perPrayer,
  });

  factory PrayerModeSettings.defaults() => const PrayerModeSettings(
        enabled: false, // needs the user's explicit consent (it changes phone sound state)
        startAfterMin: 3,
        durationMin: 12,
        perPrayer: [true, true, true, true, true],
      );

  PrayerModeSettings copyWith({bool? enabled, int? startAfterMin, int? durationMin, List<bool>? perPrayer}) =>
      PrayerModeSettings(
        enabled: enabled ?? this.enabled,
        startAfterMin: startAfterMin ?? this.startAfterMin,
        durationMin: durationMin ?? this.durationMin,
        perPrayer: perPrayer ?? this.perPrayer,
      );

  PrayerModeSettings withPrayer(int i, bool v) {
    final l = [...perPrayer];
    l[i] = v;
    return copyWith(perPrayer: l);
  }

  static PrayerModeSettings? _cached;
  static PrayerModeSettings get current => _cached ?? PrayerModeSettings.defaults();

  static Future<PrayerModeSettings> load({bool fresh = false}) async {
    if (_cached != null && !fresh) return _cached!;
    final p = await SharedPreferences.getInstance();
    if (fresh) {
      try {
        await p.reload();
      } catch (_) {}
    }
    final d = PrayerModeSettings.defaults();
    final per = p.getStringList('pm_per') ?? const [];
    _cached = PrayerModeSettings(
      enabled: p.getBool('pm_enabled') ?? d.enabled,
      startAfterMin: (p.getInt('pm_start') ?? d.startAfterMin).clamp(0, 30),
      durationMin: (p.getInt('pm_dur') ?? d.durationMin).clamp(3, 60),
      perPrayer: per.length == 5 ? [for (final v in per) v == '1'] : d.perPrayer,
    );
    return _cached!;
  }

  Future<void> save() async {
    _cached = this;
    final p = await SharedPreferences.getInstance();
    await p.setBool('pm_enabled', enabled);
    await p.setInt('pm_start', startAfterMin);
    await p.setInt('pm_dur', durationMin);
    await p.setStringList('pm_per', [for (final v in perPrayer) v ? '1' : '0']);
  }
}
