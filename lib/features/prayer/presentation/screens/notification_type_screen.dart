import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/adhan_reciters.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/permissions/permission_center.dart';
import '../../../../core/services/adhan_native_service.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/services/telemetry.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import '../../domain/prayer_settings.dart';

/// "What should each prayer do?" — Full Adhan / Short alert / Silent, per prayer, with a real
/// PREVIEW button for each type (so the user hears exactly what will happen) and an
/// "apply to all" row. Saves instantly and re-schedules (debounced).
class NotificationTypeScreen extends StatefulWidget {
  const NotificationTypeScreen({super.key});

  @override
  State<NotificationTypeScreen> createState() => _NotificationTypeScreenState();
}

class _NotificationTypeScreenState extends State<NotificationTypeScreen> with WidgetsBindingObserver {
  PrayerSettings _s = PrayerSettings.current;
  Timer? _debounce;
  ReliabilityStatus? _st;
  bool _loaded = false;
  bool _dhikr = true;
  bool _weekly = true;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
      _apply();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _checkPerms();
  }

  Future<void> _load() async {
    final s = await PrayerSettings.load();
    final st = await PermissionCenter.check(force: true);
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _dhikr = prefs.getBool('dhikr_hint') ?? true;
        _weekly = prefs.getBool('weekly_summary') ?? true;
        _s = s;
        _st = st;
        _loaded = true;
      });
    }
  }

  Future<void> _checkPerms() async {
    final st = await PermissionCenter.check(force: true);
    if (mounted) setState(() => _st = st);
  }

  void _commit(PrayerSettings n) {
    setState(() => _s = n);
    n.save();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), _apply);
  }

  Future<void> _apply() async {
    await NotificationCoordinator.instance.rescheduleAll(force: true);
    await HomeController.instance?.refreshData();
    Telemetry.log('notif_types_saved', {'sounds': _s.sounds.join(',')});
  }

  Future<void> _setPref(String key, bool v) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, v);
    setState(() {
      if (key == 'dhikr_hint') _dhikr = v;
      if (key == 'weekly_summary') _weekly = v;
    });
    Telemetry.log('pref_$key', {'on': v});
    NotificationCoordinator.instance.rescheduleAll(force: true);
  }

  void _setAll(String v) {
    var n = _s;
    for (var i = 0; i < 5; i++) {
      n = n.withSound(i, v);
    }
    _commit(n);
  }

  Future<void> _preview(int i, String type, String prayerName) async {
    final l = AppLocalizations.of(context)!;
    final title = l.prayerNotifTitle(prayerName);
    final sm = ScaffoldMessenger.of(context);
    if (type == 'adhan') {
      final r = AdhanReciters.byId(_s.adhanReciter);
      final ok = await AdhanNativeService.instance.startAdhan(
        id: 9,
        title: title,
        body: l.prayerNotifBody,
        rawSound: r.rawName,
        stopLabel: l.adhanStopAction,
      );
      Telemetry.log('notif_preview', {'type': 'adhan', 'ok': ok});
      if (!ok && mounted) {
        sm.showSnackBar(SnackBar(content: Text(t('تعذّر تشغيل الأذان — افتح "هل الأذان هيشتغل؟" للتشخيص', 'Could not play — open the diagnostics screen'))));
      }
      return;
    }
    final ok = await NotificationService().showNow(
      id: 8,
      title: title,
      body: type == 'silent'
          ? t('إشعار صامت — بدون صوت ولا اهتزاز', 'Silent alert — no sound or vibration')
          : l.prayerNotifBody,
      sound: type == 'silent' ? NotificationSound.silent : NotificationSound.short,
    );
    Telemetry.log('notif_preview', {'type': type, 'ok': ok});
    if (!ok && mounted) {
      sm.showSnackBar(SnackBar(content: Text(t('الإشعارات غير مفعّلة على الجهاز', 'Notifications are disabled on this device'))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final names = [l.fajr, l.dhuhr, l.asr, l.maghrib, l.isha];

    final types = <({String id, IconData icon, String name, String desc})>[
      (id: 'adhan', icon: Icons.mosque_rounded, name: t('أذان كامل', 'Full Adhan'), desc: t('صوت المؤذن كاملًا حتى لو التطبيق مقفول، مع زر إيقاف', 'Full Muadhin audio even when the app is closed, with a Stop button')),
      (id: 'short', icon: Icons.notifications_active_rounded, name: t('تنبيه قصير', 'Short alert'), desc: t('نغمة قصيرة مع إشعار يظهر على الشاشة', 'A brief tone with a heads-up notification')),
      (id: 'silent', icon: Icons.notifications_off_rounded, name: t('صامت', 'Silent'), desc: t('إشعار مرئي فقط، بدون صوت ولا اهتزاز', 'Visual only — no sound or vibration')),
    ];

    final st = _st;
    final needNotif = st != null && !st.notifications;
    final needExact = st != null && st.notifications && !st.exactAlarm && _s.sounds.contains('adhan');

    return Scaffold(
      appBar: AppBar(title: Text(t('نوع إشعار الصلاة', 'Prayer alert type'))),
      body: !_loaded
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (needNotif)
                  _Warn(
                    text: t('الإشعارات مقفولة على الجهاز — مفيش نوع هيظهر.', 'Notifications are blocked — nothing can show.'),
                    action: t('تفعيل', 'Enable'),
                    onTap: () async {
                      await PermissionCenter.requestNotifications();
                      await _checkPerms();
                    },
                  ),
                if (needExact)
                  _Warn(
                    text: t('الأذان محتاج إذن "المنبّهات والتذكيرات" عشان يشتغل في الثانية المضبوطة.', 'The Adhan needs "Alarms & reminders" to ring exactly on time.'),
                    action: t('السماح', 'Allow'),
                    onTap: () async {
                      await PermissionCenter.requestExactAlarm();
                      await _checkPerms();
                    },
                  ),
                // legend
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(18)),
                  child: Column(children: [
                    for (final ty in types)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Icon(ty.icon, color: cs.primary, size: 22),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text.rich(TextSpan(children: [
                              TextSpan(text: '${ty.name}: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: ty.desc),
                            ]), style: const TextStyle(fontSize: 13, height: 1.4)),
                          ),
                        ]),
                      ),
                  ]),
                ),
                const SizedBox(height: 14),
                Text(t('تطبيق على كل الصلوات', 'Apply to all prayers'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: [
                  for (final ty in types)
                    ActionChip(
                      avatar: Icon(ty.icon, size: 18),
                      label: Text(ty.name),
                      onPressed: () => _setAll(ty.id),
                    ),
                ]),
                const SizedBox(height: 18),
                for (var i = 0; i < 5; i++)
                  Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 12),
                    color: cs.surfaceContainerLow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Expanded(child: Text(names[i], style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold))),
                          Switch(value: _s.enabled[i], onChanged: (v) => _commit(_s.withEnabled(i, v))),
                        ]),
                        if (!_s.enabled[i])
                          Text(t('التنبيه متوقف لهذه الصلاة', 'Alerts are off for this prayer'),
                              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13))
                        else
                          for (final ty in types)
                            _TypeTile(
                              icon: ty.icon,
                              name: ty.name,
                              selected: _s.sounds[i] == ty.id,
                              onSelect: () => _commit(_s.withSound(i, ty.id)),
                              onPreview: () => _preview(i, ty.id, names[i]),
                              previewTip: t('تجربة', 'Preview'),
                            ),
                      ]),
                    ),
                  ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.menu_book_rounded),
                  title: Text(t('اقتراح الأذكار مع إشعار الأذان', 'Suggest adhkar in the Adhan notification')),
                  subtitle: Text(t('بعد الفجر: أذكار الصباح · بعد العصر: المساء · بعد العشاء: النوم · وإلا: التسبيح — اضغط الإشعار لتقرأها',
                      'After Fajr: morning · after Asr: evening · after Isha: bedtime · else: tasbeeh — tap the notification to read')),
                  value: _dhikr,
                  onChanged: (v) => _setPref('dhikr_hint', v),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: const Icon(Icons.insights_rounded),
                  title: Text(t('ملخّص أسبوعي كل جمعة', 'Weekly summary every Friday')),
                  subtitle: Text(t('«صليت 31 من 35…» مع شجرة الأسبوع (لمن يستخدم المتتبّع)', '"You prayed 31 of 35…" with your weekly tree (for tracker users)')),
                  value: _weekly,
                  onChanged: (v) => _setPref('weekly_summary', v),
                ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}

class _TypeTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final bool selected;
  final VoidCallback onSelect;
  final VoidCallback onPreview;
  final String previewTip;
  const _TypeTile({
    required this.icon,
    required this.name,
    required this.selected,
    required this.onSelect,
    required this.onPreview,
    required this.previewTip,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onSelect,
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsetsDirectional.only(start: 12, end: 4, top: 2, bottom: 2),
        decoration: BoxDecoration(
          color: selected ? cs.primary.withValues(alpha: 0.10) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? cs.primary : cs.outlineVariant),
        ),
        child: Row(children: [
          Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: selected ? cs.primary : cs.outline, size: 20),
          const SizedBox(width: 10),
          Icon(icon, size: 20, color: selected ? cs.primary : cs.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(child: Text(name, style: TextStyle(fontWeight: selected ? FontWeight.bold : FontWeight.w500))),
          IconButton(
            tooltip: previewTip,
            onPressed: onPreview,
            icon: const Icon(Icons.play_circle_outline_rounded),
          ),
        ]),
      ),
    );
  }
}

class _Warn extends StatelessWidget {
  final String text;
  final String action;
  final VoidCallback onTap;
  const _Warn({required this.text, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: cs.errorContainer, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Icon(Icons.warning_amber_rounded, color: cs.onErrorContainer),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: TextStyle(color: cs.onErrorContainer, fontSize: 13))),
        TextButton(onPressed: onTap, child: Text(action)),
      ]),
    );
  }
}
