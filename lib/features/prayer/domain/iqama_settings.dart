import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// A mosque (or "my usual mosque") with its own iqama delay for each prayer.
class MosqueProfile {
  final String name;
  /// Minutes between the Adhan and the iqama, Fajr..Isha.
  final List<int> minutes;
  const MosqueProfile(this.name, this.minutes);

  MosqueProfile copyWith({String? name, List<int>? minutes}) =>
      MosqueProfile(name ?? this.name, minutes ?? this.minutes);

  Map<String, dynamic> toJson() => {'n': name, 'm': minutes};

  factory MosqueProfile.fromJson(Map<String, dynamic> j) => MosqueProfile(
        (j['n'] as String?) ?? 'Mosque',
        ((j['m'] as List?) ?? const [25, 15, 15, 8, 15]).map((e) => (e as num).toInt().clamp(1, 90)).toList(),
      );
}

/// "Iqama / X minutes after the Adhan" alert, per prayer and per mosque.
class IqamaSettings {
  final bool enabled;
  final List<MosqueProfile> profiles;
  final int active;
  final List<bool> perPrayer;
  /// 'short' | 'silent'
  final String sound;

  const IqamaSettings({
    required this.enabled,
    required this.profiles,
    required this.active,
    required this.perPrayer,
    required this.sound,
  });

  MosqueProfile get profile => profiles[active.clamp(0, profiles.length - 1)];

  static List<MosqueProfile> defaultProfiles(bool ar) =>
      [MosqueProfile(ar ? 'مسجدي' : 'My mosque', const [25, 15, 15, 8, 15])];

  factory IqamaSettings.defaults({bool ar = true}) => IqamaSettings(
        enabled: false,
        profiles: defaultProfiles(ar),
        active: 0,
        perPrayer: const [true, true, true, true, true],
        sound: 'short',
      );

  IqamaSettings copyWith({
    bool? enabled,
    List<MosqueProfile>? profiles,
    int? active,
    List<bool>? perPrayer,
    String? sound,
  }) =>
      IqamaSettings(
        enabled: enabled ?? this.enabled,
        profiles: profiles ?? this.profiles,
        active: active ?? this.active,
        perPrayer: perPrayer ?? this.perPrayer,
        sound: sound ?? this.sound,
      );

  IqamaSettings withMinutes(int prayer, int minutes) {
    final ps = [...profiles];
    final m = [...profile.minutes];
    m[prayer] = minutes.clamp(1, 90);
    ps[active] = profile.copyWith(minutes: m);
    return copyWith(profiles: ps);
  }

  IqamaSettings withPrayer(int i, bool v) {
    final l = [...perPrayer];
    l[i] = v;
    return copyWith(perPrayer: l);
  }

  static IqamaSettings? _cached;
  static IqamaSettings get current => _cached ?? IqamaSettings.defaults();

  static Future<IqamaSettings> load({bool fresh = false, bool ar = true}) async {
    if (_cached != null && !fresh) return _cached!;
    final p = await SharedPreferences.getInstance();
    if (fresh) {
      try {
        await p.reload();
      } catch (_) {}
    }
    var profiles = defaultProfiles(ar);
    try {
      final raw = p.getString('iqama_profiles');
      if (raw != null) {
        final l = (jsonDecode(raw) as List).map((e) => MosqueProfile.fromJson((e as Map).cast<String, dynamic>())).toList();
        if (l.isNotEmpty) profiles = l;
      }
    } catch (_) {}
    final per = p.getStringList('iqama_per') ?? const [];
    _cached = IqamaSettings(
      enabled: p.getBool('iqama_enabled') ?? false,
      profiles: profiles,
      active: (p.getInt('iqama_active') ?? 0).clamp(0, profiles.length - 1),
      perPrayer: per.length == 5 ? [for (final v in per) v == '1'] : const [true, true, true, true, true],
      sound: p.getString('iqama_sound') ?? 'short',
    );
    return _cached!;
  }

  Future<void> save() async {
    _cached = this;
    final p = await SharedPreferences.getInstance();
    await p.setBool('iqama_enabled', enabled);
    await p.setString('iqama_profiles', jsonEncode(profiles.map((e) => e.toJson()).toList()));
    await p.setInt('iqama_active', active);
    await p.setStringList('iqama_per', [for (final v in perPrayer) v ? '1' : '0']);
    await p.setString('iqama_sound', sound);
  }
}
