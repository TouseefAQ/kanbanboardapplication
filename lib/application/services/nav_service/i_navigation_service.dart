import 'package:flutter/material.dart';

abstract class INavigationService {
  GlobalKey<NavigatorState> key();

  BuildContext get globalContext;

  Future<dynamic>? pushNamedAndRemoveUntil(String path, {Object? object});
  Future<dynamic>? pushNamedAndRemoveAll(String path, {Object? object});
  Future<dynamic>? pushNamed(String path, {Object? object});
  Future<dynamic>? pushReplacementNamed(String path, {Object? object});
  Future<dynamic>? push(Widget page, {String? routeName});
  void pop([Object? result]);
  void showBottomSheet(Widget child);
  showToast(String msg, {Color? bgColor});
}
