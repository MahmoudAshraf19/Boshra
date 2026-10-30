import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

/// Central logger. Replaces scattered `print()` calls.
/// - Debug/profile: prints to console with a tag.
/// - Release: silent on console, but the hook [onError] lets you forward
///   errors to Crashlytics / Sentry later with one line.
class AppLogger {
  AppLogger._();

  /// Set this once (e.g. in main) to forward errors to a crash reporter.
  static void Function(Object error, StackTrace? stack, String tag)? onError;

  static void d(String tag, String message) {
    if (kReleaseMode) return;
    dev.log(message, name: tag);
    debugPrint('[$tag] $message');
  }

  static void w(String tag, String message) {
    if (kReleaseMode) return;
    dev.log('⚠️ $message', name: tag, level: 900);
    debugPrint('[$tag] ⚠️ $message');
  }

  static void e(String tag, Object error, [StackTrace? stack, String? message]) {
    if (!kReleaseMode) {
      dev.log(message ?? error.toString(),
          name: tag, error: error, stackTrace: stack, level: 1000);
      debugPrint('[$tag] ❌ ${message ?? ''} $error');
    }
    try {
      onError?.call(error, stack, tag);
    } catch (_) {}
  }
}

/// Drop-in replacement for `print()`: silent in release builds.
void appLog(Object? message) {
  if (!kReleaseMode) debugPrint('$message');
}
