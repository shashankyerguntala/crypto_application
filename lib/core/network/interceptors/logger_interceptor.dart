import 'dart:convert';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("⬆️ [REQUEST]");
    print("URL: ${options.method} ${options.uri}");

    if (options.headers.isNotEmpty) {
      print("Headers: ${jsonEncode(options.headers)}");
    }

    if (options.queryParameters.isNotEmpty) {
      print("Query: ${jsonEncode(options.queryParameters)}");
    }

    if (options.data != null) {
      print("Body: ${options.data}");
    }

    print("------------------------------------------");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("[RESPONSE]");
    print(
      "URL: ${response.requestOptions.method} ${response.requestOptions.uri}",
    );
    print("Status: ${response.statusCode}");
    print("Data: ${response.data}");
    print("------------------------------------------");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(" [ERROR]");
    print("URL: ${err.requestOptions.method} ${err.requestOptions.uri}");
    print("Status: ${err.response?.statusCode}");
    print("Message: ${err.message}");

    if (err.response?.data != null) {
      print("Error Body: ${err.response?.data}");
    }
    print("------------------------------------------");
    super.onError(err, handler);
  }
}
