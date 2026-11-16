import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight, privacy-friendly event log + error capture.
///
///  * Every event is stored locally (last [_max]) → shown in the Diagnostics screen and
///    attachable to a support report ("why didn't the Adhan ring?" answered in seconds).
///  * [sink] is the single plug-in point for Firebase Analytics / Crashlytics (see
///    FIREBASE_SETUP_AR.md). Nothing leaves the phone unless you set it.
///  * No personal data is logged (no coordinates, no names).
class Telemetry {
  Telemetry._();

  static const _key = 'telemetry_events_v1';
  static const _max = 80;

  /// Set once in main() to forward events (e.g. FirebaseAnalytics.instance.logEvent).
  static void Function(String name, Map<String, Object?> params)? sink;

  /// Set once in main() to forward errors (e.g. FirebaseCrashlytics.instance.recordError).
  static void Function(Object error, StackTrace? stack, String tag)? errorSink;

  static Future<void> _queue = Future.value();
  static String? _lastErr;
  static DateTime _lastErrAt = DateTime.fromMillisecondsSinceEpoch(0);

  static Future<void> log(String name, [Map<String, Object?> params = const {}]) {
    try {
      sink?.call(name, params);
    } catch (_) {}
    final line = jsonEncode({
      't': DateTime.now().millisecondsSinceEpoch,
      'n': name,
      if (params.isNotEmpty) 'p': params.map((k, v) => MapEntry(k, v?.toString())),
    });
    _queue = _queue.then((_) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.reload();
        final list = prefs.getStringList(_key) ?? <String>[];
        list.add(line);
        await prefs.setStringList(_key, list.length > _max ? list.sublist(list.length - _max) : list);
      } catch (_) {}
    });
    return _queue;
  }

  /// Wired to AppLogger.onError. De-duplicates floods of the same error.
  static void recordError(Object error, StackTrace? stack, String tag) {
    final msg = '$tag:${error.toString()}';
    final now = DateTime.now();
    if (msg == _lastErr && now.difference(_lastErrAt) < const Duration(seconds: 10)) return;
    _lastErr = msg;
    _lastErrAt = now;
    try {
      errorSink?.call(error, stack, tag);
    } catch (_) {}
    final short = error.toString();
    log('error', {'tag': tag, 'msg': short.length > 100 ? short.substring(0, 100) : short});
  }

  static Future<List<TelemetryEvent>> recent({int limit = 40}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      final list = prefs.getStringList(_key) ?? const <String>[];
      final out = <TelemetryEvent>[];
      for (final l in list.reversed.take(limit)) {
        try {
          final j = jsonDecode(l) as Map<String, dynamic>;
          out.add(TelemetryEvent(
            DateTime.fromMillisecondsSinceEpoch(j['t'] as int),
            j['n'] as String,
            (j['p'] as Map?)?.map((k, v) => MapEntry(k.toString(), v.toString())) ?? const {},
          ));
        } catch (_) {}
      }
      return out;
    } catch (_) {
      return const [];
    }
  }
}

class TelemetryEvent {
  final DateTime at;
  final String name;
  final Map<String, String> params;
  const TelemetryEvent(this.at, this.name, this.params);

  @override
  String toString() =>
      '${at.toIso8601String()}  $name${params.isEmpty ? '' : '  ${params.entries.map((e) => '${e.key}=${e.value}').join(' ')}'}';
}
