import 'dart:math';
import 'package:dio/dio.dart';
import '../utils/app_logger.dart';

/// Dio with sane defaults + automatic retry (exponential back-off) for
/// transient failures: timeouts, dropped connections and 5xx responses.
class DioFactory {
  DioFactory._();

  static Dio create({int maxRetries = 2}) {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 12),
      headers: {'Accept': 'application/json', 'User-Agent': 'Boshra/1.0 (Flutter)'},
    ));
    dio.interceptors.add(_RetryInterceptor(dio, maxRetries));
    return dio;
  }
}

class _RetryInterceptor extends Interceptor {
  final Dio _dio;
  final int _max;
  _RetryInterceptor(this._dio, this._max);

  bool _retryable(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final c = e.response?.statusCode ?? 0;
        return c >= 500 || c == 429;
      default:
        return false;
    }
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final attempt = (err.requestOptions.extra['retry_attempt'] as int?) ?? 0;
    if (attempt >= _max || !_retryable(err) || err.requestOptions.method != 'GET') {
      return handler.next(err);
    }
    final wait = Duration(milliseconds: 500 * pow(2, attempt).toInt());
    AppLogger.w('Net', 'retry ${attempt + 1}/$_max in ${wait.inMilliseconds}ms → ${err.requestOptions.uri}');
    await Future.delayed(wait);
    try {
      err.requestOptions.extra['retry_attempt'] = attempt + 1;
      final res = await _dio.fetch(err.requestOptions);
      handler.resolve(res);
    } on DioException catch (e) {
      handler.next(e);
    }
  }
}
