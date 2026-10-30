import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../utils/app_logger.dart';

/// Kinds of failures the UI cares about.
enum AppErrorType { noInternet, timeout, server, notFound, cancelled, unknown }

class AppError implements Exception {
  final AppErrorType type;
  final Object? cause;
  const AppError(this.type, [this.cause]);

  /// Converts any thrown object to an [AppError].
  factory AppError.from(Object e) {
    if (e is AppError) return e;
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return AppError(AppErrorType.timeout, e);
        case DioExceptionType.connectionError:
          return AppError(AppErrorType.noInternet, e);
        case DioExceptionType.cancel:
          return AppError(AppErrorType.cancelled, e);
        case DioExceptionType.badResponse:
          return AppError(
              e.response?.statusCode == 404
                  ? AppErrorType.notFound
                  : AppErrorType.server,
              e);
        default:
          return e.error is SocketException
              ? AppError(AppErrorType.noInternet, e)
              : AppError(AppErrorType.unknown, e);
      }
    }
    if (e is SocketException) return AppError(AppErrorType.noInternet, e);
    if (e is TimeoutException) return AppError(AppErrorType.timeout, e);
    return AppError(AppErrorType.unknown, e);
  }

  String message(AppLocalizations l10n) {
    switch (type) {
      case AppErrorType.noInternet:
      case AppErrorType.timeout:
        return l10n.errorNoInternet;
      case AppErrorType.notFound:
      case AppErrorType.server:
        return l10n.errorLoadFailed;
      default:
        return l10n.errorGeneric;
    }
  }

  @override
  String toString() => 'AppError($type, $cause)';
}

/// Installs global handlers so that NO uncaught error can freeze or crash
/// the UI silently. Call [install] first thing in main().
class AppErrorHandler {
  AppErrorHandler._();

  static void install() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      AppLogger.e('FlutterError', details.exception, details.stack);
    };
    // Errors outside the Flutter framework (async, isolates, platform channels)
    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.e('PlatformDispatcher', error, stack);
      return true; // handled → do not kill the app
    };
    // A friendly widget instead of the red/grey error screen in release.
    ErrorWidget.builder = (details) {
      if (kDebugMode) return ErrorWidget(details.exception);
      return const _SafeErrorBox();
    };
  }
}

class _SafeErrorBox extends StatelessWidget {
  const _SafeErrorBox();
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

/// Consistent SnackBars / helpers for the whole app.
class AppFeedback {
  AppFeedback._();

  static void error(BuildContext context, Object e) {
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);
    final msg = l10n == null ? '' : AppError.from(e).message(l10n);
    _show(context, msg, isError: true);
  }

  static void message(BuildContext context, String text, {bool isError = false}) {
    if (!context.mounted) return;
    _show(context, text, isError: isError);
  }

  static void _show(BuildContext context, String text, {required bool isError}) {
    final cs = Theme.of(context).colorScheme;
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.hideCurrentSnackBar();
    messenger?.showSnackBar(SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? cs.error : cs.primary,
    ));
  }
}

/// Small reusable "error + retry" view for any screen that loads data.
class ErrorRetryView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ErrorRetryView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.cloud_off_rounded, size: 48, color: cs.onSurfaceVariant),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: Text(l10n.retry),
          ),
        ]),
      ),
    );
  }
}
