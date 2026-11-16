import 'dart:io' show Platform;
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/location_service.dart';
import '../services/telemetry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/notification_service.dart';
import '../utils/app_logger.dart';

/// Everything that decides whether notifications really arrive.
class ReliabilityStatus {
  final bool notifications;
  final bool exactAlarm;
  final bool channelsOk;
  final bool battery; // true = app is exempt from battery optimisation
  final bool needsAutostart; // OEM brand that kills background apps & not yet handled
  final bool autostartApplicable; // OEM brand that has an auto-start switch at all
  /// Location permission + GPS on, OR the user chose a city manually (both give correct times).
  final bool location;
  final String brand;
  const ReliabilityStatus({
    required this.notifications,
    required this.exactAlarm,
    required this.channelsOk,
    required this.battery,
    required this.needsAutostart,
    required this.brand,
    this.autostartApplicable = false,
    this.location = true,
  });

  /// Without these, notifications are blocked or badly delayed.
  bool get critical => !notifications || !exactAlarm || !channelsOk;
  bool get allGood => !critical && location && battery && !needsAutostart;
}

/// One place for requesting / checking / opening every relevant permission.
///
/// Every request:
///  * asks the OS directly (system dialog) whenever Android allows it,
///  * falls back to the exact Settings page only when a dialog is impossible,
///  * invalidates the status cache so the UI shows the REAL state on return.
class PermissionCenter {
  PermissionCenter._();
  static const _tag = 'PermissionCenter';
  static const packageName = 'com.app.boshra'; // = applicationId

  static const _prefAutostart = 'oem_autostart_done';

  /// Brands whose system kills background apps / blocks auto-start.
  static const _aggressiveBrands = {
    'xiaomi', 'redmi', 'poco', 'huawei', 'honor', 'oppo', 'realme', 'oneplus',
    'vivo', 'iqoo', 'samsung', 'tecno', 'infinix', 'itel', 'meizu', 'asus', 'lenovo',
  };

  static bool get _android => !kIsWeb && Platform.isAndroid;

  static String? _brandMemo;
  static Future<String> brand() async {
    if (_brandMemo != null) return _brandMemo!;
    try {
      if (_android) {
        final info = await DeviceInfoPlugin().androidInfo;
        _brandMemo = info.manufacturer.toLowerCase();
        return _brandMemo!;
      }
    } catch (e) {
      AppLogger.w(_tag, 'brand: $e');
    }
    return _brandMemo = '';
  }

  static ReliabilityStatus? cachedStatus;
  static DateTime? _cachedStatusTime;

  /// Drops the cached status (call after any permission action).
  static void invalidate() {
    cachedStatus = null;
    _cachedStatusTime = null;
  }

  static Future<ReliabilityStatus> check({bool force = false}) async {
    if (!force && cachedStatus != null && _cachedStatusTime != null) {
      if (DateTime.now().difference(_cachedStatusTime!) < const Duration(seconds: 60)) {
        return cachedStatus!;
      }
    }
    final ns = NotificationService();
    final base = await ns.getStatus();
    final blocked = await ns.blockedChannels();

    bool notifications = base.notificationsEnabled;
    final bool exact = base.exactAlarmsAllowed;
    bool battery = true;
    bool needsAutostart = false;
    final b = await brand();
    bool location = true;
    try {
      final svc = LocationService();
      if (!await svc.isManual()) {
        final st = await svc.status();
        location = st.serviceOn &&
            (st.permission == LocationPermission.whileInUse || st.permission == LocationPermission.always);
      }
    } catch (_) {}

    if (_android) {
      try {
        notifications = notifications && await Permission.notification.isGranted;
      } catch (_) {}
      try {
        battery = await Permission.ignoreBatteryOptimizations.isGranted;
      } catch (_) {}
      final prefs = await SharedPreferences.getInstance();
      needsAutostart =
          _aggressiveBrands.contains(b) && !(prefs.getBool(_prefAutostart) ?? false);
    }

    final res = ReliabilityStatus(
      notifications: notifications,
      exactAlarm: exact,
      channelsOk: blocked.isEmpty,
      battery: battery,
      needsAutostart: needsAutostart,
      autostartApplicable: _android && _aggressiveBrands.contains(b),
      brand: b,
      location: location,
    );
    cachedStatus = res;
    _cachedStatusTime = DateTime.now();
    return res;
  }

  // ---- actions ----

  /// System dialog first; if Android refuses to show it (denied twice) → app
  /// notification settings.
  static Future<void> requestNotifications() async {
    invalidate();
    try {
      if (_android) {
        var st = await Permission.notification.status;
        if (st.isGranted) {
          // Permission granted but notifications switched off in Settings.
          if (!(await NotificationService().getStatus()).notificationsEnabled) {
            await openNotificationSettings();
          }
          return;
        }
        st = await Permission.notification.request();
        if (!st.isGranted) await openNotificationSettings();
        return;
      }
      await NotificationService().requestPermissions();
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'requestNotifications');
      await openNotificationSettings();
    }
  }

  /// Opens the "Alarms & reminders" page for THIS app (Android 12+).
  static Future<void> requestExactAlarm() async {
    invalidate();
    try {
      if (_android) {
        final st = await Permission.scheduleExactAlarm.status;
        if (st.isGranted) return;
        await Permission.scheduleExactAlarm.request();
        return;
      }
    } catch (e) {
      AppLogger.w(_tag, 'scheduleExactAlarm: $e');
    }
    await NotificationService().requestExactAlarms();
  }

  /// Logs the current permission state (Telemetry) after the user acted on something.
  static Future<ReliabilityStatus> logState(String where) async {
    final st = await check(force: true);
    Telemetry.log('perm_state', {
      'at': where,
      'notif': st.notifications,
      'exact': st.exactAlarm,
      'channels': st.channelsOk,
      'battery': st.battery,
      'location': st.location,
      'brand': st.brand,
    });
    return st;
  }

  /// Location: system dialog → app settings (denied forever) → GPS switch (service off).
  static Future<void> requestLocation() async {
    invalidate();
    try {
      final svc = LocationService();
      await svc.clearManualCity();
      final st = await svc.status();
      if (!st.serviceOn) {
        await Geolocator.openLocationSettings();
        return;
      }
      if (st.permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        return;
      }
      if (st.permission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      }
      await svc.resolve(requestPermission: false); // saves a first fix for background refresh
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'requestLocation');
    }
  }

  /// Shows the system dialog "Allow app to always run in background?" — one tap.
  static Future<void> requestBatteryExemption() async {
    invalidate();
    if (!_android) return;
    try {
      final st = await Permission.ignoreBatteryOptimizations.request();
      if (st.isGranted) return;
    } catch (e) {
      AppLogger.w(_tag, 'battery dialog: $e');
    }
    // Dialog not available on this ROM → the battery optimisation list.
    await _launch(const AndroidIntent(
      action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    ));
  }

  /// App notification page where the user can re-enable muted categories.
  static Future<void> openNotificationSettings() async {
    invalidate();
    if (!_android) {
      await NotificationService().openAppSettings();
      return;
    }
    final ok = await _launch(const AndroidIntent(
      action: 'android.settings.APP_NOTIFICATION_SETTINGS',
      arguments: {
        'android.provider.extra.APP_PACKAGE': packageName,
        'app_package': packageName, // Android 5-7
      },
      flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
    ));
    if (!ok) await openAppSettings();
  }

  /// Opens the vendor's auto-start / background screen (falls back to the app
  /// details page, where ColorOS / OneUI keep the "auto launch" switch).
  ///
  /// Android offers NO API to read the auto-start switch, so when the user goes
  /// to that screen and comes back the step is recorded as done.
  static Future<void> openAutostart() async {
    invalidate();
    final b = await brand();
    bool opened = false;
    for (final c in _oemScreens(b)) {
      final intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        package: c.$1,
        componentName: c.$2,
        flags: const [Flag.FLAG_ACTIVITY_NEW_TASK],
      );
      try {
        if (await intent.canResolveActivity() == true) {
          await intent.launch();
          opened = true;
          break;
        }
      } catch (_) {/* not exported on this ROM version → try next */}
    }
    if (!opened) {
      opened = await _launch(const AndroidIntent(
        action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
        data: 'package:$packageName',
        flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
      ));
    }
    if (opened) await markAutostartDone();
  }

  static Future<void> markAutostartDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefAutostart, true);
    invalidate();
  }

  static Future<bool> _launch(AndroidIntent i) async {
    try {
      await i.launch();
      return true;
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'launch intent');
      return false;
    }
  }

  static List<(String, String)> _oemScreens(String b) {
    if (b.contains('xiaomi') || b.contains('redmi') || b.contains('poco')) {
      return [('com.miui.securitycenter', 'com.miui.permcenter.autostart.AutoStartManagementActivity')];
    }
    if (b.contains('huawei') || b.contains('honor')) {
      return [
        ('com.huawei.systemmanager', 'com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity'),
        ('com.huawei.systemmanager', 'com.huawei.systemmanager.optimize.process.ProtectActivity'),
      ];
    }
    if (b.contains('oppo') || b.contains('realme') || b.contains('oneplus')) {
      return [
        // ColorOS 12 / 13 / 14
        ('com.oplus.safecenter', 'com.oplus.safecenter.startupapp.StartupAppListActivity'),
        ('com.coloros.safecenter', 'com.coloros.safecenter.startupapp.StartupAppListActivity'),
        // ColorOS 3 – 11
        ('com.coloros.safecenter', 'com.coloros.safecenter.permission.startup.StartupAppListActivity'),
        ('com.oppo.safe', 'com.oppo.safe.permission.startup.StartupAppListActivity'),
        // OxygenOS (old)
        ('com.oneplus.security', 'com.oneplus.security.chainlaunch.view.ChainLaunchAppListActivity'),
      ];
    }
    if (b.contains('vivo') || b.contains('iqoo')) {
      return [
        ('com.vivo.permissionmanager', 'com.vivo.permissionmanager.activity.BgStartUpManagerActivity'),
        ('com.iqoo.secure', 'com.iqoo.secure.ui.phoneoptimize.AddWhiteListActivity'),
      ];
    }
    if (b.contains('samsung')) {
      return [('com.samsung.android.lool', 'com.samsung.android.sm.battery.ui.BatteryActivity')];
    }
    return const [];
  }
}
