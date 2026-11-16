import 'dart:async';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/services/telemetry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/iqama_settings.dart';
import '../../domain/prayer_mode_settings.dart';
import '../widgets/notification_option_widgets.dart';

/// "Prayer mode & Iqama":
///  * Prayer mode — the phone goes silent for N minutes after the Adhan and comes back by itself.
///  * Iqama — an alert "X minutes after the Adhan", per prayer and per mosque.
class PrayerModeScreen extends StatefulWidget {
  const PrayerModeScreen({super.key});

  @override
  State<PrayerModeScreen> createState() => _PrayerModeScreenState();
}

class _PrayerModeScreenState extends State<PrayerModeScreen> with WidgetsBindingObserver {
  PrayerModeSettings _pm = PrayerModeSettings.current;
  IqamaSettings _iq = IqamaSettings.current;
  bool _dnd = false;
  bool _loaded = false;
  Timer? _debounce;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
      NotificationCoordinator.instance.rescheduleAll(force: true);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _checkDnd();
  }

  Future<void> _load() async {
    final pm = await PrayerModeSettings.load();
    final iq = await IqamaSettings.load(ar: _ar);
    await _checkDnd();
    if (!mounted) return;
    setState(() {
      _pm = pm;
      _iq = iq;
      _loaded = true;
    });
  }

  Future<void> _checkDnd() async {
    var g = false;
    try {
      g = !kIsWeb && await Permission.accessNotificationPolicy.isGranted;
    } catch (_) {}
    if (mounted) setState(() => _dnd = g);
  }

  Future<void> _openDndSettings() async {
    try {
      await const AndroidIntent(action: 'android.settings.NOTIFICATION_POLICY_ACCESS_SETTINGS').launch();
    } catch (_) {
      await openAppSettings();
    }
  }

  void _commitPm(PrayerModeSettings n) {
    setState(() => _pm = n);
    n.save();
    Telemetry.log('prayer_mode_saved', {'on': n.enabled, 'start': n.startAfterMin, 'dur': n.durationMin});
    _later();
  }

  void _commitIq(IqamaSettings n) {
    setState(() => _iq = n);
    n.save();
    Telemetry.log('iqama_saved', {'on': n.enabled, 'profile': n.active});
    _later();
  }

  void _later() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      NotificationCoordinator.instance.rescheduleAll(force: true);
    });
  }

  Future<void> _editProfileName({required bool create}) async {
    final c = TextEditingController(text: create ? '' : _iq.profile.name);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(create ? t('إضافة مسجد', 'Add a mosque') : t('تعديل اسم المسجد', 'Rename mosque')),
        content: TextField(controller: c, autofocus: true, decoration: InputDecoration(hintText: t('اسم المسجد', 'Mosque name'))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t('إلغاء', 'Cancel'))),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t('حفظ', 'Save'))),
        ],
      ),
    );
    final name = c.text.trim();
    if (ok != true || name.isEmpty) return;
    final ps = [..._iq.profiles];
    if (create) {
      ps.add(MosqueProfile(name, [..._iq.profile.minutes]));
      _commitIq(_iq.copyWith(profiles: ps, active: ps.length - 1));
    } else {
      ps[_iq.active] = _iq.profile.copyWith(name: name);
      _commitIq(_iq.copyWith(profiles: ps));
    }
  }

  void _deleteProfile() {
    if (_iq.profiles.length <= 1) return;
    final ps = [..._iq.profiles]..removeAt(_iq.active);
    _commitIq(_iq.copyWith(profiles: ps, active: 0));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final names = [l.fajr, l.dhuhr, l.asr, l.maghrib, l.isha];

    return Scaffold(
      appBar: AppBar(title: Text(t('وضع الصلاة والإقامة', 'Prayer mode & Iqama'))),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ================= Prayer mode
                SettingCard(
                  icon: Icons.do_not_disturb_on_rounded,
                  title: t('وضع الصلاة (كتم تلقائي)', 'Prayer mode (auto-silence)'),
                  subtitle: t('يكتم الموبايل بعد الأذان ويرجّعه لوضعه الطبيعي لوحده', 'Silences the phone after the Adhan and restores it automatically'),
                  enabled: _pm.enabled,
                  onToggle: (v) => _commitPm(_pm.copyWith(enabled: v)),
                  child: !_pm.enabled
                      ? null
                      : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          if (!_dnd)
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: cs.tertiaryContainer, borderRadius: BorderRadius.circular(14)),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Text(
                                  t('للكتم الكامل (المكالمات والإشعارات مع بقاء الأذان والمنبّهات) فعّل «الوصول إلى عدم الإزعاج». بدونه هنحوّل الموبايل لوضع الاهتزاز فقط.',
                                      'For full silence (calls & notifications, Adhan/alarms still ring) enable "Do Not Disturb access". Without it we only switch to vibrate.'),
                                  style: TextStyle(color: cs.onTertiaryContainer, fontSize: 13, height: 1.45),
                                ),
                                const SizedBox(height: 6),
                                FilledButton.tonal(onPressed: _openDndSettings, child: Text(t('فتح الإعداد', 'Open setting'))),
                              ]),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(children: [
                                Icon(Icons.check_circle_rounded, color: Colors.green.shade600, size: 18),
                                const SizedBox(width: 6),
                                Text(t('صلاحية عدم الإزعاج مفعّلة', 'Do Not Disturb access granted'), style: const TextStyle(fontSize: 13)),
                              ]),
                            ),
                          Text(t('يبدأ الكتم بعد الأذان بـ', 'Silence starts after the Adhan by'), style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Wrap(spacing: 8, children: [
                            for (final m in const [0, 2, 3, 5, 10])
                              ChoiceChip(
                                label: Text(m == 0 ? t('فورًا', 'Now') : t('$m د', '$m min')),
                                selected: _pm.startAfterMin == m,
                                onSelected: (_) => _commitPm(_pm.copyWith(startAfterMin: m)),
                              ),
                          ]),
                          const SizedBox(height: 10),
                          Text(t('مدة الكتم', 'Silence duration'), style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Wrap(spacing: 8, children: [
                            for (final m in const [5, 10, 12, 15, 20, 30])
                              ChoiceChip(
                                label: Text(t('$m د', '$m min')),
                                selected: _pm.durationMin == m,
                                onSelected: (_) => _commitPm(_pm.copyWith(durationMin: m)),
                              ),
                          ]),
                          const SizedBox(height: 10),
                          Text(t('الصلوات المشمولة', 'Prayers included'), style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Wrap(spacing: 8, children: [
                            for (var i = 0; i < 5; i++)
                              FilterChip(
                                label: Text(names[i]),
                                selected: _pm.perPrayer[i],
                                onSelected: (v) => _commitPm(_pm.withPrayer(i, v)),
                              ),
                          ]),
                          const SizedBox(height: 8),
                          Text(
                            t('لو كان موبايلك أصلًا صامت أو في عدم الإزعاج، لن نغيّر شيئًا. ولو غيّرته بنفسك أثناء الكتم، نحترم اختيارك.',
                                'If your phone is already silent / in DND we change nothing, and if you change it yourself during the silence we respect that.'),
                            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, height: 1.4),
                          ),
                        ]),
                ),
                // ================= Iqama
                SettingCard(
                  icon: Icons.mosque_rounded,
                  title: t('تنبيه الإقامة (بعد الأذان بـ X دقيقة)', 'Iqama alert (X minutes after the Adhan)'),
                  subtitle: t('بوقت تختاره لكل صلاة ولكل مسجد', 'Your own delay for each prayer and each mosque'),
                  enabled: _iq.enabled,
                  onToggle: (v) => _commitIq(_iq.copyWith(enabled: v)),
                  child: !_iq.enabled
                      ? null
                      : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(t('المسجد', 'Mosque'), style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Wrap(spacing: 8, runSpacing: 4, children: [
                            for (var k = 0; k < _iq.profiles.length; k++)
                              ChoiceChip(
                                label: Text(_iq.profiles[k].name),
                                selected: _iq.active == k,
                                onSelected: (_) => _commitIq(_iq.copyWith(active: k)),
                              ),
                            ActionChip(
                              avatar: const Icon(Icons.add_rounded, size: 18),
                              label: Text(t('مسجد جديد', 'New mosque')),
                              onPressed: () => _editProfileName(create: true),
                            ),
                          ]),
                          Row(children: [
                            TextButton.icon(
                                onPressed: () => _editProfileName(create: false),
                                icon: const Icon(Icons.edit_rounded, size: 18),
                                label: Text(t('تسمية', 'Rename'))),
                            if (_iq.profiles.length > 1)
                              TextButton.icon(
                                  onPressed: _deleteProfile,
                                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                                  label: Text(t('حذف', 'Delete'))),
                          ]),
                          const Divider(),
                          for (var i = 0; i < 5; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(children: [
                                Switch(value: _iq.perPrayer[i], onChanged: (v) => _commitIq(_iq.withPrayer(i, v))),
                                Expanded(child: Text(names[i], style: const TextStyle(fontWeight: FontWeight.w600))),
                                IconButton(
                                  onPressed: _iq.perPrayer[i] ? () => _commitIq(_iq.withMinutes(i, _iq.profile.minutes[i] - 1)) : null,
                                  icon: const Icon(Icons.remove_circle_outline_rounded),
                                ),
                                SizedBox(
                                  width: 58,
                                  child: Text(t('${_iq.profile.minutes[i]} د', '${_iq.profile.minutes[i]} min'),
                                      textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                IconButton(
                                  onPressed: _iq.perPrayer[i] ? () => _commitIq(_iq.withMinutes(i, _iq.profile.minutes[i] + 1)) : null,
                                  icon: const Icon(Icons.add_circle_outline_rounded),
                                ),
                              ]),
                            ),
                          const SizedBox(height: 6),
                          Text(t('نوع التنبيه', 'Alert type'), style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          Wrap(spacing: 8, children: [
                            ChoiceChip(
                              label: Text(t('نغمة قصيرة', 'Short tone')),
                              selected: _iq.sound == 'short',
                              onSelected: (_) => _commitIq(_iq.copyWith(sound: 'short')),
                            ),
                            ChoiceChip(
                              label: Text(t('صامت', 'Silent')),
                              selected: _iq.sound == 'silent',
                              onSelected: (_) => _commitIq(_iq.copyWith(sound: 'silent')),
                            ),
                          ]),
                        ]),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}
