import 'package:dio/dio.dart';
import 'package:final_l3/core/network/failure.dart';

class ErrorHandler {
  static Failure handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Failure(msg: "Connection timed out");

      case DioExceptionType.connectionError:
        return Failure(msg: "No Internet Connection");

      case DioExceptionType.badCertificate:
        return Failure(msg: "Invalid SSL certificate");

      case DioExceptionType.cancel:
        return Failure(msg: "Request was cancelled");

      case DioExceptionType.badResponse:
        return badResponse(e);

      case DioExceptionType.unknown:
        return Failure(msg: 'unexpected !');
    }
  }

  static Failure badResponse(DioException e) {
    final status = e.response?.statusCode ?? 0;
    final message =
        e.response?.data?['message']?.toString() ??
        e.response?.statusMessage ??
        "Unexpected error";

    if (status >= 400 && status < 500) {
      return ClientFailure(msg: message);
    } else if (status >= 500 && status < 600) {
      return ServerFailure(msg: message);
    } else {
      return Failure(msg: message);
    }
  }
}
