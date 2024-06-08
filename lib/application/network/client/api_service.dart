import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kanbanboard/application/main_config/main_config.dart';

import '../external_values/iExternalValue.dart';
import '../interceptors/error_interceptor.dart';
import '../interceptors/session_token_interceptor.dart';
import 'iApService.dart';

class ApiService implements IApiService {
  ApiService.create({required IExternalValues externalValues}) {
    serviceGenerator(externalValues);
  }

  @override
  Dio get() => _dio;

  @override
  BaseOptions getBaseOptions(IExternalValues externalValues) {
    return BaseOptions(
        baseUrl: externalValues.getBaseUrl(),
        receiveDataWhenStatusError: true,
        connectTimeout: MainApiConfig.connectTimeout,
        receiveTimeout: MainApiConfig.receiveTimeout);
  }

  @override
  HttpClient httpClientCreate(HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }

  @override
  void serviceGenerator(IExternalValues externalValues) {
    _dio = Dio()
      ..options = getBaseOptions(externalValues)
      ..interceptors.addAll([SessionTokenInterceptor(), ErrorInterceptor()]);
  }

  late Dio _dio;
}
