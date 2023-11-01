import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrl_common/flutter.dart';

const kHomeRoutePath = '/';

extension GoRouterExtensions on BuildContext {
  Uri? get uri {
    try {
      return GoRouterState.of(this).uri;
    } catch (_) {
      return null;
    }
  }

  void go(String location) {
    GoRouter.of(this).go(location);
  }
}

ShellRoute shellRouteBuilder(
  Widget Function(BuildContext, GoRouterState, Widget)? shellBuilder,
  List<GoRouterConfig> routes, [
  List<NavigatorObserver>? observers,
]) =>
    ShellRoute(
      builder: shellBuilder,
      routes: routesBuilder(routes),
      observers: observers,
    );

List<GoRoute> routesBuilder(List<GoRouterConfig> routes) {
  return [
    for (final route in routes)
      GoRoute(
        name: route.name,
        path: route.path,
        builder: route.builder,
        routes: routesBuilder(route.children ?? []),
      ),
  ];
}
