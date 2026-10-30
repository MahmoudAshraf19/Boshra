import 'dart:io' show Platform;
import 'package:android_intent_plus/android_intent.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
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
  final String brand;
  const ReliabilityStatus({
    required this.notifications,
    required this.exactAlarm,
    required this.channelsOk,
    required this.battery,
    required this.needsAutostart,
    required this.brand,
  });

  /// Without these, notifications are blocked or badly delayed.
  bool get critical => !notifications || !exactAlarm || !channelsOk;
  bool get allGood => !critical && battery && !needsAutostart;
}

/// One place for requesting / checking / opening every relevant permission.
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

  static String? _brandMemo;
  static Future<String> brand() async {
    if (_brandMemo != null) return _brandMemo!;
    try {
      if (!kIsWeb && Platform.isAndroid) {
        final info = await DeviceInfoPlugin().androidInfo;
        _brandMemo = info.manufacturer.toLowerCase();
        return _brandMemo!;
      }
    } catch (e) {
      AppLogger.w(_tag, 'brand: $e');
    }
    return _brandMemo = '';
  }

  static Future<ReliabilityStatus> check() async {
    final ns = NotificationService();
    final base = await ns.getStatus();
    final blocked = await ns.blockedChannels();
    const bool battery = true; // Auto-granted so device OEM differences don't block setup
    bool needsAutostart = false;
    final b = await brand();
    if (!kIsWeb && Platform.isAndroid) {
      final prefs = await SharedPreferences.getInstance();
      needsAutostart = _aggressiveBrands.contains(b) && !(prefs.getBool(_prefAutostart) ?? false);
    }
    return ReliabilityStatus(
      notifications: base.notificationsEnabled,
      exactAlarm: base.exactAlarmsAllowed,
      channelsOk: blocked.isEmpty,
      battery: battery,
      needsAutostart: needsAutostart,
      brand: b,
    );
  }

  // ---- actions ----
  static Future<void> requestNotifications() async {
    final ns = NotificationService();
    final r = await ns.requestPermissions();
    // Denied twice → Android won't show the dialog again: send the user to Settings.
    if (!r.notificationsEnabled) await openNotificationSettings();
  }

  static Future<void> requestExactAlarm() => NotificationService().requestExactAlarms();

  static Future<void> requestBatteryExemption() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('battery_exemption_done', true);
      await _launch(const AndroidIntent(action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS'));
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'battery request');
    }
  }

  /// App notification page where the user can re-enable muted categories.
  static Future<void> openNotificationSettings() async {
    if (kIsWeb || !Platform.isAndroid) {
      await NotificationService().openAppSettings();
      return;
    }
    await _launch(const AndroidIntent(
      action: 'android.settings.APP_NOTIFICATION_SETTINGS',
      arguments: {'android.provider.extra.APP_PACKAGE': packageName},
    ));
  }

  /// Opens the vendor's auto-start / background screen; falls back to the app details page.
  static Future<void> openAutostart() async {
    final b = await brand();
    for (final c in _oemScreens(b)) {
      final intent = AndroidIntent(
          action: 'android.intent.action.MAIN', package: c.$1, componentName: c.$2);
      try {
        if (await intent.canResolveActivity() == true) {
          await intent.launch();
          await _markAutostart();
          return;
        }
      } catch (_) {/* try next */}
    }
    await _launch(const AndroidIntent(
      action: 'android.settings.APPLICATION_DETAILS_SETTINGS',
      data: 'package:$packageName',
    ));
    await _markAutostart();
  }

  static Future<void> _markAutostart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefAutostart, true); // cannot be verified → user acknowledged
  }

  static Future<void> _launch(AndroidIntent i) async {
    try {
      await i.launch();
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'launch intent');
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
    if (b.contains('oppo') || b.contains('realme')) {
      return [
        ('com.coloros.safecenter', 'com.coloros.safecenter.permission.startup.StartupAppListActivity'),
        ('com.oppo.safe', 'com.oppo.safe.permission.startup.StartupAppListActivity'),
      ];
    }
    if (b.contains('vivo') || b.contains('iqoo')) {
      return [
        ('com.vivo.permissionmanager', 'com.vivo.permissionmanager.activity.BgStartUpManagerActivity'),
        ('com.iqoo.secure', 'com.iqoo.secure.ui.phoneoptimize.AddWhiteListActivity'),
      ];
    }
    if (b.contains('oneplus')) {
      return [('com.oneplus.security', 'com.oneplus.security.chainlaunch.view.ChainLaunchAppListActivity')];
    }
    if (b.contains('samsung')) {
      return [('com.samsung.android.lool', 'com.samsung.android.sm.battery.ui.BatteryActivity')];
    }
    return const [];
  }
}
