import 'package:dio/dio.dart';

import '../../core/logger/app_logging.dart';

class RejectError implements Exception {}

class ErrorInterceptor extends Interceptor {
  @override
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    D.info("onRequest: ${response.requestOptions.method}");
    D.info("Path: ${response.requestOptions.path}");
    D.info('status code: ${response.statusCode}');
    D.info('status code: ${response.data}');


    if (response.statusCode != 200 &&
        response.data != null &&
        response.data is! String) {
      final error = DioException(
        response: response,
        requestOptions: response.requestOptions,
        error: RejectError(),
      );
      return handler.reject(error, true);
    }

    return handler.next(response);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    D.info("onError: ${err.requestOptions.data}");
    D.info("onError Header: ${err.requestOptions.headers}");
    D.info(
        "onError: ${err.requestOptions.path} | Query Params:${err.requestOptions.queryParameters}");
    D.info("onErrorResponse: ${err.response}");
    D.info("statusCode: ${err.response?.statusCode}");

    if (err.type != DioExceptionType.cancel &&
        (err.response?.statusCode != 200 || err.error is RejectError)) {
      final data = err.response?.data;
      final response = err.response;



      return handler.next(err);
    }
  }
}
