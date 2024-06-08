import 'dart:io';

import 'package:dio/dio.dart';

import '../external_values/iExternalValue.dart';

abstract class IApiService {
  Dio get();
  void serviceGenerator(IExternalValues externalValues);
  BaseOptions getBaseOptions(IExternalValues externalValues);
  HttpClient httpClientCreate(HttpClient client);

}
