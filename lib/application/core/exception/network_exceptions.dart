import 'package:dio/dio.dart';

import 'app_exception.dart';

extension NetworkException on Object {
  ServerException errorToServerException() {

    final error = this;

    if (error is DioException) {
      return error.dioToServerException();
    }

    return ServerException(
      type: ServerExceptionType.unknown,
      message: error.toString(),
    );
  }
}

extension _DioErrorExtension on DioException {
  ServerException dioToServerException() {
    final statusCode = response?.statusCode;
    final message = response?.statusMessage;
    final data = response?.data;

    return switch (type) {
      DioExceptionType.badResponse => switch (statusCode) {
          400 => ServerException(
              type: ServerExceptionType.general,
              message: message,
              data: data,
              code: statusCode,
            ),
          401 => ServerException(
              type: ServerExceptionType.unauthorized,
              message: message,
              code: statusCode,
              data: data,
            ),
          403 => ServerException(
              type: ServerExceptionType.forbidden,
              message: message,
              data: data,
              code: statusCode,
            ),
          404 || 405 || 501 => ServerException(
              type: ServerExceptionType.notFound,
              message: message,
              data: data,
              code: statusCode,
            ),
          409 => ServerException(
              type: ServerExceptionType.conflict,
              message: message,
              code: statusCode,
              data: data,
            ),
          500 || 502 => ServerException(
              type: ServerExceptionType.internal,
              message: message,
              data: data,
              code: statusCode,
            ),
          503 => ServerException(
              type: ServerExceptionType.serviceUnavailable,
              message: message,
              code: statusCode,
              data: data,
            ),
          _ => ServerException(
              type: ServerExceptionType.unknown,
              message: message,
              data: data,
              code: statusCode,
            ),
        },
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        ServerException(
          type: ServerExceptionType.timeOut,
          message: message,
          data: data,
          code: 408,
        ),
      DioExceptionType.connectionError => ServerException(
          type: ServerExceptionType.noInternet,
          message: message,
          data: data,
          code: 101,
        ),
      DioExceptionType.badCertificate => ServerException(
          type: ServerExceptionType.unknown,
          message: message,
          data: data,
          code: statusCode,
        ),
      DioExceptionType.cancel || DioExceptionType.unknown => ServerException(
          type: ServerExceptionType.unknown,
          message: message,
          data: data,
          code: statusCode,
        ),
    };
  }
}

enum ServerExceptionType {
  general, //Used for Business Logic errors
  unauthorized, //Unauthorized vs Forbidden: https://stackoverflow.com/questions/3297048/403-forbidden-vs-401-unauthorized-http-responses
  forbidden,
  notFound, //404 vs 405: https://stackoverflow.com/questions/63613258/rest-web-service-error-code-should-be-404-or-405 ,405 vs 501: https://sip-implementors.cs.columbia.narkive.com/GjYcZlgE/405-vs-501
  conflict,
  internal,
  serviceUnavailable, //Common causes are a server that is down for maintenance or that is overloaded
  timeOut,
  noInternet,
  unknown,
}
