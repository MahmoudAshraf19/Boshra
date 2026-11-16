import 'dart:async';

import 'package:flutter/widgets.dart';

import '../services/adhan_native_service.dart';
import '../services/notification_service.dart';
import '../utils/app_logger.dart';

/// What the in-app Adhan banner shows.
class AdhanBannerData {
  final int notificationId;
  final String title;
  final String subtitle;
  final String? verse;
  final String stopLabel;
  final DateTime shownAt;
  const AdhanBannerData({
    required this.notificationId,
    required this.title,
    required this.subtitle,
    required this.stopLabel,
    required this.shownAt,
    this.verse,
  });
}

/// Drives the in-app Adhan banner (the one used while the app is OPEN).
///
/// When the app is closed or in the background the system notification (heads-up
/// banner / lock screen) is what the user sees – this class only adds the nicer,
/// fully custom banner on top of the app while it is in the foreground.
///
/// The sound itself always comes from the notification channel, so this banner
/// never plays audio. "Stop" simply cancels that notification.
class AdhanBannerController extends ValueNotifier<AdhanBannerData?> {
  AdhanBannerController._() : super(null);
  static final AdhanBannerController instance = AdhanBannerController._();

  static const _tag = 'AdhanBanner';
  static const _lateTolerance = Duration(minutes: 2);
  static const _maxVisible = Duration(minutes: 4);

  bool _attached = false;
  bool _seenActive = false;
  List<NotificationPlan> _plans = const [];
  Timer? _fireTimer;
  Timer? _watchTimer;
  Timer? _hideTimer;

  /// Called by the host widget: timers only exist while there is a UI to show them.
  void attach() {
    _attached = true;
    _arm();
  }

  void detach() {
    _attached = false;
    _fireTimer?.cancel();
    _fireTimer = null;
    dismiss();
  }

  /// Receives the full notification plan (after it was applied to the OS).
  void schedule(List<NotificationPlan> plans) {
    _plans = plans.where((p) => p.stopLabel != null && p.showBanner && p.repeat == null).toList()
      ..sort((a, b) => a.when.compareTo(b.when));
    _arm();
  }

  void _arm() {
    _fireTimer?.cancel();
    _fireTimer = null;
    if (!_attached) return;
    final now = DateTime.now();
    for (final p in _plans) {
      if (p.when.isAfter(now)) {
        _fireTimer = Timer(p.when.difference(now), () => _fire(p));
        return;
      }
    }
  }

  void _fire(NotificationPlan p) {
    final life = WidgetsBinding.instance.lifecycleState;
    final foreground = life == null || life == AppLifecycleState.resumed;
    final lateBy = DateTime.now().difference(p.when);
    if (foreground && lateBy < _lateTolerance) {
      show(AdhanBannerData(
        notificationId: p.id,
        title: p.title,
        subtitle: p.body,
        verse: p.verse,
        stopLabel: p.stopLabel!,
        shownAt: DateTime.now(),
      ));
    }
    _plans = _plans.where((x) => x.when.isAfter(p.when)).toList();
    _arm();
  }

  void show(AdhanBannerData data) {
    _hideTimer?.cancel();
    _watchTimer?.cancel();
    _seenActive = false;
    value = data;
    _hideTimer = Timer(_maxVisible, dismiss);
    // If the user stops the Adhan from the notification itself, hide the banner too.
    _watchTimer = Timer.periodic(const Duration(seconds: 2), (_) => _checkStillActive());
  }

  Future<void> _checkStillActive() async {
    final d = value;
    if (d == null) return;
    try {
      final active = await NotificationService().plugin.getActiveNotifications();
      if (value != d) return;
      final present = active.any((n) => n.id == d.notificationId);
      if (present) {
        _seenActive = true;
      } else if (_seenActive ||
          DateTime.now().difference(d.shownAt) > const Duration(seconds: 8)) {
        dismiss();
      }
    } catch (_) {/* not supported on this device → the 4-minute timeout hides it */}
  }

  /// Hides the banner only (the Adhan keeps playing).
  void dismiss() {
    _hideTimer?.cancel();
    _watchTimer?.cancel();
    _hideTimer = null;
    _watchTimer = null;
    if (value != null) value = null;
  }

  /// "Stop Adhan": stops native service & cancels notification.
  Future<void> stop() async {
    final d = value;
    dismiss();
    try {
      await AdhanNativeService.instance.stopAdhan();
    } catch (_) {}
    if (d == null) return;
    try {
      await NotificationService().plugin.cancel(id: d.notificationId);
    } catch (e, s) {
      AppLogger.e(_tag, e, s, 'stop failed');
    }
  }
}
