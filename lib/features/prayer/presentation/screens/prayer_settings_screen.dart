import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/adhan_reciters.dart';
import '../../../../core/notifications/adhan_banner_controller.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/services/adhan_native_service.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/prayer_settings.dart';
import '../../domain/reminder_settings.dart';
import '../widgets/notification_option_widgets.dart';
import '../widgets/notification_permission_banner.dart';
import '../widgets/city_picker_sheet.dart';
import 'notification_type_screen.dart';
import 'prayer_mode_screen.dart';
import '../widgets/location_help_sheet.dart';
import '../../../../core/services/location_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../diagnostics/presentation/screens/adhan_diagnostics_screen.dart';
import 'adhan_reciter_screen.dart';

/// Aladhan calculation methods (proper names → shown as-is in every language).
const Map<int, String> kCalcMethods = {
  5: 'Egyptian General Authority of Survey',
  4: 'Umm Al-Qura University, Makkah',
  3: 'Muslim World League',
  1: 'University of Islamic Sciences, Karachi',
  2: 'ISNA (North America)',
  8: 'Gulf Region',
  9: 'Kuwait',
  10: 'Qatar',
  16: 'Dubai',
  11: 'Singapore (MUIS)',
  17: 'JAKIM (Malaysia)',
  20: 'KEMENAG (Indonesia)',
  13: 'Diyanet (Turkey)',
  23: 'Jordan',
  21: 'Morocco',
  19: 'Algeria',
  18: 'Tunisia',
  12: 'UOIF (France)',
  15: 'Moonsighting Committee',
  7: 'Tehran',
  0: 'Jafari (Shia Ithna-Ashari)',
};

class PrayerSettingsScreen extends StatefulWidget {
  const PrayerSettingsScreen({super.key});

  @override
  State<PrayerSettingsScreen> createState() => _PrayerSettingsScreenState();
}

class _PrayerSettingsScreenState extends State<PrayerSettingsScreen> {
  PrayerSettings _s = PrayerSettings.current;
  ReminderSettings _r = ReminderSettings.current;
  bool _fallbackLocation = false;
  String _locSource = '';
  String _locName = '';
  String _locDetail = '';
  String? _locIssue;
  bool _locBusy = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
      _apply();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final s = await PrayerSettings.load();
    final r = await ReminderSettings.load();
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _s = s;
      _r = r;
      _fallbackLocation = prefs.getBool('prayer_location_fallback') ?? false;
      _locSource = prefs.getString('prayer_location_source') ?? '';
      _locName = prefs.getString('cached_location_name') ?? '';
      final la = prefs.getDouble('last_latitude');
      final lo = prefs.getDouble('last_longitude');
      final ac = prefs.getDouble('last_location_accuracy');
      final tm = prefs.getInt('last_location_time');
      _locIssue = prefs.getString('location_last_issue');
      _locDetail = (la == null || lo == null)
          ? ''
          : '${la.toStringAsFixed(4)}, ${lo.toStringAsFixed(4)}'
              '${(ac != null && ac > 0) ? '  ±${ac.round()} m' : ''}'
              '${tm == null ? '' : '  · ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(tm)).inMinutes} min'}';
    });
  }

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';

  Future<void> _refreshLocation() async {
    setState(() => _locBusy = true);
    final svc = LocationService();
    await svc.clearManualCity();
    final r = await svc.refreshNow();
    await CityPickerSheet.applyEverywhere();
    await _load();
    if (!mounted) return;
    setState(() => _locBusy = false);
    final ar = Localizations.localeOf(context).languageCode == 'ar';
    if (r.source == LocationSource.gps || r.source == LocationSource.lastKnown) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(ar ? 'تم تحديث موقعك بدقة ✓' : 'Location updated precisely ✓')));
    } else {
      await LocationHelpSheet.show(context, issue: await svc.lastIssue());
    }
  }

  Future<void> _openMap() async {
    final p = await SharedPreferences.getInstance();
    final la = p.getDouble('last_latitude');
    final lo = p.getDouble('last_longitude');
    if (la == null || lo == null) return;
    await launchUrl(Uri.parse('geo:$la,$lo?q=$la,$lo'), mode: LaunchMode.externalApplication)
        .catchError((_) => launchUrl(Uri.parse('https://maps.google.com/?q=$la,$lo'), mode: LaunchMode.externalApplication));
  }

  Future<void> _pickCity() async {
    final changed = await CityPickerSheet.show(context);
    if (changed) await _load();
  }

  String _locationLabel(bool ar) {
    final how = switch (_locSource) {
      'manual' => ar ? 'مدينة مختارة يدويًا' : 'Chosen manually',
      'defaultCity' => ar ? 'موقع افتراضي (غير دقيق)' : 'Default location (not accurate)',
      'network' => ar ? 'تقريبي عبر الإنترنت — يُفضّل تحديد مدينتك' : 'Approximate (network) — please confirm your city',
      'cached' => ar ? 'آخر موقع محفوظ' : 'Last saved location',
      _ => ar ? 'تلقائي (GPS)' : 'Automatic (GPS)',
    };
    return _locName.isEmpty ? how : '$_locName · $how';
  }

  void _setP(PrayerSettings n) {
    setState(() => _s = n);
    _commit();
  }

  void _setR(ReminderSettings n) {
    setState(() => _r = n);
    _commit();
  }

  /// Saves immediately, re-schedules once the user stops tapping (coalesced).
  void _commit() {
    _s.save();
    _r.save();
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), _apply);
  }

  /// Re-schedules the alerts AND refreshes the times shown on Home (method / Asr school /
  /// offsets change what Home must display).
  Future<void> _apply() async {
    await NotificationCoordinator.instance.rescheduleAll(force: true);
    await HomeController.instance?.refreshData();
  }

  List<ChoiceOption<String>> _modes(AppLocalizations l, {bool adhan = true}) => [
        ChoiceOption('silent', Icons.notifications_off_rounded, l.modeSilent, l.modeSilentDesc),
        ChoiceOption('short', Icons.notifications_active_rounded, l.modeShort, l.modeShortDesc),
        if (adhan) ChoiceOption('adhan', Icons.mosque_rounded, l.modeAdhan, l.modeAdhanDesc),
      ];

  Widget _header(String t, Color c) => Padding(
        padding: const EdgeInsets.fromLTRB(4, 14, 4, 12),
        child: Text(t, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: c)),
      );

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final names = [l.fajr, l.dhuhr, l.asr, l.maghrib, l.isha];
    final icons = [
      Icons.wb_twilight_rounded,
      Icons.wb_sunny_rounded,
      Icons.sunny_snowing,
      Icons.nights_stay_rounded,
      Icons.bedtime_rounded,
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l.notifSettingsTitle,
            style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: cs.primary),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          const NotificationPermissionBanner(),
          // ---- Quick entries: alert type per prayer + "will the Adhan ring?" check
          SettingCard(
            icon: Icons.tune_rounded,
            title: Localizations.localeOf(context).languageCode == 'ar' ? 'نوع إشعار كل صلاة' : 'Alert type per prayer',
            subtitle: Localizations.localeOf(context).languageCode == 'ar'
                ? 'أذان كامل / تنبيه قصير / صامت — مع تجربة صوتية'
                : 'Full Adhan / short alert / silent — with live preview',
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'فتح' : 'Open'),
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationTypeScreen()));
                  if (mounted) await _load();
                },
              ),
            ),
          ),
          SettingCard(
            icon: Icons.do_not_disturb_on_rounded,
            title: Localizations.localeOf(context).languageCode == 'ar' ? 'وضع الصلاة والإقامة' : 'Prayer mode & Iqama',
            subtitle: Localizations.localeOf(context).languageCode == 'ar'
                ? 'كتم تلقائي بعد الأذان + تنبيه "بعد الأذان بـ X دقيقة"'
                : 'Auto-silence after the Adhan + "X minutes after the Adhan" alert',
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'فتح' : 'Open'),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrayerModeScreen())),
              ),
            ),
          ),
          SettingCard(
            icon: Icons.health_and_safety_rounded,
            title: Localizations.localeOf(context).languageCode == 'ar' ? 'هل الأذان هيشتغل؟' : 'Will the Adhan ring?',
            subtitle: Localizations.localeOf(context).languageCode == 'ar'
                ? 'فحص أخضر/أحمر لكل ما يمنع الأذان مع إصلاح بضغطة'
                : 'Green/red check of everything that can silence the Adhan, one-tap fixes',
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'فحص الآن' : 'Check now'),
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const AdhanDiagnosticsScreen())),
              ),
            ),
          ),
          // ---- "Will the Adhan work?" checkup
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: cs.primaryContainer.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              leading: Icon(Icons.health_and_safety_rounded, color: cs.primary),
              title: Text(_ar ? 'هل الأذان هيشتغل؟' : 'Will the Adhan work?',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_ar
                  ? 'افحص الأذونات والبطارية والموقع وآخر جدولة'
                  : 'Check permissions, battery, location and the last schedule'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const AdhanDiagnosticsScreen())),
            ),
          ),
          if (_fallbackLocation)
            Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: cs.errorContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.location_off_rounded, color: cs.onErrorContainer),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(l.locationFallbackWarning,
                          style: TextStyle(color: cs.onErrorContainer, fontSize: 13))),
                ]),
                const SizedBox(height: 8),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: FilledButton.tonal(
                    onPressed: _pickCity,
                    child: Text(Localizations.localeOf(context).languageCode == 'ar'
                        ? 'اختر مدينتك'
                        : 'Choose your city'),
                  ),
                ),
              ]),
            ),
          // ---- Location used for prayer times (auto / manual) with verification tools
          SettingCard(
            icon: Icons.location_on_rounded,
            title: Localizations.localeOf(context).languageCode == 'ar' ? 'موقع مواعيد الصلاة' : 'Prayer-times location',
            subtitle: _locationLabel(Localizations.localeOf(context).languageCode == 'ar'),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (_locDetail.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(_locDetail,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                ),
              Wrap(spacing: 8, runSpacing: 4, children: [
                FilledButton.tonalIcon(
                  icon: _locBusy
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.my_location_rounded),
                  label: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'تحديث موقعي الآن' : 'Update my location'),
                  onPressed: _locBusy ? null : _refreshLocation,
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.map_rounded),
                  label: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'عرض على الخريطة' : 'Show on map'),
                  onPressed: _openMap,
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.edit_location_alt_rounded),
                  label: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'تغيير المدينة' : 'Change city'),
                  onPressed: _pickCity,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.help_outline_rounded),
                  label: Text(Localizations.localeOf(context).languageCode == 'ar' ? 'الموقع غلط؟' : 'Wrong location?'),
                  onPressed: () => LocationHelpSheet.show(context, issue: _locIssue),
                ),
              ]),
            ]),
          ),

          // ---- Muadhin + in-app banner
          SettingCard(
            icon: Icons.record_voice_over_rounded,
            title: l.muadhinTitle,
            subtitle: AdhanReciters.byId(_s.adhanReciter)
                .name(Localizations.localeOf(context).languageCode == 'ar'),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton.icon(
                icon: const Icon(Icons.library_music_rounded),
                label: Text(l.muadhinTitle),
                onPressed: () async {
                  await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const AdhanReciterScreen()));
                  _load();
                },
              ),
            ),
          ),
          SettingCard(
            icon: Icons.notifications_active_rounded,
            title: l.adhanBannerTitle,
            subtitle: l.adhanBannerDesc,
            enabled: _s.adhanBanner,
            onToggle: (v) => _setP(_s.copyWith(adhanBanner: v)),
          ),

          // ---- Prayers: switch + 3 option cards each
          _header(l.enablePrayerAlertsTitle, cs.primary),
          for (var i = 0; i < 5; i++)
            SettingCard(
              icon: icons[i],
              title: names[i],
              enabled: _s.enabled[i],
              onToggle: (v) => _setP(_s.withEnabled(i, v)),
              child: ChoiceCards<String>(
                value: _s.sounds[i],
                options: _modes(l),
                onChanged: (v) => _setP(_s.withSound(i, v)),
              ),
            ),

          // ---- Optional alert before prayer
          SettingCard(
            icon: Icons.access_time_filled_rounded,
            title: l.prePrayerAlertTitle,
            subtitle: l.prePrayerAlertDesc,
            enabled: _s.preEnabled,
            onToggle: (v) => _setP(_s.copyWith(preEnabled: v)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PillRow<int>(
                value: _s.beforePrayerMinutes,
                values: const [5, 10, 15, 20, 30, 45, 60],
                label: (m) => l.minutesShort(m),
                onChanged: (m) => _setP(_s.copyWith(beforePrayerMinutes: m)),
              ),
              const SizedBox(height: 12),
              ChoiceCards<String>(
                value: _s.preSound,
                options: _modes(l, adhan: false),
                onChanged: (v) => _setP(_s.copyWith(preSound: v)),
              ),
            ]),
          ),

          // ---- Daily reminders
          _header(l.remindersSection, cs.primary),
          SettingCard(
            icon: Icons.wb_sunny_outlined,
            title: l.morningAzkar,
            subtitle: l.afterFajrDesc(_r.morningAfterFajrMin),
            enabled: _r.morningEnabled,
            onToggle: (v) => _setR(_r.copyWith(morningEnabled: v)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PillRow<int>(
                value: _r.morningAfterFajrMin,
                values: const [30, 60, 90, 120, 150, 180],
                label: (m) => l.minutesShort(m),
                onChanged: (m) => _setR(_r.copyWith(morningAfterFajrMin: m)),
              ),
              const SizedBox(height: 12),
              ChoiceCards<String>(
                value: _r.morningSound,
                options: _modes(l, adhan: false),
                onChanged: (v) => _setR(_r.copyWith(morningSound: v)),
              ),
            ]),
          ),
          SettingCard(
            icon: Icons.nights_stay_outlined,
            title: l.eveningAzkar,
            subtitle: l.afterAsrDesc(_r.eveningAfterAsrMin),
            enabled: _r.eveningEnabled,
            onToggle: (v) => _setR(_r.copyWith(eveningEnabled: v)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PillRow<int>(
                value: _r.eveningAfterAsrMin,
                values: const [0, 15, 30, 45, 60],
                label: (m) => l.minutesShort(m),
                onChanged: (m) => _setR(_r.copyWith(eveningAfterAsrMin: m)),
              ),
              const SizedBox(height: 12),
              ChoiceCards<String>(
                value: _r.eveningSound,
                options: _modes(l, adhan: false),
                onChanged: (v) => _setR(_r.copyWith(eveningSound: v)),
              ),
            ]),
          ),
          SettingCard(
            icon: Icons.menu_book_rounded,
            title: l.ayahReminderTitle,
            subtitle: l.ayahReminderDesc,
            enabled: _r.ayahEnabled,
            onToggle: (v) => _setR(_r.copyWith(ayahEnabled: v)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.schedule_rounded),
                label: Text(
                    '${l.reminderTime}: ${TimeOfDay(hour: _r.ayahHour, minute: _r.ayahMinute).format(context)}'),
                onPressed: () async {
                  final t = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: _r.ayahHour, minute: _r.ayahMinute),
                  );
                  if (t != null) _setR(_r.copyWith(ayahHour: t.hour, ayahMinute: t.minute));
                },
              ),
              const SizedBox(height: 12),
              ChoiceCards<String>(
                value: _r.ayahSound,
                options: _modes(l, adhan: false),
                onChanged: (v) => _setR(_r.copyWith(ayahSound: v)),
              ),
            ]),
          ),

          // ---- Friday: Salawat + Al-Kahf (own chime + gold accent)
          SettingCard(
            icon: Icons.star_rounded,
            title: _ar ? 'تذكيرات يوم الجمعة' : 'Friday reminders',
            subtitle: _ar
                ? '٥ تنبيهات: الصلاة على النبي ﷺ وسورة الكهف (من ليلة الجمعة حتى العصر)'
                : '5 alerts: blessings upon the Prophet ﷺ and Surat Al-Kahf (Thursday night → Asr)',
            enabled: _r.fridayEnabled,
            onToggle: (v) => _setR(_r.copyWith(fridayEnabled: v)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                _ar
                    ? 'الخميس بعد العشاء · قبل الفجر · الشروق · بعد الظهر · بعد العصر'
                    : 'Thu after Isha · before Fajr · sunrise · after Dhuhr · after Asr',
                style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              ChoiceCards<String>(
                value: _r.fridaySound,
                options: _modes(l, adhan: false),
                onChanged: (v) => _setR(_r.copyWith(fridaySound: v)),
              ),
            ]),
          ),

          // ---- Accuracy
          _header(l.advancedSection, cs.primary),
          SettingCard(
            icon: Icons.calculate_rounded,
            title: l.calcMethodTitle,
            subtitle: _s.calcMethod < 0 ? l.calcMethodAuto : kCalcMethods[_s.calcMethod],
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.list_rounded),
                label: Text(l.calcMethodTitle),
                onPressed: () => _pickMethod(l),
              ),
              const SizedBox(height: 14),
              Text(l.asrSchoolTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              ChoiceCards<int>(
                value: _s.asrSchool,
                options: [
                  ChoiceOption(0, Icons.access_time_rounded, l.asrStandard),
                  ChoiceOption(1, Icons.access_time_filled_rounded, l.asrHanafi),
                ],
                onChanged: (v) => _setP(_s.copyWith(asrSchool: v)),
              ),
              const SizedBox(height: 14),
              Text(l.adjustTimesTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 6),
              for (var i = 0; i < 5; i++)
                Row(children: [
                  Expanded(child: Text(names[i])),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline_rounded),
                    onPressed: () => _setP(_s.withOffset(i, _s.offsets[i] - 1)),
                  ),
                  SizedBox(
                    width: 44,
                    child: Text(
                      _s.offsets[i] > 0 ? '+${_s.offsets[i]}' : '${_s.offsets[i]}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline_rounded),
                    onPressed: () => _setP(_s.withOffset(i, _s.offsets[i] + 1)),
                  ),
                ]),
            ]),
          ),
          const SizedBox(height: 4),
          FilledButton.icon(
            icon: const Icon(Icons.play_circle_rounded),
            label: Text(l.testAdhanButton),
            onPressed: () => _testAdhan(l),
          ),
        ],
      ),
    );
  }

  Future<void> _pickMethod(AppLocalizations l) async {
    final cs = Theme.of(context).colorScheme;
    final picked = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        builder: (_, sc) => ListView(
          controller: sc,
          children: [
            ListTile(
              title: Text(l.calcMethodAuto),
              trailing: _s.calcMethod < 0 ? Icon(Icons.check_circle, color: cs.primary) : null,
              onTap: () => Navigator.pop(ctx, -1),
            ),
            for (final e in kCalcMethods.entries)
              ListTile(
                title: Text(e.value),
                trailing:
                    _s.calcMethod == e.key ? Icon(Icons.check_circle, color: cs.primary) : null,
                onTap: () => Navigator.pop(ctx, e.key),
              ),
          ],
        ),
      ),
    );
    if (picked != null) _setP(_s.copyWith(calcMethod: picked));
  }

  Future<void> _testAdhan(AppLocalizations l) async {
    final r = AdhanReciters.byId(_s.adhanReciter);
    final title = l.prayerNotifTitle(l.dhuhr);
    await AdhanNativeService.instance.startAdhan(
      id: 9,
      title: title,
      body: l.prayerNotifBody,
      rawSound: r.rawName,
      stopLabel: l.adhanStopAction,
    );
    if (_s.adhanBanner) {
      AdhanBannerController.instance.show(AdhanBannerData(
        notificationId: 9,
        title: title,
        subtitle: l.prayerNotifBody,
        verse: l.adhanBannerVerse,
        stopLabel: l.adhanStopAction,
        shownAt: DateTime.now(),
      ));
    }
  }
}
