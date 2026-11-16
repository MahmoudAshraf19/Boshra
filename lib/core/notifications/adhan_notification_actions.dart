import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../services/adhan_native_service.dart';

/// ID of the "Stop Adhan" button shown on the Adhan notification
/// (heads-up banner AND lock-screen notification).
const String kAdhanStopActionId = 'adhan_stop';

/// Runs when a notification (or one of its buttons) is used while the app is
/// ALIVE. Stopping the Adhan = dismissing its notification: Android stops the
/// notification's sound the moment the notification is cancelled.
Future<void> handleAdhanNotificationResponse(NotificationResponse response) async {
  if (response.actionId != kAdhanStopActionId) return;
  try {
    await AdhanNativeService.instance.stopAdhan();
  } catch (_) {}
  final id = response.id;
  if (id == null) return;
  try {
    await FlutterLocalNotificationsPlugin().cancel(id: id);
  } catch (_) {/* the native side already cancelled it (cancelNotification: true) */}
}

/// Runs in a BACKGROUND ISOLATE when the user taps "Stop Adhan" while the app is
/// closed / killed / the phone is locked. MUST be a top-level function.
@pragma('vm:entry-point')
void adhanNotificationBackgroundHandler(NotificationResponse response) {
  handleAdhanNotificationResponse(response);
}
