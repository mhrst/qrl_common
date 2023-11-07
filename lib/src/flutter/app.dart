import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qrl_common/src/flutter/router.dart';

class GoRouterApp extends StatelessWidget {
  final GlobalKey<NavigatorState>? rootNavigatorKey;
  final GlobalKey<NavigatorState>? shellNavigatorKey;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;
  final String appName;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final Locale? locale; // Used to override the device locale for testing
  final List<GoRouterConfig> routes;
  final String initialLocation;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final Widget Function(BuildContext context, GoRouterState state)?
      errorBuilder;
  final Widget Function(
      BuildContext context, GoRouterState state, Widget child)? shellBuilder;
  final List<NavigatorObserver>? observers;

  const GoRouterApp({
    super.key,
    required this.appName,
    required this.routes,
    this.rootNavigatorKey,
    this.shellNavigatorKey,
    this.scaffoldMessengerKey,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.initialLocation = kHomeRoutePath,
    this.errorBuilder,
    this.shellBuilder,
    this.observers,
  });

  GoRouter get routerConfig => GoRouter(
        navigatorKey: rootNavigatorKey,
        observers: observers,
        routes: shellBuilder == null
            ? routesBuilder(routes)
            : shellRouteBuilder(
                shellBuilder, routes, shellNavigatorKey, observers),
        debugLogDiagnostics: !kReleaseMode,
        initialLocation: initialLocation,
        errorBuilder: errorBuilder,
        redirect: (context, state) {
          if ([
            // No redirects on these pages
          ].contains(state.uri)) {
            return null;
          }

          // TODO: redirect checks

          return null;
        },

        // changes on the listenable will cause the router to refresh it's route
        // refreshListenable: ????,
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // showPerformanceOverlay: true,
      // showSemanticsDebugger: true,
      restorationScopeId: 'goRouterApp',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
      title: appName,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: routerConfig,
    );
  }
}

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
