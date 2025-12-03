import 'dart:async';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxAttempts;
  final Duration baseDelay;

  RetryInterceptor({
    required this.dio,
    this.maxAttempts = 3,
    this.baseDelay = const Duration(milliseconds: 500),
  });

  bool retry(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout;
  }

  Future<void> delay(int attempt) async {
    int multiplier = 1;

    for (int i = 0; i < attempt; i++) {
      multiplier *= 2;
    }

    final duration = Duration(
      milliseconds: baseDelay.inMilliseconds * multiplier,
    );
    await Future.delayed(duration);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;

    if (!retry(err)) {
      return handler.next(err);
    }

    final attempt = (request.extra['attempt'] ?? 0) ;

    if (attempt >= maxAttempts) {
      return handler.next(err);
    }

    request.extra['attempt'] = attempt + 1;

    await delay(attempt);

    try {
      final result = await dio.fetch(request);
      return handler.resolve(result);
    } catch (e) {
      return handler.next(e as DioException);
    }
  }
}
