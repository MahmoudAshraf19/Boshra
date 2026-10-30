import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/prayer/domain/prayer_scheduler_service.dart';
import '../../l10n/app_localizations.dart';
import '../services/notification_service.dart';
import '../utils/app_logger.dart';
import 'notification_plan_builders.dart';

/// Single place that keeps the OS notifications in sync with the app state.
///
/// Triggers: app start, app resume, language change, prayer-settings change,
/// time-zone change, location change. It is IDEMPOTENT and cheap: only differences
/// are applied (see NotificationService.applyPlan), and calls that arrive while a
/// run is in progress are COALESCED, not dropped (the old code dropped them, so a
/// settings/language change made during a run was silently never applied).
class NotificationCoordinator {
  NotificationCoordinator._();
  static final NotificationCoordinator instance = NotificationCoordinator._();
  static const _tag = 'NotifCoordinator';

  DateTime? _lastRun;
  bool _running = false;
  bool _rerun = false;

  static Future<AppLocalizations> currentL10n() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language_code') ?? 'ar';
    try {
      return lookupAppLocalizations(Locale(code));
    } catch (_) {
      return lookupAppLocalizations(const Locale('ar'));
    }
  }

  /// [force] bypasses the 5-minute throttle (use after the user changed something).
  Future<void> rescheduleAll({bool force = false}) async {
    if (_running) {
      _rerun = true; // coalesce: run once more right after the current run
      return;
    }
    final recent = _lastRun != null &&
        DateTime.now().difference(_lastRun!) < const Duration(minutes: 5);
    if (!force && recent) return;

    _running = true;
    try {
      do {
        _rerun = false;
        await _runOnce();
      } while (_rerun);
    } finally {
      _running = false;
    }
  }

  /// Entry point for the WorkManager background task. Returns false → WorkManager retries.
  Future<bool> runInBackground() async {
    if (_running) return true;
    _running = true;
    try {
      return await _runOnce(background: true);
    } finally {
      _running = false;
    }
  }

  Future<bool> _runOnce({bool background = false}) async {
    try {
      final ns = NotificationService();
      await ns.timeZoneChanged(); // refreshes tz.local if the user travelled
      final l10n = await currentL10n();

      final prayer = await PrayerSchedulerService().buildPlan(l10n, background: background);
      final plans = <NotificationPlan>[
        ...NotificationPlanBuilders.azkar(l10n),
        ...await NotificationPlanBuilders.quran(l10n),
        ...prayer.plans,
      ];
      await ns.applyPlan(plans, cancelStalePrayers: prayer.complete);
      _lastRun = DateTime.now();
      return true;
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'run failed');
      return false;
    }
  }
}

/// Re-checks when the app returns to foreground (keeps the rolling window fresh).
class NotificationLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      NotificationCoordinator.instance.rescheduleAll();
    }
  }
}
