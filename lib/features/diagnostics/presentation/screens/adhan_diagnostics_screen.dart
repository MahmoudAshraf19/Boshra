import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/permissions/permission_center.dart';
import '../../../../core/services/adhan_native_service.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/telemetry.dart';
import '../../../../core/constants/adhan_reciters.dart';
import '../../../prayer/data/repositories/prayer_repository.dart';
import '../../../prayer/domain/prayer_settings.dart';
import '../../../prayer/domain/prayer_mode_settings.dart';
import '../../../prayer/presentation/widgets/city_picker_sheet.dart';
import '../../../prayer/presentation/widgets/location_help_sheet.dart';

enum _Level { ok, warn, bad }

class _Row {
  final _Level level;
  final String title;
  final String detail;
  final String? fixLabel;
  final Future<void> Function()? fix;
  const _Row(this.level, this.title, this.detail, {this.fixLabel, this.fix});
}

/// "Will the Adhan ring?" — checks everything that can silence it, in green / amber / red,
/// each problem with a one-tap fix, plus a copyable support report.
class AdhanDiagnosticsScreen extends StatefulWidget {
  const AdhanDiagnosticsScreen({super.key});

  @override
  State<AdhanDiagnosticsScreen> createState() => _AdhanDiagnosticsScreenState();
}

class _AdhanDiagnosticsScreenState extends State<AdhanDiagnosticsScreen> with WidgetsBindingObserver {
  List<_Row> _rows = const [];
  List<String> _events = const [];
  bool _loading = true;
  bool _busy = false;
  String _brand = '';

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Telemetry.log('diagnostics_open');
    WidgetsBinding.instance.addPostFrameCallback((_) => _run());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _run(); // back from Android settings
  }

  String _ago(DateTime d) {
    final m = DateTime.now().difference(d).inMinutes;
    if (m < 1) return t('الآن', 'just now');
    if (m < 60) return t('من $m دقيقة', '$m min ago');
    if (m < 60 * 48) return t('من ${m ~/ 60} ساعة', '${m ~/ 60} h ago');
    return t('من ${m ~/ 1440} يوم', '${m ~/ 1440} d ago');
  }

  String _hhmm(DateTime d) =>
      '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

  Future<void> _run() async {
    if (!mounted) return;
    setState(() => _loading = true);
    final rows = <_Row>[];
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final st = await PermissionCenter.check(force: true);
    _brand = st.brand;
    final ps = await PrayerSettings.load(fresh: true);

    // 1) notifications
    rows.add(st.notifications
        ? _Row(_Level.ok, t('الإشعارات', 'Notifications'), t('مفعّلة', 'Enabled'))
        : _Row(_Level.bad, t('الإشعارات', 'Notifications'),
            t('مقفولة — الأذان مش هيظهر', 'Blocked — the Adhan cannot show'),
            fixLabel: t('تفعيل', 'Enable'), fix: PermissionCenter.requestNotifications));

    // 2) channels
    if (st.notifications) {
      rows.add(st.channelsOk
          ? _Row(_Level.ok, t('قنوات الإشعار', 'Notification channels'), t('كلها شغالة', 'All enabled'))
          : _Row(_Level.bad, t('قنوات الإشعار', 'Notification channels'),
              t('في قناة مكتومة من إعدادات الموبايل', 'A channel is muted in system settings'),
              fixLabel: t('فتح الإعدادات', 'Open settings'), fix: PermissionCenter.openNotificationSettings));
    }

    // 3) exact alarms
    rows.add(st.exactAlarm
        ? _Row(_Level.ok, t('المنبّهات الدقيقة', 'Exact alarms'), t('مسموحة — الأذان في الثانية المضبوطة', 'Allowed — Adhan fires on the second'))
        : _Row(_Level.bad, t('المنبّهات الدقيقة', 'Exact alarms'),
            t('غير مسموحة — الأذان ممكن يتأخر', 'Not allowed — the Adhan may be late'),
            fixLabel: t('السماح', 'Allow'), fix: PermissionCenter.requestExactAlarm));

    // 4) battery
    rows.add(st.battery
        ? _Row(_Level.ok, t('تحسين البطارية', 'Battery optimisation'), t('التطبيق مستثنى', 'App is exempt'))
        : _Row(_Level.warn, t('تحسين البطارية', 'Battery optimisation'),
            t('النظام ممكن يوقف التطبيق في الخلفية', 'The system may stop the app in background'),
            fixLabel: t('استثناء', 'Exempt'), fix: PermissionCenter.requestBatteryExemption));

    // 4b) prayer mode needs "Do Not Disturb access" for full silence
    final pmOn = (await PrayerModeSettings.load(fresh: true)).enabled;
    if (pmOn) {
      var dndOk = false;
      try {
        dndOk = await Permission.accessNotificationPolicy.isGranted;
      } catch (_) {}
      rows.add(dndOk
          ? _Row(_Level.ok, t('وضع الصلاة', 'Prayer mode'), t('الكتم الكامل جاهز (عدم الإزعاج مسموح)', 'Full silence ready (DND access granted)'))
          : _Row(_Level.warn, t('وضع الصلاة', 'Prayer mode'),
              t('بدون صلاحية «عدم الإزعاج» هنكتفي بوضع الاهتزاز', 'Without "Do Not Disturb access" we can only switch to vibrate'),
              fixLabel: t('منح الصلاحية', 'Grant access'),
              fix: () async {
                try {
                  await const AndroidIntent(action: 'android.settings.NOTIFICATION_POLICY_ACCESS_SETTINGS').launch();
                } catch (_) {
                  await openAppSettings();
                }
              }));
    }

    // 5) autostart (only brands that have it)
    if (st.autostartApplicable) {
      rows.add(!st.needsAutostart
          ? _Row(_Level.ok, t('التشغيل التلقائي', 'Auto-start'), t('تم ضبطه (${st.brand})', 'Configured (${st.brand})'))
          : _Row(_Level.warn, t('التشغيل التلقائي', 'Auto-start'),
              t('جهاز ${st.brand} بيقفل التطبيقات — فعّل التشغيل التلقائي', '${st.brand} kills background apps — enable auto-start'),
              fixLabel: t('فتح', 'Open'),
              fix: () async {
                await PermissionCenter.openAutostart();
                await PermissionCenter.markAutostartDone();
              }));
    }

    // 6) location
    final src = prefs.getString('prayer_location_source') ?? prefs.getString('location_source') ?? '';
    final issue = await LocationService().lastIssue();
    final locAt = prefs.getInt('last_location_time');
    final acc = prefs.getDouble('last_location_accuracy');
    final locName = prefs.getString('cached_location_name') ?? '';
    String issueText(String? i) {
      switch (i) {
        case 'service_off':
          return t('خدمة الموقع (GPS) مقفولة', 'Location service (GPS) is off');
        case 'permission_denied':
          return t('إذن الموقع مرفوض', 'Location permission denied');
        case 'permission_forever':
          return t('إذن الموقع مرفوض نهائيًا — افتحه من الإعدادات', 'Permission permanently denied — open settings');
        case 'no_fix':
          return t('الجهاز ما قدرش يحدد موقعك (إشارة ضعيفة / "دقة الموقع" مقفولة)', 'Device could not get a fix (weak signal / "Location accuracy" off)');
        case 'mock_location':
        case 'mock_location_ignored':
          return t('في موقع وهمي (Mock) مفعّل على الجهاز — بنتجاهله', 'A mock location is active on the device — ignored');
        case 'tz_mismatch':
          return t('الموقع متعارض مع المنطقة الزمنية للجهاز (موقع وهمي؟)', 'Fix contradicts the device time zone (mock location?)');
        default:
          return '';
      }
    }

    if (src == 'manual') {
      rows.add(_Row(_Level.ok, t('الموقع', 'Location'), t('مدينة مختارة يدويًا: $locName', 'Manual city: $locName')));
    } else if (src == 'gps' || src == 'lastKnown' || (src == 'cached' && issue == null)) {
      final age = locAt == null ? '' : ' · ${_ago(DateTime.fromMillisecondsSinceEpoch(locAt))}';
      final accTxt = (acc != null && acc > 0) ? ' · ±${acc.round()}${t(' م', ' m')}' : '';
      rows.add(_Row(_Level.ok, t('الموقع', 'Location'), '$locName$age$accTxt'));
    } else if (src == 'network' || src == 'cached') {
      rows.add(_Row(_Level.warn, t('الموقع', 'Location'),
          '${t('تقريبي', 'Approximate')}${locName.isEmpty ? '' : ': $locName'}${issueText(issue).isEmpty ? '' : '\n${issueText(issue)}'}',
          fixLabel: t('تحديد دقيق', 'Fix location'), fix: () => _fixLocation(issue)));
    } else {
      rows.add(_Row(_Level.bad, t('الموقع', 'Location'),
          '${t('مش متحدد — بنستخدم مدينة افتراضية', 'Unknown — using a default city')}${issueText(issue).isEmpty ? '' : '\n${issueText(issue)}'}',
          fixLabel: t('تحديد', 'Set'), fix: () => _fixLocation(issue)));
    }

    // 7) last scheduling
    final lastMs = prefs.getInt('diag_last_schedule_ms');
    final cnt = prefs.getInt('diag_last_plan_count') ?? 0;
    final complete = prefs.getBool('diag_last_complete') ?? false;
    final err = prefs.getBool('diag_last_error') ?? false;
    if (lastMs == null) {
      rows.add(_Row(_Level.bad, t('آخر جدولة', 'Last scheduling'), t('لسه ما اتجدولش', 'Never scheduled yet'),
          fixLabel: t('جدولة الآن', 'Schedule now'), fix: _reschedule));
    } else {
      final d = DateTime.fromMillisecondsSinceEpoch(lastMs);
      final stale = DateTime.now().difference(d) > const Duration(hours: 36);
      final lvl = err ? _Level.bad : (stale || !complete || cnt == 0 ? _Level.warn : _Level.ok);
      rows.add(_Row(lvl, t('آخر جدولة', 'Last scheduling'),
          '${_ago(d)} · ${t('$cnt تنبيه', '$cnt alerts')}${complete ? '' : t(' · ناقصة (اتحسب أوفلاين)', ' · incomplete (offline calc)')}${err ? t(' · حصل خطأ', ' · error') : ''}',
          fixLabel: lvl == _Level.ok ? null : t('جدولة الآن', 'Schedule now'), fix: lvl == _Level.ok ? null : _reschedule));
    }

    // 8) what is REALLY armed in Android's AlarmManager
    final armed = prefs.getInt('native_armed_adhan') ?? 0;
    final nextMs = prefs.getInt('native_next_adhan_ms') ?? 0;
    final nextTitle = prefs.getString('native_next_adhan_title') ?? '';
    final wantsAdhan = ps.adhanSlots.isNotEmpty;
    if (!wantsAdhan) {
      rows.add(_Row(_Level.warn, t('الأذان القادم', 'Next Adhan'),
          t('كل الصلوات مضبوطة على إشعار قصير/صامت (مش أذان كامل)', 'All prayers are set to short/silent (no full Adhan)')));
    } else if (armed > 0 && nextMs > 0) {
      final d = DateTime.fromMillisecondsSinceEpoch(nextMs);
      rows.add(_Row(_Level.ok, t('الأذان القادم', 'Next Adhan'),
          '${nextTitle.isEmpty ? '' : '$nextTitle · '}${_hhmm(d)} · ${t('$armed أذان مجدول في النظام', '$armed Adhans armed in the system')}'));
    } else {
      rows.add(_Row(_Level.bad, t('الأذان القادم', 'Next Adhan'),
          t('مفيش أذان مجدول في المنبّه! اضغط جدولة', 'No Adhan is armed in the alarm system! Tap schedule'),
          fixLabel: t('جدولة الآن', 'Schedule now'), fix: _reschedule));
    }

    // 9) offline readiness
    final months = await PrayerRepository().cachedMonthsCount();
    rows.add(months >= 2
        ? _Row(_Level.ok, t('الوضع الأوفلاين', 'Offline mode'), t('$months أشهر محفوظة — يشتغل بدون إنترنت', '$months months cached — works without internet'))
        : _Row(_Level.warn, t('الوضع الأوفلاين', 'Offline mode'),
            t('محفوظ $months شهر فقط (هيتكمّل تلقائيًا مع الإنترنت، وفي حساب احتياطي)', 'Only $months month cached (auto-completes online; offline calc is the backup)')));

    // 10) internet reachability (informational)
    bool online = false;
    try {
      final r = await Dio(BaseOptions(connectTimeout: const Duration(seconds: 4), receiveTimeout: const Duration(seconds: 4)))
          .get('https://api.aladhan.com/v1/currentTimestamp');
      online = r.statusCode == 200;
    } catch (_) {}
    rows.add(online
        ? _Row(_Level.ok, t('الإنترنت', 'Internet'), t('متصل بخادم المواعيد', 'Reaching the prayer-times server'))
        : _Row(_Level.warn, t('الإنترنت', 'Internet'), t('غير متاح الآن — مش مشكلة، المواعيد المحفوظة تكفي', 'Unavailable now — fine, cached times are enough')));

    // event log: native (alarm fired / service) + app events
    final ev = <(DateTime, String)>[];
    for (final l in (prefs.getString('native_events') ?? '').split('\n')) {
      final p = l.split('|');
      if (p.length >= 2) {
        final ms = int.tryParse(p[0]);
        if (ms != null) ev.add((DateTime.fromMillisecondsSinceEpoch(ms), '${p[1]}${p.length > 2 && p[2].isNotEmpty ? ' ${p[2]}' : ''}'));
      }
    }
    for (final e in await Telemetry.recent(limit: 25)) {
      ev.add((e.at, e.toString().split('  ').skip(1).join(' ')));
    }
    ev.sort((a, b) => b.$1.compareTo(a.$1));
    _events = [for (final e in ev.take(14)) '${_hhmm(e.$1)}  ${e.$2}'];

    if (!mounted) return;
    setState(() {
      _rows = rows;
      _loading = false;
    });
  }

  Future<void> _fixLocation(String? issue) async {
    if (issue == 'service_off' || issue == 'permission_denied' || issue == 'permission_forever') {
      await PermissionCenter.requestLocation();
    } else {
      final retry = await LocationHelpSheet.show(context, issue: issue);
      if (retry) await LocationService().refreshNow();
    }
    if (mounted) await _afterFix();
  }

  Future<void> _reschedule() async {
    PrayerRepository.invalidateLocation();
    await NotificationCoordinator.instance.rescheduleAll(force: true);
  }

  Future<void> _afterFix() async {
    PermissionCenter.invalidate();
    await CityPickerSheet.applyEverywhere();
    await _run();
  }

  Future<void> _testAdhan() async {
    setState(() => _busy = true);
    final ps = await PrayerSettings.load();
    final r = AdhanReciters.byId(ps.adhanReciter);
    final ok = await AdhanNativeService.instance.startAdhan(
      id: 9,
      title: t('تجربة الأذان', 'Adhan test'),
      body: t('لو سمعت الأذان يبقى كل حاجة تمام', 'If you hear this, everything works'),
      rawSound: r.rawName,
      stopLabel: t('إيقاف', 'Stop'),
    );
    Telemetry.log('diag_test_adhan', {'ok': ok});
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _busy = false);
  }

  String _report() {
    final b = StringBuffer('Boshra diagnostics · ${DateTime.now().toIso8601String()} · brand=$_brand\n');
    for (final r in _rows) {
      b.writeln('[${r.level.name.toUpperCase()}] ${r.title}: ${r.detail.replaceAll('\n', ' ')}');
    }
    b.writeln('--- events');
    for (final e in _events) {
      b.writeln(e);
    }
    return b.toString();
  }

  Color _color(BuildContext c, _Level l) => switch (l) {
        _Level.ok => Colors.green.shade600,
        _Level.warn => Colors.orange.shade700,
        _Level.bad => Theme.of(c).colorScheme.error,
      };

  IconData _icon(_Level l) => switch (l) {
        _Level.ok => Icons.check_circle_rounded,
        _Level.warn => Icons.warning_amber_rounded,
        _Level.bad => Icons.cancel_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bad = _rows.where((r) => r.level == _Level.bad).length;
    final warn = _rows.where((r) => r.level == _Level.warn).length;
    final overall = bad > 0 ? _Level.bad : (warn > 0 ? _Level.warn : _Level.ok);
    final oc = _color(context, overall);

    return Scaffold(
      appBar: AppBar(
        title: Text(t('هل الأذان هيشتغل؟', 'Will the Adhan ring?')),
        actions: [
          IconButton(onPressed: _loading ? null : _run, icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: oc.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: oc.withValues(alpha: 0.5)),
                  ),
                  child: Row(children: [
                    Icon(_icon(overall), color: oc, size: 38),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        overall == _Level.ok
                            ? t('كل شيء سليم — الأذان هيشتغل في وقته إن شاء الله', 'All good — the Adhan will ring on time')
                            : overall == _Level.warn
                                ? t('الأذان غالبًا هيشتغل، لكن في $warn نقطة تحسين', 'The Adhan should ring, but $warn item(s) can be improved')
                                : t('في $bad مشكلة ممكن تمنع الأذان — صلّحها بالأزرار تحت', '$bad problem(s) may stop the Adhan — fix with the buttons below'),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: oc, height: 1.4),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 14),
                for (final r in _rows)
                  Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    elevation: 0,
                    color: cs.surfaceContainerLow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: _color(context, r.level).withValues(alpha: 0.35))),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Icon(_icon(r.level), color: _color(context, r.level)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(r.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            const SizedBox(height: 3),
                            Text(r.detail, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13, height: 1.4)),
                            if (r.fix != null) ...[
                              const SizedBox(height: 8),
                              FilledButton.tonal(
                                onPressed: () async {
                                  await r.fix!();
                                  PermissionCenter.invalidate();
                                  if (mounted) await _run();
                                },
                                child: Text(r.fixLabel ?? t('إصلاح', 'Fix')),
                              ),
                            ],
                          ]),
                        ),
                      ]),
                    ),
                  ),
                const SizedBox(height: 6),
                Row(children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _busy ? null : _testAdhan,
                      icon: const Icon(Icons.volume_up_rounded),
                      label: Text(t('تجربة الأذان الآن', 'Test Adhan now')),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await _reschedule();
                        await _run();
                      },
                      icon: const Icon(Icons.sync_rounded),
                      label: Text(t('إعادة الجدولة', 'Re-schedule')),
                    ),
                  ),
                ]),
                const SizedBox(height: 18),
                Text(t('آخر الأحداث', 'Recent events'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 6),
                if (_events.isEmpty)
                  Text(t('لا توجد أحداث بعد', 'No events yet'), style: TextStyle(color: cs.onSurfaceVariant))
                else
                  for (final e in _events)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(e, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontFamily: 'monospace')),
                    ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: _report()));
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(t('تم نسخ تقرير الدعم — الصقه في واتساب', 'Support report copied'))));
                  },
                  icon: const Icon(Icons.copy_rounded),
                  label: Text(t('نسخ تقرير للدعم الفني', 'Copy report for support')),
                ),
                const SizedBox(height: 24),
              ],
            ),
    );
  }
}
