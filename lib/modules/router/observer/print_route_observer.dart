import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PrintRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('Pushed: ${route.settings.name}', name: "AutoRoute");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    log('Popped: ${route.settings.name}', name: "AutoRoute");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    log('Removed: ${route.settings.name}', name: "AutoRoute");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    log(
      'Replaced: ${oldRoute?.settings.name} with ${newRoute?.settings.name}',
      name: "AutoRoute",
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log(name: "AutoRoute", 'Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log(name: "AutoRoute", 'Tab route re-visited: ${route.name}');
  }
}
