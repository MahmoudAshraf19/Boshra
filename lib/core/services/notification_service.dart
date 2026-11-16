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

import '../constants/adhan_reciters.dart';
import '../notifications/adhan_notification_actions.dart';
import '../notifications/notification_ids.dart';
import '../utils/app_logger.dart';
import 'adhan_native_service.dart';

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

  /// Accent colour of the notification (olive green – app brand).
  static const _brandColor = Color(0xFF606C38);
  /// res/drawable/ic_stat_adhan.xml – monochrome crescent for the status bar.
  static const _smallIcon = 'ic_stat_adhan';
  /// res/drawable-nodpi/adhan_large_icon.png – gold crescent medallion.
  static const _largeIcon = 'adhan_large_icon';

  // Channel IDs are versioned: Android freezes sound/importance after creation.
  static const _chShort = 'prayer_short_channel_v4';
  static const _chSilent = 'prayer_silent_channel_v5'; // v5: vibration off
  static const _chAzkar = 'daily_azkar_channel_v4';
  static const _chQuran = 'quran_messages_channel_v4';
  static const _chFriday = 'friday_jumuah_channel_v1';

  /// Channels the app really uses (for health checks).
  static final managedChannelIds = [
    for (final r in AdhanReciters.all) r.channelId,
    _chShort, _chSilent, _chAzkar, _chQuran, _chFriday,
  ];

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
    if (_initialized) return;
    try {
      tzdata.initializeTimeZones();
      await _configureLocalTimeZone();
      if (kIsWeb) {
        _initialized = true;
        AppLogger.d(_tag, 'initialized web (tz=$_tzName)');
        return;
      }

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const darwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      await plugin.initialize(
        settings: const InitializationSettings(
            android: android, iOS: darwin, macOS: darwin),
        // "Stop Adhan" button: works with the app open, closed or the phone locked.
        onDidReceiveNotificationResponse: handleAdhanNotificationResponse,
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
    const beep = RawResourceAndroidNotificationSound('notification');
    final channels = <AndroidNotificationChannel>[
      // One channel per Muadhin: Android freezes a channel's sound after creation.
      for (final r in AdhanReciters.all)
        AndroidNotificationChannel(r.channelId, 'Adhan – ${r.nameEn}',
            description: 'Full Adhan at prayer time',
            importance: Importance.max,
            sound: RawResourceAndroidNotificationSound(r.rawName),
            audioAttributesUsage: AudioAttributesUsage.alarm),
      const AndroidNotificationChannel(_chShort, 'Prayer alerts',
          description: 'Short alert for prayers and pre-prayer reminders',
          importance: Importance.max,
          sound: beep),
      const AndroidNotificationChannel(_chSilent, 'Silent prayer alerts',
          description: 'Prayer alerts without sound',
          importance: Importance.high,
          playSound: false,
          enableVibration: false),
      const AndroidNotificationChannel(_chAzkar, 'Daily Azkar',
          description: 'Morning and evening Azkar reminders',
          importance: Importance.high,
          sound: beep),
      const AndroidNotificationChannel(_chFriday, 'Friday – Salawat & Al-Kahf',
          description: 'Friday reminders: blessings upon the Prophet and Surat Al-Kahf',
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound('friday_chime')),
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
    if (kIsWeb) return;
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
      {String body = '',
      String? channelName,
      AdhanReciter? reciter,
      String? stopLabel,
      String? verse,
      bool islamicStyle = false}) {
    final bool adhan = sound == NotificationSound.adhan;
    final r = reciter ?? AdhanReciters.byId(AdhanReciters.defaultId);
    final bool silent = sound == NotificationSound.silent;
    final bigText = (verse == null || verse.isEmpty) ? body : '$body\n$verse';
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName ?? channelId,
        importance: silent ? Importance.high : Importance.max, // max = heads-up banner
        priority: Priority.high,
        playSound: !silent,
        enableVibration: !silent,
        sound: silent
            ? null
            : RawResourceAndroidNotificationSound(adhan
                ? r.rawName
                : (channelId == _chFriday ? 'friday_chime' : 'notification')),
        audioAttributesUsage:
            adhan ? AudioAttributesUsage.alarm : AudioAttributesUsage.notification,
        category: AndroidNotificationCategory.reminder,
        visibility: NotificationVisibility.public, // readable + usable on the lock screen
        icon: _smallIcon,
        color: _brandColor,
        largeIcon: islamicStyle ? const DrawableResourceAndroidBitmap(_largeIcon) : null,
        styleInformation: BigTextStyleInformation(bigText),
        autoCancel: !adhan,
        ongoing: adhan,
        timeoutAfter: adhan ? 240000 : null,
        // Runs WITHOUT opening the app: cancels the notification → Android stops the sound.
        actions: stopLabel == null
            ? null
            : <AndroidNotificationAction>[
                AndroidNotificationAction(
                  kAdhanStopActionId,
                  stopLabel,
                  showsUserInterface: false,
                  cancelNotification: true,
                ),
              ],
      ),
      iOS: DarwinNotificationDetails(
        presentSound: !silent,
        sound: silent ? null : (adhan ? r.iosSound : 'notification.mp3'),
        interruptionLevel:
            adhan ? InterruptionLevel.timeSensitive : InterruptionLevel.active,
      ),
    );
  }

  String channelFor(NotificationSound s, {String? adhanId}) {
    switch (s) {
      case NotificationSound.adhan:
        return AdhanReciters.byId(adhanId).channelId;
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
    String? adhanId,
    DateTimeComponents? repeat,
    String? stopLabel,
    String? verse,
    bool islamicStyle = false,
  }) async {
    if (kIsWeb || !_initialized) return false;
    final scheduled = tz.TZDateTime.from(when, tz.local);
    if (repeat == null && scheduled.isBefore(tz.TZDateTime.now(tz.local))) {
      return false;
    }
    final reciter = AdhanReciters.byId(adhanId);
    // On Android the full Adhan is owned by the native engine (see applyPlan) — never
    // schedule it here too, or it would play twice.
    if (!kIsWeb && Platform.isAndroid && sound == NotificationSound.adhan) return false;

    final details = _details(
        sound == NotificationSound.silent
            ? _chSilent
            : (channelId ?? channelFor(sound, adhanId: adhanId)),
        sound,
        body: body,
        reciter: reciter,
        stopLabel: stopLabel,
        verse: verse,
        islamicStyle: islamicStyle);
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

  /// Displays a notification immediately (e.g. for testing or instant alerts).
  Future<bool> showNow({
    required int id,
    required String title,
    required String body,
    required NotificationSound sound,
    String? channelId,
    String? adhanId,
    String? stopLabel,
    String? verse,
    bool islamicStyle = false,
  }) async {
    if (kIsWeb || !_initialized) return false;
    final reciter = AdhanReciters.byId(adhanId);
    if (!kIsWeb && Platform.isAndroid && sound == NotificationSound.adhan && stopLabel != null) {
      try {
        await plugin.cancel(id: id);
      } catch (_) {}
      return AdhanNativeService.instance.startAdhan(
        id: id,
        title: title,
        body: body,
        rawSound: reciter.rawName,
        stopLabel: stopLabel,
      );
    }
    final details = _details(
      sound == NotificationSound.silent
          ? _chSilent
          : (channelId ?? channelFor(sound, adhanId: adhanId)),
      sound,
      body: body,
      reciter: reciter,
      stopLabel: stopLabel,
      verse: verse,
      islamicStyle: islamicStyle,
    );
    try {
      await plugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: details,
      );
      return true;
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'showNow failed id=$id');
      return false;
    }
  }

  /// Cancels one notification everywhere: pending native alarm + the one already showing.
  Future<void> cancelId(int id) async {
    if (kIsWeb || !_initialized) return;
    try {
      if (!kIsWeb && Platform.isAndroid) {
        await AdhanNativeService.instance
            .sync(const [], replace: false, keepSlots: const [], kind: 'alert', cancelIds: [id]);
      }
      await plugin.cancel(id: id);
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'cancelId $id');
    }
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
  static const _planKey = 'notif_plan_v3';
  static const _schemaKey = 'notif_schema';
  static const _schema = 5; // 5: all Android notifications are scheduled natively

  /// One-time clean slate after an app update that changed ids/channels/architecture.
  /// Without it, notifications created by older versions (other ids) stay forever next to
  /// the new ones → duplicates and "mess" right after every update.
  Future<void> _migrateIfNeeded(SharedPreferences prefs) async {
    if ((prefs.getInt(_schemaKey) ?? 0) >= _schema) return;
    try {
      await plugin.cancelAll();
      await AdhanNativeService.instance
          .sync(const [], replace: true, keepSlots: const []);
      await prefs.remove(_planKey);
      await prefs.setInt(_schemaKey, _schema);
      AppLogger.d(_tag, 'migrated to schema $_schema');
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'migration');
    }
  }

  /// Makes the OS match [plans] with the MINIMUM of changes.
  ///
  /// ANDROID: every notification (Adhan AND normal/silent alerts) is scheduled by the
  /// native engine (AdhanReceiver). The plugin's own scheduler is NOT used, because its
  /// boot receiver re-fires every overdue notification right after a reboot / update
  /// (the "lots of notifications in a row when the phone starts" bug). The native engine
  /// re-arms only FUTURE items after a reboot and drops overdue ones.
  ///
  /// [cancelStalePrayers] false = the prayer plan is incomplete (offline) → never delete
  /// future prayers just because their times could not be re-fetched. Even then, anything
  /// the USER disabled ([enabledSlots]/[preEnabled]/[adhanSlots]) is removed.
  Future<void> applyPlan(
    List<NotificationPlan> plans, {
    bool cancelStalePrayers = true,
    List<int> enabledSlots = const [0, 1, 2, 3, 4],
    List<int> adhanSlots = const [],
    bool preEnabled = true,
  }) {
    return synchronized(() async {
      if (kIsWeb || !_initialized) return;
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.reload(); // the background isolate writes here too
        await _migrateIfNeeded(prefs);
        Map<String, dynamic> stored = {};
        try {
          stored = (jsonDecode(prefs.getString(_planKey) ?? '{}') as Map).cast<String, dynamic>();
        } catch (_) {}

        final wanted = plans.map((p) => p.id).toSet();
        bool isStale(int id) {
          if (wanted.contains(id)) return false;
          if (NotificationIds.isPrayer(id)) {
            final disabled = !enabledSlots.contains(NotificationIds.prayerSlot(id)) ||
                (NotificationIds.isPrePrayer(id) && !preEnabled);
            return cancelStalePrayers || disabled;
          }
          return NotificationIds.isQuran(id) ||
              NotificationIds.isAzkar(id) ||
              NotificationIds.isFriday(id) ||
              NotificationIds.isIqama(id) ||
              NotificationIds.isNudge(id) ||
              NotificationIds.isMode(id) ||
              NotificationIds.isZakat(id) ||
              NotificationIds.isSleep(id) ||
              NotificationIds.isWeekly(id) ||
              NotificationIds.legacy.contains(id);
        }

        final pending = (await plugin.pendingNotificationRequests()).map((p) => p.id).toSet();
        final result = <String, String>{};
        int scheduled = 0, kept = 0, failed = 0;

        if (!kIsWeb && Platform.isAndroid) {
          final adhan = <AdhanAlarm>[];
          final alerts = <AdhanAlarm>[];
          final modes = <AdhanAlarm>[];
          for (final p in plans) {
            if (p.kind == 'mode') {
              modes.add(AdhanAlarm(
                id: p.id,
                when: p.when,
                slot: -1,
                title: p.title, // 'on' | 'off'
                body: '',
                rawSound: '',
                stopLabel: '',
                kind: 'mode',
              ));
            } else if (p.sound == NotificationSound.adhan) {
              adhan.add(AdhanAlarm(
                id: p.id,
                when: p.when,
                slot: NotificationIds.prayerSlot(p.id),
                title: p.title,
                body: p.body,
                rawSound: AdhanReciters.byId(p.adhanId).rawName,
                stopLabel: p.stopLabel ?? 'Stop',
                route: p.route ?? '',
              ));
            } else {
              final silent = p.sound == NotificationSound.silent;
              final ch = silent ? _chSilent : (p.channelId ?? _chShort);
              alerts.add(AdhanAlarm(
                id: p.id,
                when: p.when,
                slot: -1,
                title: p.title,
                body: p.body,
                rawSound: '',
                kind: 'alert',
                channel: ch,
                channelName: ch,
                silent: silent,
                largeIcon: p.islamicStyle,
                stopLabel: p.actionLabel ?? '',
                act: p.actionPayload ?? '',
                route: p.route ?? '',
              ));
            }
          }
          // ids we scheduled earlier that are no longer wanted
          final stale = <int>{
            for (final k in stored.keys)
              if (int.tryParse(k) != null && isStale(int.parse(k))) int.parse(k)
          };
          final ok1 = await AdhanNativeService.instance.sync(adhan,
              replace: cancelStalePrayers, keepSlots: adhanSlots, cancelIds: stale.toList());
          final ok2 = await AdhanNativeService.instance.sync(alerts,
              replace: false, keepSlots: const [], kind: 'alert', cancelIds: stale.toList());
          final ok3 = await AdhanNativeService.instance.sync(modes,
              replace: false, keepSlots: const [], kind: 'mode', cancelIds: stale.toList());
          for (final p in plans) {
            final ok = p.kind == 'mode' ? ok3 : (p.sound == NotificationSound.adhan ? ok1 : ok2);
            if (ok) {
              result['${p.id}'] = p.fingerprint;
              scheduled++;
            } else {
              failed++;
            }
          }
          // Anything the plugin still holds from older versions must go (it would fire late).
          for (final id in pending) {
            if (NotificationIds.isManaged(id)) await plugin.cancel(id: id);
          }
        } else {
          // iOS: the plugin schedules (rolling window, see PrayerSchedulerService).
          final mode = await _scheduleMode();
          final exact = mode == AndroidScheduleMode.exactAllowWhileIdle;
          for (final p in plans) {
            if (p.kind == 'mode') continue; // no auto-silence on iOS
            final h = '${p.fingerprint}|$_tzName|$exact';
            if (pending.contains(p.id) && stored['${p.id}'] == h) {
              result['${p.id}'] = h;
              kept++;
              continue;
            }
            final ok = await scheduleAt(
              id: p.id, title: p.title, body: p.body, when: p.when,
              sound: p.sound, channelId: p.channelId, adhanId: p.adhanId, repeat: p.repeat,
              stopLabel: p.stopLabel, verse: p.verse, islamicStyle: p.islamicStyle,
            );
            if (ok) {
              result['${p.id}'] = h;
              scheduled++;
            } else if (!p.isPastOneShot) {
              failed++;
            }
          }
          for (final id in pending) {
            if (isStale(id)) await plugin.cancel(id: id);
          }
        }

        await prefs.setString(_planKey, jsonEncode(result));
        AppLogger.d(_tag, 'plan applied: new=$scheduled kept=$kept failed=$failed tz=$_tzName');
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
  /// Which Muadhin plays (only meaningful when [sound] is adhan).
  final String? adhanId;
  final DateTimeComponents? repeat;
  /// Non-null → the notification gets a "Stop Adhan" button with this label.
  final String? stopLabel;
  /// Optional verse shown in the expanded notification (and in the in-app banner).
  final String? verse;
  /// Gold crescent large icon (prayer notifications).
  final bool islamicStyle;
  /// Show the in-app Adhan banner while the app is open.
  final bool showBanner;
  /// 'alert' (default notification) | 'mode' (prayer-mode silence ON/OFF; [title] = 'on'|'off').
  final String kind;
  /// Optional notification button (Android): label + payload, e.g. 'prayed:2:2026-11-14'.
  final String? actionLabel;
  final String? actionPayload;
  /// In-app route opened when the notification is tapped (Android), e.g. 'azkar:morning'.
  final String? route;
  const NotificationPlan({
    required this.id,
    required this.title,
    required this.body,
    required this.when,
    required this.sound,
    this.channelId,
    this.adhanId,
    this.repeat,
    this.stopLabel,
    this.verse,
    this.islamicStyle = false,
    this.showBanner = false,
    this.kind = 'alert',
    this.actionLabel,
    this.actionPayload,
    this.route,
  });

  /// Repeating items are identified by clock time (their next date moves every day).
  String get fingerprint {
    final t = repeat != null
        ? 'r${when.hour}:${when.minute}'
        : '${when.millisecondsSinceEpoch}';
    return '$t|$title|$body|${sound.index}|${channelId ?? ''}|${sound == NotificationSound.adhan ? (adhanId ?? '') : ''}|${stopLabel ?? ''}|${verse ?? ''}|$islamicStyle|$kind|${actionLabel ?? ''}|${actionPayload ?? ''}|${route ?? ''}';
  }

  bool get isPastOneShot => repeat == null && !when.isAfter(DateTime.now());
}
