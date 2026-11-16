import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../features/prayer/domain/reminder_settings.dart';
import '../../l10n/app_localizations.dart';
import '../services/notification_service.dart';
import '../utils/app_logger.dart';
import 'notification_ids.dart';

/// Pure builders: they only describe WHAT should be scheduled.
class NotificationPlanBuilders {
  NotificationPlanBuilders._();

  static const chAzkar = 'daily_azkar_channel_v4';
  static const chQuran = 'quran_messages_channel_v4';
  /// Friday has its OWN channel (own chime, gold accent) so it can never be mistaken for another alert.
  static const chFriday = 'friday_jumuah_channel_v1';

  /// Surat Al-Ahzab 33:56 — exactly as requested.
  static const salawatVerse =
      'إِنَّ اللَّهَ وَمَلَائِكَتَهُ يُصَلُّونَ عَلَى النَّبِيِّ يَا أَيُّهَا الَّذِينَ آَمَنُوا صَلُّوا عَلَيْهِ وَسَلِّمُوا تَسْلِيمًا';

  static NotificationSound _snd(String s) =>
      s == 'silent' ? NotificationSound.silent : NotificationSound.short;

  static DateTime _at(DateTime d, int h, int m) =>
      tz.TZDateTime(tz.local, d.year, d.month, d.day, h, m);

  /// Azkar for ONE day. [fajr]/[asr]/[maghrib] are the day's real prayer instants
  /// (null when the times could not be loaded → safe fixed fallback times).
  ///  * Morning: [ReminderSettings.morningAfterFajrMin] after Fajr (default 2 h).
  ///  * Evening: after Asr, always before Maghrib.
  static List<NotificationPlan> azkarForDay(
    DateTime date,
    AppLocalizations l10n,
    ReminderSettings r, {
    DateTime? fajr,
    DateTime? asr,
    DateTime? maghrib,
  }) {
    final now = DateTime.now();
    final out = <NotificationPlan>[];
    if (r.morningEnabled) {
      final t = fajr != null
          ? fajr.add(Duration(minutes: r.morningAfterFajrMin))
          : _at(date, 7, 0);
      if (t.isAfter(now)) {
        out.add(NotificationPlan(
          id: NotificationIds.azkar(date, evening: false),
          title: l10n.morningAzkarNotificationTitle,
          body: l10n.morningAzkarNotificationBody,
          when: t,
          sound: _snd(r.morningSound),
          channelId: chAzkar,
        ));
      }
    }
    if (r.eveningEnabled) {
      var t = asr != null
          ? asr.add(Duration(minutes: r.eveningAfterAsrMin))
          : _at(date, 17, 0);
      if (maghrib != null) {
        final latest = maghrib.subtract(const Duration(minutes: 10));
        if (t.isAfter(latest)) t = latest;
      }
      if (t.isAfter(now)) {
        out.add(NotificationPlan(
          id: NotificationIds.azkar(date, evening: true),
          title: l10n.eveningAzkarNotificationTitle,
          body: l10n.eveningAzkarNotificationBody,
          when: t,
          sound: _snd(r.eveningSound),
          channelId: chAzkar,
        ));
      }
    }
    return out;
  }

  /// Ayah of the day: a different verse for each coming day at the user's time.
  static Future<List<NotificationPlan>> ayah(AppLocalizations l10n, ReminderSettings r) async {
    final out = <NotificationPlan>[];
    if (!r.ayahEnabled) return out;
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
        final when = tz.TZDateTime(tz.local, now.year, now.month, now.day + i, r.ayahHour, r.ayahMinute);
        if (!when.isAfter(now)) continue;
        final text = (verses[(epochDay + i) % verses.length]['text'] ?? '').toString();
        if (text.isEmpty) continue;
        out.add(NotificationPlan(
          id: NotificationIds.quranBase + ((epochDay + i) % 90),
          title: l10n.quranMessageNotificationTitle,
          body: text,
          when: when,
          sound: _snd(r.ayahSound),
          channelId: chQuran,
        ));
      }
    } catch (e, s) {
      AppLogger.e('AyahPlan', e, s);
    }
    return out;
  }

  /// Friday reminders. Thursday night + Friday, split between the Salawat verse and Al-Kahf:
  ///   Thu after Isha → Al-Kahf     Fri before Fajr → Salawat   Fri at sunrise → Al-Kahf
  ///   Fri after Dhuhr → Salawat    Fri after Asr   → Al-Kahf (last chance before Maghrib)
  /// [isha] is used on Thursday; the others on Friday. Every time is a real prayer instant.
  static List<NotificationPlan> fridayForDay(
    DateTime date,
    bool arabic,
    ReminderSettings r, {
    DateTime? fajr,
    DateTime? sunrise,
    DateTime? dhuhr,
    DateTime? asr,
    DateTime? maghrib,
    DateTime? isha,
  }) {
    final out = <NotificationPlan>[];
    if (!r.fridayEnabled) return out;
    final now = DateTime.now();
    final sound = r.fridaySound == 'silent' ? NotificationSound.silent : NotificationSound.short;

    void add(int slot, DateTime? t, String title, String body) {
      if (t == null || !t.isAfter(now)) return;
      out.add(NotificationPlan(
        id: NotificationIds.friday(date, slot),
        title: title,
        body: body,
        when: t,
        sound: sound,
        channelId: chFriday,
        islamicStyle: true,
      ));
    }

    String ar(String a, String e) => arabic ? a : e;

    if (date.weekday == DateTime.thursday) {
      add(
        0,
        isha?.add(const Duration(minutes: 20)),
        ar('🌙 ليلة الجمعة · سورة الكهف', '🌙 Jumu\'ah eve · Surat Al-Kahf'),
        ar('دخلت ليلة الجمعة، وهذا وقت طيب لقراءة سورة الكهف. قال ﷺ: «مَنْ قَرَأَ سُورَةَ الْكَهْفِ يَوْمَ الْجُمُعَةِ أَضَاءَ لَهُ مِنَ النُّورِ مَا بَيْنَ الْجُمُعَتَيْنِ».',
            'Jumu\'ah eve begins — a blessed time to read Surat Al-Kahf. The Prophet ﷺ said: “Whoever reads Surat Al-Kahf on Friday, a light will shine for him until the next Friday.”'),
      );
    } else if (date.weekday == DateTime.friday) {
      final salawatTitle = ar('ﷺ يوم الجمعة · أكثِروا من الصلاة على النبي', 'ﷺ Friday · Send blessings upon the Prophet');
      add(1, fajr?.subtract(const Duration(minutes: 30)), salawatTitle, salawatVerse);
      add(
        2,
        sunrise?.add(const Duration(minutes: 2)),
        ar('☀️ جمعة مباركة · سورة الكهف', '☀️ Blessed Friday · Surat Al-Kahf'),
        ar('أشرقت شمس يوم الجمعة. لا تنسَ قراءة سورة الكهف، فنورها يمتدّ إلى الجمعة القادمة.',
            'The sun has risen on Friday. Don\'t forget Surat Al-Kahf — its light lasts until next Friday.'),
      );
      add(3, dhuhr?.add(const Duration(minutes: 45)), salawatTitle, salawatVerse);
      var t = asr?.add(const Duration(minutes: 25));
      if (t != null && maghrib != null) {
        final latest = maghrib.subtract(const Duration(minutes: 15));
        if (t.isAfter(latest)) t = latest;
      }
      add(
        4,
        t,
        ar('⏳ لم تقرأ الكهف بعد؟', '⏳ Haven\'t read Al-Kahf yet?'),
        ar('ما زال في اليوم متّسع قبل المغرب — اقرأ سورة الكهف الآن، وأكثِر من الدعاء فهذه ساعة الاستجابة.',
            'There is still time before Maghrib — read Surat Al-Kahf now, and make plenty of du\'a: this is the hour of response.'),
      );
    }
    return out;
  }
}
