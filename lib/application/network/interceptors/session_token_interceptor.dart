import 'package:dio/dio.dart';
import 'package:kanbanboard/application/constants/app_constants.dart';

class SessionTokenInterceptor extends QueuedInterceptor {
  SessionTokenInterceptor();


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"Authorization":"Bearer ${AppConstants.token}"});
    return handler.next(options);
  }
}
