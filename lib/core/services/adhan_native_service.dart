import 'dart:convert';
import 'dart:io' show Platform;
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../navigation/app_navigator.dart';
import '../notifications/adhan_banner_controller.dart';
import '../utils/app_logger.dart';

/// One Adhan to be armed natively.
class AdhanAlarm {
  final int id;
  final DateTime when;
  final int slot; // prayer index 0..4
  final String title;
  final String body;
  final String rawSound;
  final String stopLabel;
  /// 'adhan' = full Adhan (foreground service) · 'alert' = normal / silent notification ·
  /// 'mode' = prayer-mode silence on/off (title 'on' | 'off', no notification).
  final String kind;
  final String channel;
  final String channelName;
  final bool silent;
  final bool largeIcon;
  /// Optional notification action payload ("prayed:2:2026-11-14"); its label is [stopLabel].
  final String act;
  /// In-app route opened when the notification is tapped, e.g. 'azkar:morning'.
  final String route;
  const AdhanAlarm({
    required this.id,
    required this.when,
    required this.slot,
    required this.title,
    required this.body,
    required this.rawSound,
    required this.stopLabel,
    this.kind = 'adhan',
    this.channel = '',
    this.channelName = '',
    this.silent = false,
    this.largeIcon = false,
    this.act = '',
    this.route = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'at': when.millisecondsSinceEpoch,
        'slot': slot,
        'title': title,
        'body': body,
        'raw': rawSound,
        'stop': stopLabel,
        'kind': kind,
        'ch': channel,
        'chName': channelName,
        'silent': silent,
        'large': largeIcon,
        'act': act,
        'route': route,
      };
}

/// Bridge to the native Adhan engine (AdhanReceiver + AdhanService).
///
/// IMPORTANT: scheduling/stopping uses BROADCAST INTENTS (android_intent_plus), not a
/// custom MethodChannel. A MethodChannel registered in MainActivity does not exist in the
/// WorkManager background engine, so the old background refresh silently failed to schedule
/// any Adhan. Broadcasts work from every isolate.
/// The MethodChannel below is kept only for native → Flutter events.
class AdhanNativeService {
  static const _tag = 'AdhanNativeService';
  static const _channel = MethodChannel('com.app.boshra/adhan');
  static const _pkg = 'com.app.boshra';
  static const _receiver = 'com.example.boshra.AdhanReceiver';
  static const _base = 'com.example.boshra.';

  static final AdhanNativeService instance = AdhanNativeService._();
  AdhanNativeService._() {
    if (!kIsWeb && Platform.isAndroid) {
      _channel.setMethodCallHandler(_handleNativeCall);
    }
  }

  Future<void> _handleNativeCall(MethodCall call) async {
    if (call.method == 'onAdhanStopped') {
      AdhanBannerController.instance.dismiss();
    } else if (call.method == 'onRoute') {
      // Notification tapped while the app is open.
      AppRoutes.handle(call.arguments?.toString() ?? '');
    }
  }

  /// Route of the notification that launched the app (cold start), or null. Read once.
  Future<String?> launchRoute() async {
    if (kIsWeb || !Platform.isAndroid) return null;
    try {
      return await _channel.invokeMethod<String>('getLaunchRoute');
    } catch (_) {
      return null;
    }
  }

  Future<bool> _broadcast(String action, Map<String, dynamic> args) async {
    if (kIsWeb || !Platform.isAndroid) return false;
    try {
      await AndroidIntent(
        action: '$_base$action',
        package: _pkg,
        componentName: _receiver,
        arguments: args,
      ).sendBroadcast();
      return true;
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'broadcast $action failed');
      return false;
    }
  }

  /// Makes the native Adhan set equal to [items] (idempotent).
  ///  * [replace] true  → every stored Adhan that is not in [items] is cancelled.
  ///  * [keepSlots]     → stored Adhans of a prayer NOT in this list are always cancelled
  ///                      (prayer disabled / switched to silent / short).
  Future<bool> sync(List<AdhanAlarm> items,
      {required bool replace,
      required List<int> keepSlots,
      String kind = 'adhan',
      List<int> cancelIds = const []}) {
    return _broadcast('ACTION_SYNC_ADHAN', {
      'plan': jsonEncode({
        'kind': kind,
        'cancel': cancelIds,
        'replace': replace,
        'keepSlots': keepSlots,
        'items': items.map((e) => e.toJson()).toList(),
      }),
    });
  }

  /// Plays the Adhan right now (test button).
  Future<bool> startAdhan({
    required int id,
    required String title,
    required String body,
    required String rawSound,
    required String stopLabel,
  }) {
    return _broadcast('ACTION_TRIGGER_ADHAN', {
      'extra_notification_id': id,
      'extra_title': title,
      'extra_body': body,
      'extra_raw_sound': rawSound,
      'extra_stop_label': stopLabel,
    });
  }

  /// Stops the Adhan (also removes its notification and the in-app banner).
  Future<bool> stopAdhan() async {
    final ok = await _broadcast('ACTION_STOP_ADHAN', {});
    AdhanBannerController.instance.dismiss();
    return ok;
  }

  Future<bool> isAdhanPlaying() async {
    if (kIsWeb || !Platform.isAndroid) return false;
    try {
      return (await _channel.invokeMethod<bool>('isAdhanPlaying')) ?? false;
    } catch (_) {
      return false;
    }
  }
}
