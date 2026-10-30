import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geolocator/geolocator.dart' show Geolocator;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../l10n/app_localizations.dart';
import '../notifications/notification_ids.dart';
import '../utils/app_logger.dart';

/// What the OS currently allows us to do.
class NotificationPermissionStatus {
  final bool notificationsEnabled;
  final bool exactAlarmsAllowed;
  const NotificationPermissionStatus({
    required this.notificationsEnabled,
    required this.exactAlarmsAllowed,
  });
  bool get allGood => notificationsEnabled && exactAlarmsAllowed;
}

/// Sound profile for a notification.
enum NotificationSound { adhan, short, silent }

NotificationSound notificationSoundFromString(String s) {
  switch (s) {
    case 'adhan':
      return NotificationSound.adhan;
    case 'silent':
      return NotificationSound.silent;
    default:
      return NotificationSound.short;
  }
}

/// Single entry point for every local notification in the app.
///
/// Fixes vs. the old version:
///  * Sets the REAL device time-zone (old code left tz.local = UTC, so Azkar and
///    Quran messages fired 2-3 hours off).
///  * Never calls cancelAll() – only cancels its own ID ranges.
///  * Creates channels explicitly; versioned IDs (sound can't change afterwards).
///  * Checks notification + exact-alarm permission and degrades gracefully.
///  * All scheduling goes through one serialized queue (no racing cancel/schedule).
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  static const _tag = 'Notifications';

  // Channel IDs are versioned: Android freezes sound/importance after creation.
  static const _chAdhan = 'adhan_channel_v4';
  static const _chShort = 'prayer_short_channel_v4';
  static const _chSilent = 'prayer_silent_channel_v4';
  static const _chAzkar = 'daily_azkar_channel_v4';
  static const _chQuran = 'quran_messages_channel_v4';

  /// Channels the app really uses (for health checks).
  static const managedChannelIds = [_chAdhan, _chShort, _chSilent, _chAzkar, _chQuran];

  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  // Kept for source compatibility with older call sites.
  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin => plugin;

  bool _initialized = false;
  String _tzName = 'UTC';
  String get timeZoneName => _tzName;

  // ---- serialization -------------------------------------------------------
  Future<void> _queue = Future.value();
  /// Runs [job] after all previously queued jobs finished.
  Future<T> synchronized<T>(Future<T> Function() job) {
    final c = Completer<T>();
    _queue = _queue.then((_) async {
      try {
        c.complete(await job());
      } catch (e, s) {
        c.completeError(e, s);
      }
    });
    return c.future;
  }

  // ---- init ----------------------------------------------------------------
  Future<void> init() async {
    if (_initialized || kIsWeb) return;
    try {
      tzdata.initializeTimeZones();
      await _configureLocalTimeZone();

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const darwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      await plugin.initialize(
        settings: const InitializationSettings(
            android: android, iOS: darwin, macOS: darwin),
      );
      await _createAndroidChannels();
      _initialized = true;
      AppLogger.d(_tag, 'initialized (tz=$_tzName)');
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'init failed');
    }
  }

  Future<void> _configureLocalTimeZone() async {
    String? name;
    try {
      // Works with flutter_timezone 4.x (String) and 5.x (TimezoneInfo).
      final dynamic r = await FlutterTimezone.getLocalTimezone();
      name = r is String ? r : (r.identifier as String);
    } catch (e) {
      AppLogger.w(_tag, 'flutter_timezone failed: $e');
    }
    try {
      if (name != null) {
        tz.setLocalLocation(tz.getLocation(name));
        _tzName = name;
        return;
      }
    } catch (e) {
      AppLogger.w(_tag, 'unknown tz "$name": $e');
    }
    // Fallback: find a zone whose current offset equals the device offset.
    final offset = DateTime.now().timeZoneOffset;
    for (final loc in tz.timeZoneDatabase.locations.values) {
      if (tz.TZDateTime.now(loc).timeZoneOffset == offset) {
        tz.setLocalLocation(loc);
        _tzName = loc.name;
        return;
      }
    }
    tz.setLocalLocation(tz.UTC);
    _tzName = 'UTC';
  }

  Future<void> _createAndroidChannels() async {
    final a = plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (a == null) return;
    const adhan = RawResourceAndroidNotificationSound('adhan');
    const beep = RawResourceAndroidNotificationSound('notification');
    final channels = <AndroidNotificationChannel>[
      const AndroidNotificationChannel(_chAdhan, 'Adhan',
          description: 'Full Adhan at prayer time',
          importance: Importance.max,
          sound: adhan,
          audioAttributesUsage: AudioAttributesUsage.alarm),
      const AndroidNotificationChannel(_chShort, 'Prayer alerts',
          description: 'Short alert for prayers and pre-prayer reminders',
          importance: Importance.max,
          sound: beep),
      const AndroidNotificationChannel(_chSilent, 'Silent prayer alerts',
          description: 'Prayer alerts without sound',
          importance: Importance.high,
          playSound: false),
      const AndroidNotificationChannel(_chAzkar, 'Daily Azkar',
          description: 'Morning and evening Azkar reminders',
          importance: Importance.high,
          sound: beep),
      const AndroidNotificationChannel(_chQuran, 'Quran messages',
          description: 'A daily verse from the Quran',
          importance: Importance.defaultImportance,
          sound: beep),
    ];
    for (final c in channels) {
      await a.createNotificationChannel(c);
    }
    // Old channels (v1-v3) are left in place so user choices survive; they are unused.
  }

  // ---- permissions ---------------------------------------------------------
  Future<NotificationPermissionStatus> getStatus() async {
    if (kIsWeb) {
      return const NotificationPermissionStatus(
          notificationsEnabled: false, exactAlarmsAllowed: false);
    }
    try {
      if (Platform.isAndroid) {
        final a = plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        final enabled = await a?.areNotificationsEnabled() ?? true;
        final exact = await a?.canScheduleExactNotifications() ?? true;
        return NotificationPermissionStatus(
            notificationsEnabled: enabled, exactAlarmsAllowed: exact);
      }
      if (Platform.isIOS) {
        final i = plugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
        final p = await i?.checkPermissions();
        return NotificationPermissionStatus(
            notificationsEnabled: p?.isEnabled ?? false, exactAlarmsAllowed: true);
      }
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'getStatus');
    }
    return const NotificationPermissionStatus(
        notificationsEnabled: true, exactAlarmsAllowed: true);
  }

  /// Asks for the notification permission (system dialog).
  /// Exact-alarm permission needs a Settings screen: use [requestExactAlarms]
  /// from a user-initiated action instead of spamming at start-up.
  Future<NotificationPermissionStatus> requestPermissions() async {
    if (kIsWeb) return getStatus();
    try {
      if (Platform.isIOS || Platform.isMacOS) {
        await plugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      } else if (Platform.isAndroid) {
        await plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'requestPermissions');
    }
    return getStatus();
  }

  Future<void> requestExactAlarms() async {
    try {
      await plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestExactAlarmsPermission();
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'requestExactAlarms');
    }
  }

  /// Opens the app's system settings page (used when permission was denied permanently).
  Future<void> openAppSettings() async {
    try {
      await Geolocator.openAppSettings();
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'openAppSettings');
    }
  }

  /// IDs of our channels that the USER switched off in system settings
  /// (a muted/blocked Adhan channel = no Adhan, even with all permissions granted).
  Future<List<String>> blockedChannels() async {
    if (kIsWeb || !Platform.isAndroid) return const [];
    try {
      final a = plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      final list = await a?.getNotificationChannels() ?? [];
      return [
        for (final c in list)
          if (managedChannelIds.contains(c.id) && c.importance == Importance.none) c.id
      ];
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'blockedChannels');
      return const [];
    }
  }

  // ---- low-level scheduling ------------------------------------------------
  NotificationDetails _details(String channelId, NotificationSound sound,
      {String body = '', String? channelName}) {
    final bool adhan = sound == NotificationSound.adhan;
    final bool silent = sound == NotificationSound.silent;
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName ?? channelId,
        importance: silent ? Importance.high : Importance.max,
        priority: Priority.high,
        playSound: !silent,
        sound: silent
            ? null
            : RawResourceAndroidNotificationSound(adhan ? 'adhan' : 'notification'),
        audioAttributesUsage:
            adhan ? AudioAttributesUsage.alarm : AudioAttributesUsage.notification,
        category: AndroidNotificationCategory.reminder,
        visibility: NotificationVisibility.public,
        styleInformation: BigTextStyleInformation(body),
      ),
      iOS: DarwinNotificationDetails(
        presentSound: !silent,
        sound: silent ? null : (adhan ? 'adhan.mp3' : 'notification.mp3'),
        interruptionLevel:
            adhan ? InterruptionLevel.timeSensitive : InterruptionLevel.active,
      ),
    );
  }

  String channelFor(NotificationSound s) {
    switch (s) {
      case NotificationSound.adhan:
        return _chAdhan;
      case NotificationSound.short:
        return _chShort;
      case NotificationSound.silent:
        return _chSilent;
    }
  }

  Future<AndroidScheduleMode> _scheduleMode() async {
    if (kIsWeb || !Platform.isAndroid) return AndroidScheduleMode.exactAllowWhileIdle;
    final can = await plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.canScheduleExactNotifications() ??
        false;
    return can
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }

  /// Schedules one notification at [when] (device-local time).
  /// Returns true on success. NEVER throws.
  Future<bool> scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime when,
    required NotificationSound sound,
    String? channelId,
    DateTimeComponents? repeat,
  }) async {
    if (kIsWeb || !_initialized) return false;
    final scheduled = tz.TZDateTime.from(when, tz.local);
    if (repeat == null && scheduled.isBefore(tz.TZDateTime.now(tz.local))) {
      return false;
    }
    final details = _details(channelId ?? channelFor(sound), sound, body: body);
    Future<void> go(AndroidScheduleMode mode) => plugin.zonedSchedule(
          id: id,
          title: title,
          body: body,
          scheduledDate: scheduled,
          notificationDetails: details,
          androidScheduleMode: mode,
          matchDateTimeComponents: repeat,
        );
    try {
      await go(await _scheduleMode());
      return true;
    } on PlatformException catch (e) {
      AppLogger.w(_tag, 'exact schedule failed (${e.code}); retrying inexact');
      try {
        await go(AndroidScheduleMode.inexactAllowWhileIdle);
        return true;
      } catch (e2, s) {
        AppLogger.e(_tag, e2, s, 'inexact schedule failed id=$id');
      }
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'schedule failed id=$id');
    }
    return false;
  }

  /// Cancels only the pending notifications whose id matches [test].
  Future<void> cancelWhere(bool Function(int id) test) async {
    if (kIsWeb || !_initialized) return;
    try {
      final pending = await plugin.pendingNotificationRequests();
      for (final p in pending) {
        if (test(p.id)) await plugin.cancel(id: p.id);
      }
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'cancelWhere');
    }
  }

  Future<int> pendingCount() async {
    try {
      return (await plugin.pendingNotificationRequests()).length;
    } catch (_) {
      return 0;
    }
  }

  // ---- idempotent plan application ----------------------------------------
  static const _planKey = 'notif_plan_v2';

  /// Makes the OS match [plans] with the MINIMUM of changes.
  ///
  /// Why: the old flow did "cancel everything → schedule everything" on every app
  /// open. If the app was closed / killed / offline in the middle, the user was left
  /// with NO notifications — which looked like "sometimes they arrive, sometimes not".
  /// Now: nothing is cancelled before its replacement exists; unchanged items are
  /// left alone; items that failed to schedule are retried next time.
  ///
  /// [cancelStalePrayers] must be false when the prayer plan is incomplete
  /// (e.g. offline) so we never delete valid future prayers just because we
  /// couldn't re-fetch their times.
  Future<void> applyPlan(List<NotificationPlan> plans,
      {bool cancelStalePrayers = true}) {
    return synchronized(() async {
      if (kIsWeb || !_initialized) return;
      try {
        final prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> stored = {};
        try {
          stored = (jsonDecode(prefs.getString(_planKey) ?? '{}') as Map).cast<String, dynamic>();
        } catch (_) {}

        final pending = (await plugin.pendingNotificationRequests()).map((p) => p.id).toSet();
        final mode = await _scheduleMode();
        final exact = mode == AndroidScheduleMode.exactAllowWhileIdle;

        final result = <String, String>{};
        int scheduled = 0, kept = 0, failed = 0;
        for (final p in plans) {
          final h = '${p.fingerprint}|$_tzName|$exact';
          if (pending.contains(p.id) && stored['${p.id}'] == h) {
            result['${p.id}'] = h;
            kept++;
            continue;
          }
          final ok = await scheduleAt(
            id: p.id, title: p.title, body: p.body, when: p.when,
            sound: p.sound, channelId: p.channelId, repeat: p.repeat,
          );
          if (ok) {
            result['${p.id}'] = h;
            scheduled++;
          } else if (!p.isPastOneShot) {
            failed++;
          }
        }

        // Remove only what is no longer wanted.
        final wanted = plans.map((p) => p.id).toSet();
        for (final id in pending) {
          if (wanted.contains(id)) continue;
          final managed = NotificationIds.isQuran(id) ||
              id == NotificationIds.azkarMorning ||
              id == NotificationIds.azkarEvening ||
              (cancelStalePrayers && NotificationIds.isPrayer(id));
          if (managed) await plugin.cancel(id: id);
        }

        await prefs.setString(_planKey, jsonEncode(result));
        AppLogger.d(_tag,
            'plan applied: new=$scheduled kept=$kept failed=$failed exact=$exact tz=$_tzName');
      } catch (e, s) {
        AppLogger.e(_tag, e, s, 'applyPlan');
      }
    });
  }

  // ---- housekeeping --------------------------------------------------------
  /// True when the device time-zone changed since the last schedule.
  Future<bool> timeZoneChanged() async {
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getString('notif_tz');
    await _configureLocalTimeZone();
    await prefs.setString('notif_tz', _tzName);
    return last != null && last != _tzName;
  }
}

/// One desired notification. Pure data → easy to diff.
class NotificationPlan {
  final int id;
  final String title;
  final String body;
  final DateTime when;
  final NotificationSound sound;
  final String? channelId;
  final DateTimeComponents? repeat;
  const NotificationPlan({
    required this.id,
    required this.title,
    required this.body,
    required this.when,
    required this.sound,
    this.channelId,
    this.repeat,
  });

  /// Repeating items are identified by clock time (their next date moves every day).
  String get fingerprint {
    final t = repeat != null
        ? 'r${when.hour}:${when.minute}'
        : '${when.millisecondsSinceEpoch}';
    return '$t|$title|$body|${sound.index}|${channelId ?? ''}';
  }

  bool get isPastOneShot => repeat == null && !when.isAfter(DateTime.now());
}
