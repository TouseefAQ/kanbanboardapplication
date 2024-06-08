import 'package:get_it/get_it.dart';
import 'package:kanbanboard/di/di.dart';

abstract class MainApiConfig {
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 60 );
  static const contentType = 'application/json; charset=UTF-8';
}

final serviceLocator = GetIt.instance;

Future<void> initMainServiceLocator() async {
  await  setupLocator();
  return serviceLocator.allReady();
}