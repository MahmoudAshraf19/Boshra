import 'package:flutter/foundation.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../core/notifications/notification_ids.dart';
import '../../../core/notifications/notification_plan_builders.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/utils/app_logger.dart';
import '../../../l10n/app_localizations.dart';
import '../data/models/prayer_times_model.dart';
import '../data/repositories/prayer_repository.dart';
import 'prayer_settings.dart';
import 'reminder_settings.dart';
import 'iqama_settings.dart';
import 'prayer_mode_settings.dart';
import '../../tracker/data/pattern_analyzer.dart';
import '../../tracker/data/prayer_tracker.dart';
import '../../tracker/data/weekly_stats.dart';
import '../../zakat/data/zakat_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerPlanResult {
  final List<NotificationPlan> plans;
  /// false when some day could not be loaded (offline, no cache).
  final bool complete;
  final List<int> enabledSlots;
  final List<int> adhanSlots;
  final bool preEnabled;
  const PrayerPlanResult(this.plans, this.complete,
      {this.enabledSlots = const [],
      this.adhanSlots = const [],
      this.preEnabled = false});
}

/// Builds (does not schedule) prayer + pre-prayer + Azkar plans.
/// Texts come from the ARB files in the USER'S APP LANGUAGE.
class PrayerSchedulerService {
  static const _tag = 'PrayerPlan';
  final PrayerRepository _repo = PrayerRepository();

  // 8 days so that the coming Thursday night AND Friday are always inside the window.
  int get _days => kIsWeb ? 0 : (defaultTargetPlatform == TargetPlatform.iOS ? 4 : 8);

  Future<PrayerPlanResult> buildPlan(AppLocalizations l10n, {bool background = false}) async {
    final out = <NotificationPlan>[];
    if (_days == 0) return const PrayerPlanResult([], false);
    bool complete = true;
    PrayerSettings st = PrayerSettings.defaults();
    try {
      // fresh: the other isolate (UI / WorkManager) may have changed the settings.
      st = await PrayerSettings.load(fresh: true);
      final rem = await ReminderSettings.load(fresh: true);
      final arabic = l10n.localeName.startsWith('ar');
      final iq = await IqamaSettings.load(fresh: true, ar: arabic);
      final pm = await PrayerModeSettings.load(fresh: true);
      final trk = await PrayerTracker.load();
      final prefs = await SharedPreferences.getInstance();
      final nudgeOn = (prefs.getBool('tracker_nudge') ?? true) && (prefs.getBool('tracker_used') ?? false);
      final trackerUsed = prefs.getBool('tracker_used') ?? false;
      final dhikr = prefs.getBool('dhikr_hint') ?? true;
      final weeklyOn = prefs.getBool('weekly_summary') ?? true;
      final pset = await PatternSettings.load();
      // What the app learned about this user (on-device only).
      final insights = (pset.learning && trackerUsed) ? await PatternAnalyzer.analyze() : PatternInsights.empty;
      final zakat = await ZakatSettings.load();
      final fajrByDay = <DateTime, DateTime>{};
      final fridayIsha = <DateTime, DateTime>{};
      final today = DateTime.now();
      for (int i = 0; i < _days; i++) {
        final date = DateTime(today.year, today.month, today.day + i);
        PrayerTimesModel? model;
        try {
          model = await _repo.getPrayerTimesForDate(date,
              savedLocationOnly: background,
              method: st.calcMethod,
              school: st.asrSchool);
        } catch (e, s) {
          AppLogger.e(_tag, e, s, 'day $date');
        }
        if (model == null) {
          complete = false;
          out.addAll(NotificationPlanBuilders.azkarForDay(date, l10n, rem));
          continue;
        }
        final times = _times(date, model, st);
        out.addAll(_planDay(date, times, st, l10n, dhikr: dhikr));
        if (times[0] != null) fajrByDay[date] = times[0]!;
        if (date.weekday == DateTime.friday && times[4] != null) fridayIsha[date] = times[4]!;
        out.addAll(_extraPlans(
          date: date,
          times: times,
          sunrise: _parseTime(date, model.timings.sunrise, model.meta.timezone),
          st: st,
          l10n: l10n,
          iq: iq,
          pm: pm,
          tracker: trk,
          nudgeOn: nudgeOn,
          insights: insights,
        ));
        if (date.weekday == DateTime.thursday || date.weekday == DateTime.friday) {
          out.addAll(NotificationPlanBuilders.fridayForDay(
            date,
            l10n.localeName.startsWith('ar'),
            rem,
            fajr: times[0],
            sunrise: _parseTime(date, model.timings.sunrise, model.meta.timezone),
            dhuhr: times[1],
            asr: times[2],
            maghrib: times[3],
            isha: times[4],
          ));
        }
        out.addAll(NotificationPlanBuilders.azkarForDay(date, l10n, rem,
            fajr: times[0], asr: times[2], maghrib: times[3]));
      }
      // After the per-day loop: plans that need several days / settings.
      out.addAll(_sleepPlans(pset, fajrByDay, l10n));
      if (weeklyOn && trackerUsed) out.addAll(_weeklyPlans(fridayIsha, trk, l10n));
      out.addAll(_zakatPlans(zakat, l10n));
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'buildPlan');
      complete = false;
    }
    AppLogger.d(_tag, 'planned ${out.length} (complete=$complete)');
    return PrayerPlanResult(out, complete,
        enabledSlots: st.enabledSlots, adhanSlots: st.adhanSlots, preEnabled: st.preEnabled);
  }

  /// Iqama alerts, gentle "did you pray?" nudges and prayer-mode (auto-silence) events.
  List<NotificationPlan> _extraPlans({
    required DateTime date,
    required List<DateTime?> times,
    required DateTime? sunrise,
    required PrayerSettings st,
    required AppLocalizations l10n,
    required IqamaSettings iq,
    required PrayerModeSettings pm,
    required Map<String, int> tracker,
    required bool nudgeOn,
    required PatternInsights insights,
  }) {
    final ar = l10n.localeName.startsWith('ar');
    final names = [l10n.fajr, l10n.dhuhr, l10n.asr, l10n.maghrib, l10n.isha];
    final now = DateTime.now();
    final out = <NotificationPlan>[];
    final prof = iq.profile;

    for (var i = 0; i < 5; i++) {
      final time = times[i];
      if (time == null || !st.enabled[i]) continue;

      // --- Iqama: "X minutes after the Adhan" (per prayer, per mosque profile)
      if (iq.enabled && iq.perPrayer[i]) {
        final at = time.add(Duration(minutes: prof.minutes[i]));
        if (at.isAfter(now)) {
          out.add(NotificationPlan(
            id: NotificationIds.iqama(date, i),
            title: ar ? 'الإقامة بعد قليل — ${names[i]}' : 'Iqama soon — ${names[i]}',
            body: ar
                ? 'مرّت ${prof.minutes[i]} دقيقة على الأذان (${prof.name}). استعد للصلاة.'
                : '${prof.minutes[i]} min since the Adhan (${prof.name}). Get ready to pray.',
            when: at,
            sound: iq.sound == 'silent' ? NotificationSound.silent : NotificationSound.short,
            islamicStyle: true,
          ));
        }
      }

      // --- Prayer mode: auto-silence (ON after the Adhan, OFF after the duration)
      if (pm.enabled && pm.perPrayer[i]) {
        final on = time.add(Duration(minutes: pm.startAfterMin));
        final off = on.add(Duration(minutes: pm.durationMin));
        if (off.isAfter(now) && on.isAfter(now)) {
          out.add(NotificationPlan(
            id: NotificationIds.mode(date, i, off: false),
            title: 'on',
            body: '',
            when: on,
            sound: NotificationSound.silent,
            kind: 'mode',
          ));
          out.add(NotificationPlan(
            id: NotificationIds.mode(date, i, off: true),
            title: 'off',
            body: '',
            when: off,
            sound: NotificationSound.silent,
            kind: 'mode',
          ));
        }
      }

      // --- Gentle nudge: only for users of the tracker, only if not marked yet.
      if (nudgeOn && !PrayerTracker.isDone(tracker, date, i)) {
        final DateTime? windowEnd = switch (i) {
          0 => sunrise?.subtract(const Duration(minutes: 15)),
          1 => times[2]?.subtract(const Duration(minutes: 20)),
          2 => times[3]?.subtract(const Duration(minutes: 20)),
          3 => times[4]?.subtract(const Duration(minutes: 20)),
          _ => time.add(const Duration(minutes: 150)),
        };
        // Learned habit: if THIS user usually prays it at the end of its time, remind earlier
        // (middle of the window instead of 15-20 minutes before the end).
        final late = insights.lateProne(i);
        DateTime? at = windowEnd;
        if (windowEnd != null && late) {
          final mid = time.add(Duration(milliseconds: (windowEnd.difference(time).inMilliseconds * 0.5).round()));
          final floor = time.add(const Duration(minutes: 25));
          at = mid.isBefore(floor) ? floor : mid;
        }
        if (at != null && windowEnd != null && at.isAfter(now) && windowEnd.isAfter(time)) {
          final isToday = DateTime(now.year, now.month, now.day) == date;
          final txt = _nudgeText(
            prayer: i,
            name: names[i],
            ar: ar,
            streak: isToday ? PrayerTracker.streakFor(tracker, i) : 0,
            late: late,
            seed: date.day + date.month + i,
          );
          out.add(NotificationPlan(
            id: NotificationIds.nudge(date, i),
            title: txt.$1,
            body: txt.$2,
            when: at,
            sound: NotificationSound.silent, // gentle: no sound
            islamicStyle: false,
            actionLabel: ar ? 'صلّيت ✓' : 'I prayed ✓',
            actionPayload: 'prayed:$i:${PrayerTracker.dayKey(date)}',
            route: 'garden', // tap → your garden, with the thirsty tree
          ));
        }
      }
    }
    return out;
  }

  /// Gentle "you have not prayed yet" messages — varied day to day, tied to the garden metaphor,
  /// and aware of the user's streak / habit. Never scolding.
  (String, String) _nudgeText({
    required int prayer,
    required String name,
    required bool ar,
    required int streak,
    required bool late,
    required int seed,
  }) {
    if (late) {
      return ar
          ? ('شجرة $name بتستنّاك 🌿', 'لاحظنا إنك غالبًا بتصلّيها في آخر وقتها — جرّب النهارده بدري، وشجرتك هتفرح 🌳')
          : ('Your $name tree is waiting 🌿', 'You usually pray it near the end of its time — try earlier today, your tree will be happy 🌳');
    }
    if (streak >= 3) {
      return ar
          ? ('مواظبتك $streak يوم 🔥', 'شجرة $name كبرت معاك — متخليهاش تقف النهارده. وقتها لسه موجود 🌳')
          : ('$streak days in a row 🔥', 'Your $name tree grew with you — do not let it stop today. There is still time 🌳');
    }
    final ar4 = [
      ('شجرة $name عطشانة 💧', 'لسه فاضل وقت تسقيها بصلاة — دقايق وترجع خضرا 🌿'),
      ('هل صلّيت $name؟ 🌱', 'وقتها لسه موجود، وشجرتك مستنياك تكبر.'),
      ('نسمة لطيفة 🍃', '$name بتناديك… صلاة صغيرة تفرّح شجرتك وقلبك 🌳'),
      ('متسيبهاش تدبل 🌿', 'الصلاة نور — وقت $name لسه ممتد. سجّلها لو صلّيت 🤍'),
    ];
    final en4 = [
      ('Your $name tree is thirsty 💧', 'There is still time to water it with prayer — a few minutes and it is green again 🌿'),
      ('Did you pray $name? 🌱', 'Its time is still open and your tree is waiting to grow.'),
      ('A gentle breeze 🍃', '$name is calling… a small prayer that makes your tree and your heart smile 🌳'),
      ('Do not let it wilt 🌿', 'Prayer is light — the time for $name is still open. Mark it if you prayed 🤍'),
    ];
    final k = seed % 4;
    return ar ? ar4[k] : en4[k];
  }

  // ---- dhikr suggestion merged into the Adhan notification
  static String _dhikrRoute(int i) => switch (i) {
        0 => 'azkar:morning',
        2 => 'azkar:evening',
        4 => 'azkar:sleep',
        _ => 'azkar:after',
      };

  static String _dhikrHint(int i, bool ar) => switch (i) {
        0 => ar ? '☀️ بعد الصلاة: أذكار الصباح — اضغط لقراءتها' : '☀️ After prayer: morning adhkar — tap to read',
        1 => ar ? '📿 بعد الصلاة: التسبيح والأذكار — اضغط لقراءتها' : '📿 After prayer: tasbeeh & adhkar — tap to read',
        2 => ar ? '🌇 بعد الصلاة: أذكار المساء — اضغط لقراءتها' : '🌇 After prayer: evening adhkar — tap to read',
        3 => ar ? '📿 بعد الصلاة: التسبيح والأذكار — اضغط لقراءتها' : '📿 After prayer: tasbeeh & adhkar — tap to read',
        _ => ar ? '🌙 قبل النوم: أذكار النوم — اضغط لقراءتها' : '🌙 Before sleep: bedtime adhkar — tap to read',
      };

  /// "Sleep early for Fajr" — only when the user accepted the suggestion learned from his habits.
  List<NotificationPlan> _sleepPlans(PatternSettings ps, Map<DateTime, DateTime> fajrByDay, AppLocalizations l10n) {
    if (!ps.sleepOn) return const [];
    final ar = l10n.localeName.startsWith('ar');
    final now = DateTime.now();
    final out = <NotificationPlan>[];
    for (final e in fajrByDay.entries) {
      final d = e.key;
      final next = fajrByDay[DateTime(d.year, d.month, d.day + 1)];
      if (next == null) continue;
      final at = DateTime(d.year, d.month, d.day).add(Duration(minutes: ps.sleepMinutes));
      if (!at.isAfter(now) || !at.isBefore(next)) continue;
      final hours = (next.difference(at).inMinutes / 60).toStringAsFixed(1);
      final hh = next.hour.toString().padLeft(2, '0');
      final mm = next.minute.toString().padLeft(2, '0');
      out.add(NotificationPlan(
        id: NotificationIds.sleep(d),
        title: ar ? 'نام بدري عشان الفجر 🌙' : 'Sleep early for Fajr 🌙',
        body: ar
            ? 'الفجر بكرة $hh:$mm — لو نمت دلوقتي هتنام $hours ساعات. وقبل النوم: أذكار النوم 📿'
            : 'Fajr is at $hh:$mm tomorrow — sleeping now gives you $hours hours. And bedtime adhkar 📿',
        when: at,
        sound: NotificationSound.short,
        islamicStyle: true,
        route: 'azkar:sleep',
      ));
    }
    return out;
  }

  /// Friday evening: "you prayed 31 of 35…". Numbers are exact when scheduled on the same day;
  /// otherwise a generic line (the screen always shows the live numbers).
  List<NotificationPlan> _weeklyPlans(Map<DateTime, DateTime> fridayIsha, Map<String, int> tracker, AppLocalizations l10n) {
    final ar = l10n.localeName.startsWith('ar');
    final now = DateTime.now();
    final names = [l10n.fajr, l10n.dhuhr, l10n.asr, l10n.maghrib, l10n.isha];
    final out = <NotificationPlan>[];
    for (final e in fridayIsha.entries) {
      final at = e.value.add(const Duration(minutes: 45));
      if (!at.isAfter(now)) continue;
      final sameDay = DateTime(now.year, now.month, now.day) == e.key;
      final stats = WeeklyStats.from(tracker, now: e.key);
      out.add(NotificationPlan(
        id: NotificationIds.weekly(e.key),
        title: ar ? 'ملخّصك الأسبوعي 🌳' : 'Your weekly summary 🌳',
        body: (sameDay && stats.total > 0)
            ? '${stats.sentence(names, ar)}. ${ar ? 'اضغط لتشوف شجرتك وتشاركها' : 'Tap to see and share your tree'}'
            : (ar ? 'ملخّص صلواتك هذا الأسبوع جاهز — اضغط لتشوف شجرتك 🌱' : 'Your prayers summary for this week is ready — tap to see your tree 🌱'),
        when: at,
        sound: NotificationSound.short,
        islamicStyle: true,
        route: 'weekly',
      ));
    }
    return out;
  }

  /// Yearly zakat reminder: a week before the lunar year completes, and on the day.
  List<NotificationPlan> _zakatPlans(ZakatSettings z, AppLocalizations l10n) {
    if (!z.remind) return const [];
    final due = z.nextDue(DateTime.now());
    if (due == null) return const [];
    final ar = l10n.localeName.startsWith('ar');
    final now = DateTime.now();
    final out = <NotificationPlan>[];
    final before = DateTime(due.year, due.month, due.day - 7, 10);
    final on = DateTime(due.year, due.month, due.day, 10);
    if (before.isAfter(now)) {
      out.add(NotificationPlan(
        id: NotificationIds.zakatBefore,
        title: ar ? 'اقترب موعد زكاة مالك 🌙' : 'Your zakat date is near 🌙',
        body: ar
            ? 'يتم حَوْلك بعد أسبوع تقريبًا. حدّث أرقامك واحسب زكاتك بأسعار اليوم.'
            : 'Your lunar year completes in about a week. Update your numbers and calculate with today\'s prices.',
        when: before,
        sound: NotificationSound.short,
        islamicStyle: true,
        route: 'zakat',
      ));
    }
    if (on.isAfter(now)) {
      out.add(NotificationPlan(
        id: NotificationIds.zakatOn,
        title: ar ? 'حان موعد زكاة المال 🤲' : 'It is time for your zakat 🤲',
        body: ar
            ? 'تَمّ الحَوْل. احسب زكاتك بأسعار الذهب والفضة اليوم، وأخرجها تقبّل الله منك.'
            : 'Your lunar year is complete. Calculate with today\'s gold & silver prices and give it — may Allah accept it.',
        when: on,
        sound: NotificationSound.short,
        islamicStyle: true,
        route: 'zakat',
      ));
    }
    return out;
  }

  /// The 5 prayer instants of a day, with the user's fine-tune offsets applied.
  List<DateTime?> _times(DateTime date, PrayerTimesModel model, PrayerSettings st) {
    final t = model.timings;
    final raw = [t.fajr, t.dhuhr, t.asr, t.maghrib, t.isha];
    return [
      for (var i = 0; i < 5; i++)
        () {
          final d = _parseTime(date, raw[i], model.meta.timezone);
          return d?.add(Duration(minutes: st.offsets[i]));
        }()
    ];
  }

  List<NotificationPlan> _planDay(
      DateTime date, List<DateTime?> times, PrayerSettings st, AppLocalizations l10n,
      {bool dhikr = true}) {
    final arabic = l10n.localeName.startsWith('ar');
    final names = [l10n.fajr, l10n.dhuhr, l10n.asr, l10n.maghrib, l10n.isha];
    final plans = <NotificationPlan>[];
    final now = DateTime.now();
    for (var i = 0; i < 5; i++) {
      if (!st.enabled[i]) continue;
      final time = times[i];
      if (time == null) continue;

      if (time.isAfter(now)) {
        final sound = notificationSoundFromString(st.sounds[i]);
        final adhan = sound == NotificationSound.adhan;
        plans.add(NotificationPlan(
          id: NotificationIds.prayer(date, i),
          title: l10n.prayerNotifTitle(names[i]),
          // One notification with the Adhan AND the right dhikr for this time (tap → opens it).
          body: dhikr ? '${l10n.prayerNotifBody}\n${_dhikrHint(i, arabic)}' : l10n.prayerNotifBody,
          route: dhikr ? _dhikrRoute(i) : null,
          when: time,
          sound: sound,
          adhanId: st.adhanReciter,
          islamicStyle: true,
          // The Adhan notification ALWAYS has a Stop button.
          stopLabel: adhan ? l10n.adhanStopAction : null,
          verse: adhan && st.adhanBanner ? l10n.adhanBannerVerse : null,
          showBanner: adhan && st.adhanBanner,
        ));
      }
      if (st.preEnabled && st.beforePrayerMinutes > 0) {
        final pre = time.subtract(Duration(minutes: st.beforePrayerMinutes));
        if (pre.isAfter(now)) {
          plans.add(NotificationPlan(
            id: NotificationIds.prayer(date, i, pre: true),
            title: l10n.prePrayerNotifTitle(names[i]),
            body: l10n.prePrayerNotifBody(st.beforePrayerMinutes),
            when: pre,
            sound: st.preSound == 'silent' ? NotificationSound.silent : NotificationSound.short,
            islamicStyle: true,
          ));
        }
      }
    }
    return plans;
  }

  /// "04:58" / "04:58 (EET)" → the exact INSTANT in the zone of the coordinates.
  DateTime? _parseTime(DateTime date, String raw, String zoneName) {
    final m = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(raw);
    if (m == null) return null;
    final h = int.parse(m.group(1)!), min = int.parse(m.group(2)!);
    if (h > 23 || min > 59) return null;
    if (zoneName.isNotEmpty) {
      try {
        final loc = tz.getLocation(zoneName);
        return tz.TZDateTime(loc, date.year, date.month, date.day, h, min);
      } catch (_) {/* unknown zone → device zone */}
    }
    return DateTime(date.year, date.month, date.day, h, min);
  }
}
