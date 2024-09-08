import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const kHomeRoutePath = '/';

List<GoRoute> routesBuilder(List<GoRouterConfig> routes) {
  return [
    for (final route in routes)
      GoRoute(
        name: route.name,
        path: route.path,
        builder: route.builder,
        parentNavigatorKey: route.parentNavigatorKey,
        routes: routesBuilder(route.children ?? []),
      ),
  ];
}

List<RouteBase> shellRouteBuilder(
  Widget Function(BuildContext, GoRouterState, Widget)? shellBuilder,
  List<GoRouterConfig> routes,
  GlobalKey<NavigatorState>? navigatorKey, [
  List<NavigatorObserver>? observers,
]) =>
    [
      ShellRoute(
          builder: shellBuilder,
          routes: routesBuilder(routes),
          observers: observers,
          navigatorKey: navigatorKey)
    ];

class GoRouterConfig {
  final String name;
  final String path;
  final GoRouterWidgetBuilder builder;
  final List<GoRouterConfig>? children;
  final GlobalKey<NavigatorState>? parentNavigatorKey;

  GoRouterConfig({
    required this.name,
    required this.path,
    required this.builder,
    this.children,
    this.parentNavigatorKey,
  });
}

extension GoRouterExtensions on BuildContext {
  Uri get location {
    final routerDelegate = GoRouter.of(this).routerDelegate;
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri;
  }

  bool canPop() => GoRouter.of(this).canPop();

  void go(String location) => GoRouter.of(this).go(location);

  void goNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, Object?> queryParameters = const {},
    Object? extra,
  }) =>
      GoRouter.of(this).goNamed(name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);

  void pop({Object? result}) => GoRouter.of(this).pop(result);

  void push(String location, {Object? extra}) =>
      GoRouter.of(this).push(location, extra: extra);

  void pushNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, Object?> queryParameters = const {},
    Object? extra,
  }) =>
      GoRouter.of(this).pushNamed(name,
          pathParameters: pathParameters,
          queryParameters: queryParameters,
          extra: extra);

  void replace(String location, {Object? extra}) =>
      GoRouter.of(this).replace(location, extra: extra);
}
