import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_l3/core/enums/http_methods.dart';
import 'package:final_l3/core/network/error_handler.dart';
import 'package:final_l3/core/network/failure.dart';
import 'package:final_l3/core/network/logger_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient({required String baseUrl})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: Duration(seconds: 15),
          receiveTimeout: Duration(seconds: 15),
          sendTimeout: Duration(seconds: 15),
          responseType: ResponseType.json,
        ),
      ) {
    dio.interceptors.add(LoggerInterceptor());
  }

  Future<Either<Failure, T>> request<T>(
    HttpMethods method,
    String endpoint, {
    required T Function(dynamic) parser,
    Map<String, dynamic>? queryParams,
    data,
  }) async {
    final Response<dynamic> response;
    try {
      switch (method) {
        case HttpMethods.get:
          response = await dio.get(endpoint, queryParameters: queryParams);

          break;
        case HttpMethods.post:
          response = await dio.post(
            endpoint,
            queryParameters: queryParams,
            data: data,
          );
          break;
        case HttpMethods.put:
          response = await dio.put(
            endpoint,
            queryParameters: queryParams,
            data: data,
          );
          break;
        case HttpMethods.patch:
          response = await dio.patch(
            endpoint,
            queryParameters: queryParams,
            data: data,
          );
          break;

        case HttpMethods.delete:
          response = await dio.delete(endpoint, queryParameters: queryParams);
          break;
      }
      return Right(parser(response.data));
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
