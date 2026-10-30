import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../core/notifications/notification_ids.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/utils/app_logger.dart';
import '../../../l10n/app_localizations.dart';
import '../data/models/prayer_times_model.dart';
import '../data/repositories/prayer_repository.dart';
import 'prayer_settings.dart';

class PrayerPlanResult {
  final List<NotificationPlan> plans;
  /// false when some day could not be loaded (offline, no cache) — the caller must
  /// then NOT delete previously scheduled prayers.
  final bool complete;
  const PrayerPlanResult(this.plans, this.complete);
}

/// Builds (does not schedule) the prayer notification plan.
/// Texts come from the app's ARB files in the USER'S APP LANGUAGE.
class PrayerSchedulerService {
  static const _tag = 'PrayerPlan';
  final PrayerRepository _repo = PrayerRepository();

  /// Android allows ~500 alarms/app (we use ≤ ~320). iOS keeps only 64 → 4 days.
  int get _days => kIsWeb ? 0 : (defaultTargetPlatform == TargetPlatform.iOS ? 4 : 30);

  Future<PrayerPlanResult> buildPlan(AppLocalizations l10n, {bool background = false}) async {
    final out = <NotificationPlan>[];
    if (_days == 0) return const PrayerPlanResult([], false);
    bool complete = true;
    try {
      final settings = await PrayerSettings.load();
      final today = DateTime.now();
      for (int i = 0; i < _days; i++) {
        final date = DateTime(today.year, today.month, today.day + i);
        PrayerTimesModel? model;
        try {
          model = await _repo.getPrayerTimesForDate(date, savedLocationOnly: background);
        } catch (e, s) {
          AppLogger.e(_tag, e, s, 'day $date');
        }
        if (model == null) {
          complete = false;
          continue;
        }
        out.addAll(_planDay(date, model, settings, l10n));
      }
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'buildPlan');
      complete = false;
    }
    AppLogger.d(_tag, 'planned ${out.length} (complete=$complete)');
    return PrayerPlanResult(out, complete);
  }

  List<NotificationPlan> _planDay(DateTime date, PrayerTimesModel model,
      PrayerSettings st, AppLocalizations l10n) {
    final t = model.timings;
    final entries = <_Prayer>[
      _Prayer(0, l10n.fajr, t.fajr, st.enabledFajr, st.fajrSound),
      _Prayer(1, l10n.dhuhr, t.dhuhr, st.enabledDhuhr, st.dhuhrSound),
      _Prayer(2, l10n.asr, t.asr, st.enabledAsr, st.asrSound),
      _Prayer(3, l10n.maghrib, t.maghrib, st.enabledMaghrib, st.maghribSound),
      _Prayer(4, l10n.isha, t.isha, st.enabledIsha, st.ishaSound),
    ];
    final plans = <NotificationPlan>[];
    final now = DateTime.now();
    for (final p in entries) {
      if (!p.enabled) continue;
      final time = _parseTime(date, p.raw, model.meta.timezone);
      if (time == null) continue;

      if (time.isAfter(now)) {
        plans.add(NotificationPlan(
          id: NotificationIds.prayer(date, p.index),
          title: l10n.prayerNotifTitle(p.name),
          body: l10n.prayerNotifBody,
          when: time,
          sound: notificationSoundFromString(p.sound),
        ));
      }
      if (st.beforePrayerMinutes > 0) {
        final pre = time.subtract(Duration(minutes: st.beforePrayerMinutes));
        if (pre.isAfter(now)) {
          plans.add(NotificationPlan(
            id: NotificationIds.prayer(date, p.index, pre: true),
            title: l10n.prePrayerNotifTitle(p.name),
            body: l10n.prePrayerNotifBody(st.beforePrayerMinutes),
            when: pre,
            sound: NotificationSound.short,
          ));
        }
      }
    }
    return plans;
  }

  /// "04:58" / "04:58 (EET)" → the exact INSTANT.
  /// The API returns the time in the timezone of the *coordinates* (meta.timezone).
  /// The old code read it as the phone's local time, so whenever the saved/fallback
  /// location (e.g. Makkah) was in a different zone than the phone, every prayer
  /// fired at the wrong time.
  DateTime? _parseTime(DateTime date, String raw, String zoneName) {
    final m = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
    if (m == null) return null;
    final h = int.parse(m.group(1)!), min = int.parse(m.group(2)!);
    if (h > 23 || min > 59) return null;
    if (zoneName.isNotEmpty) {
      try {
        final loc = tz.getLocation(zoneName);
        return tz.TZDateTime(loc, date.year, date.month, date.day, h, min);
      } catch (_) {/* unknown zone → fall back to device zone */}
    }
    return DateTime(date.year, date.month, date.day, h, min);
  }
}

class _Prayer {
  final int index;
  final String name;
  final String raw;
  final bool enabled;
  final String sound;
  _Prayer(this.index, this.name, this.raw, this.enabled, this.sound);
}
