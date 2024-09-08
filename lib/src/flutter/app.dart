import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'router.dart';

class GoRouterApp extends StatefulWidget {
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
  final List<NavigatorObserver>? shellObservers;
  final TransitionBuilder? builder;
  final GoRouterRedirect? redirect;

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
    this.shellObservers,
    this.builder,
    this.redirect,
  });

  @override
  State<GoRouterApp> createState() => _GoRouterAppState();
}

class _GoRouterAppState extends State<GoRouterApp> {
  late final GoRouter routerConfig;

  @override
  void initState() {
    super.initState();
    GoRouter.optionURLReflectsImperativeAPIs = true;
    routerConfig = GoRouter(
      navigatorKey: widget.rootNavigatorKey,
      observers: widget.observers,
      routes: widget.shellBuilder == null
          ? routesBuilder(widget.routes)
          : shellRouteBuilder(widget.shellBuilder, widget.routes,
              widget.shellNavigatorKey, widget.shellObservers),
      debugLogDiagnostics: !kReleaseMode,
      initialLocation: widget.initialLocation,
      errorBuilder: widget.errorBuilder,
      redirect: widget.redirect,
    );
  }

  @override
  void dispose() {
    routerConfig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      restorationScopeId: 'goRouterApp',
      debugShowCheckedModeBanner: false,
      // showPerformanceOverlay: true,
      // showSemanticsDebugger: true,
      locale: widget.locale,
      localizationsDelegates: widget.localizationsDelegates,
      scaffoldMessengerKey: widget.scaffoldMessengerKey,
      supportedLocales: widget.supportedLocales,
      title: widget.appName,
      builder: widget.builder,
      // Themes
      theme: widget.theme,
      darkTheme: widget.darkTheme,
      themeMode: widget.themeMode,
    );
  }
}
