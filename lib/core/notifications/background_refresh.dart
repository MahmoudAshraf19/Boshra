import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';
import '../services/notification_service.dart';
import '../utils/app_logger.dart';
import 'notification_coordinator.dart';

const String _taskName = 'boshra_notification_refresh';

/// Runs in a BACKGROUND ISOLATE (no UI, no BuildContext). Must be top-level.
@pragma('vm:entry-point')
void notificationRefreshDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await NotificationService().init();
      final ok = await NotificationCoordinator.instance
          .runInBackground()
          .timeout(const Duration(minutes: 3));
      return ok; // false → WorkManager retries with exponential back-off
    } catch (e, s) {
      AppLogger.e('BackgroundRefresh', e, s);
      return false;
    }
  });
}

/// Keeps the notification schedule alive even if the user never opens the app:
///  * every ~12 h the rolling 30-day window is topped up;
///  * after a reboot / app update WorkManager restores the job by itself;
///  * if an OEM "battery saver" dropped our alarms, they are re-created at the next run.
///
/// Limits (Android design, nothing can bypass them): after the user presses
/// "Force stop", ALL alarms and WorkManager jobs are cancelled until the app is opened once.
class BackgroundRefresh {
  BackgroundRefresh._();

  static Future<void> init() async {
    if (kIsWeb || !Platform.isAndroid) return; // iOS needs BGTaskScheduler setup in Xcode
    try {
      await Workmanager().initialize(notificationRefreshDispatcher);
      await Workmanager().registerPeriodicTask(
        _taskName,
        _taskName,
        frequency: const Duration(hours: 12),
        initialDelay: const Duration(minutes: 30),
        backoffPolicy: BackoffPolicy.exponential,
        backoffPolicyDelay: const Duration(minutes: 15),
      );
      AppLogger.d('BackgroundRefresh', 'periodic task registered');
    } catch (e, s) {
      AppLogger.e('BackgroundRefresh', e, s, 'init failed');
    }
  }
}
