import 'package:dio/dio.dart';
import 'package:final_l3/core/constants/string_constants.dart';
import 'package:final_l3/core/network/failure.dart';

class ErrorHandler {
  static Failure handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Failure(msg: StringConstants.connectionTimedOut);

      case DioExceptionType.connectionError:
        return Failure(msg: StringConstants.noInternetConnection);

      case DioExceptionType.badCertificate:
        return Failure(msg: StringConstants.invalid);

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
