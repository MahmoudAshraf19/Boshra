import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../l10n/app_localizations.dart';
import '../services/notification_service.dart';
import '../utils/app_logger.dart';
import 'notification_ids.dart';

/// Pure builders: they only describe WHAT should be scheduled.
class NotificationPlanBuilders {
  NotificationPlanBuilders._();

  static const chAzkar = 'daily_azkar_channel_v4';
  static const chQuran = 'quran_messages_channel_v4';

  /// Morning (09:00) and evening (19:00) Azkar, repeating daily at that clock time.
  static List<NotificationPlan> azkar(AppLocalizations l10n) => [
        NotificationPlan(
          id: NotificationIds.azkarMorning,
          title: l10n.morningAzkarNotificationTitle,
          body: l10n.morningAzkarNotificationBody,
          when: _next(9, 0),
          sound: NotificationSound.short,
          channelId: chAzkar,
          repeat: DateTimeComponents.time,
        ),
        NotificationPlan(
          id: NotificationIds.azkarEvening,
          title: l10n.eveningAzkarNotificationTitle,
          body: l10n.eveningAzkarNotificationBody,
          when: _next(19, 0),
          sound: NotificationSound.short,
          channelId: chAzkar,
          repeat: DateTimeComponents.time,
        ),
      ];

  /// A different verse for each of the next days at 09:00 (deterministic per day).
  static Future<List<NotificationPlan>> quran(AppLocalizations l10n) async {
    final out = <NotificationPlan>[];
    try {
      final days = defaultTargetPlatform == TargetPlatform.iOS ? 7 : 14;
      final json = await rootBundle.loadString('assets/data/boshra_120_quran_verses.json');
      final verses = (jsonDecode(json)['verses'] as List);
      if (verses.isEmpty) return out;
      final now = tz.TZDateTime.now(tz.local);
      final epochDay = DateTime.utc(now.year, now.month, now.day)
          .difference(DateTime.utc(2024, 1, 1))
          .inDays;
      for (int i = 0; i < days; i++) {
        final when = tz.TZDateTime(tz.local, now.year, now.month, now.day + i, 9, 0);
        if (!when.isAfter(now)) continue;
        final text = (verses[(epochDay + i) % verses.length]['text'] ?? '').toString();
        if (text.isEmpty) continue;
        out.add(NotificationPlan(
          // Slot = day-of-cycle, so the same calendar day always keeps the same id.
          id: NotificationIds.quranBase + ((epochDay + i) % 90),
          title: l10n.quranMessageNotificationTitle,
          body: text,
          when: when,
          sound: NotificationSound.short,
          channelId: chQuran,
        ));
      }
    } catch (e, s) {
      AppLogger.e('QuranPlan', e, s);
    }
    return out;
  }

  static DateTime _next(int h, int m) {
    final now = tz.TZDateTime.now(tz.local);
    var d = tz.TZDateTime(tz.local, now.year, now.month, now.day, h, m);
    if (!d.isAfter(now)) d = tz.TZDateTime(tz.local, now.year, now.month, now.day + 1, h, m);
    return d;
  }
}
