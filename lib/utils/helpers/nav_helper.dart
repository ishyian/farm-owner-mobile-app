import 'package:flutter/material.dart';

class NavHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  BuildContext getContext() => navigatorKey.currentContext!;

  Future<dynamic> push(
    Widget view,
  ) async {
    return Navigator.of(navigatorKey.currentContext!).push(
      MaterialPageRoute(builder: (_) => view),
    );
  }

  Future<dynamic> pushAndRemoveUntilFirst(
    Widget view,
  ) async {
    return Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => view),
      (route) => false,
    );
  }

  Future<dynamic> pushReplacement(
    Widget view,
  ) async {
    return Navigator.of(navigatorKey.currentContext!).pushReplacement(
      MaterialPageRoute(
        builder: (_) => view,
      ),
    );
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(navigatorKey.currentContext!).pop(result);
  }
}
