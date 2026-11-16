import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/prayer/domain/prayer_scheduler_service.dart';
import '../../features/prayer/domain/reminder_settings.dart';
import '../../l10n/app_localizations.dart';
import '../services/notification_service.dart';
import '../utils/app_logger.dart';
import '../services/telemetry.dart';
import '../../features/prayer/data/repositories/prayer_repository.dart';
import 'adhan_banner_controller.dart';
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
      final reminders = await ReminderSettings.load(fresh: true);
      final plans = <NotificationPlan>[
        ...await NotificationPlanBuilders.ayah(l10n, reminders),
        ...prayer.plans, // prayers + pre-prayer + Azkar
      ];
      await ns.applyPlan(
        plans,
        cancelStalePrayers: prayer.complete,
        enabledSlots: prayer.enabledSlots,
        adhanSlots: prayer.adhanSlots,
        preEnabled: prayer.preEnabled,
      );
      // In-app banner (only does something while the app UI is open).
      AdhanBannerController.instance.schedule(plans);
      _lastRun = DateTime.now();
      // For the Diagnostics screen: when/what was last scheduled.
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('diag_last_schedule_ms', _lastRun!.millisecondsSinceEpoch);
        await prefs.setInt('diag_last_plan_count', plans.length);
        await prefs.setBool('diag_last_complete', prayer.complete);
        await prefs.setBool('diag_last_background', background);
        await prefs.setBool('diag_last_error', false);
      } catch (_) {}
      Telemetry.log(prayer.complete ? 'schedule_ok' : 'schedule_incomplete',
          {'plans': plans.length, 'bg': background});
      // Keep the next months cached so the app also works fully offline (never blocks).
      unawaited(PrayerRepository().prefetchMonths());
      // Incomplete plan in the background → ask WorkManager to retry with back-off.
      return prayer.complete || !background;
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'run failed');
      Telemetry.log('schedule_failed', {'err': e.runtimeType.toString(), 'bg': background});
      try {
        (await SharedPreferences.getInstance()).setBool('diag_last_error', true);
      } catch (_) {}
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
