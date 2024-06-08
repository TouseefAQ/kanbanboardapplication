import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kanbanboard/application/core/extensions/extensions.dart';

import 'i_navigation_service.dart';

class NavigationService implements INavigationService {

  final GlobalKey<NavigatorState> _key =  GlobalKey<NavigatorState>();

  @override
  BuildContext get globalContext => _key.currentState!.context;

  @override
  GlobalKey<NavigatorState> key() {
   return _key ;
  }

  @override
  void pop([Object? result]) {
    // TODO: implement pop
  }

  @override
  Future? push(Widget page, {String? routeName}) {
    // TODO: implement push
    throw UnimplementedError();
  }

  @override
  Future? pushNamed(String path, {Object? object}) {
    // TODO: implement pushNamed
    throw UnimplementedError();
  }

  @override
  Future? pushNamedAndRemoveAll(String path, {Object? object}) {
    // TODO: implement pushNamedAndRemoveAll
    throw UnimplementedError();
  }

  @override
  Future? pushNamedAndRemoveUntil(String path, {Object? object}) {
    // TODO: implement pushNamedAndRemoveUntil
    throw UnimplementedError();
  }

  @override
  Future? pushReplacementNamed(String path, {Object? object}) {
    // TODO: implement pushReplacementNamed
    throw UnimplementedError();
  }

  @override
  void showBottomSheet(Widget child) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: globalContext,
      builder: (BuildContext context) {
        return  Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          )
        );
      },
    );
  }

  @override
  showToast(String msg, {Color? bgColor}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: globalContext.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
