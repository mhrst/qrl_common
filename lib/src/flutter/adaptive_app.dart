import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart' hide GoRouterHelper;
import 'package:qrl_common/src/flutter/app.dart';
import 'package:qrl_common/src/flutter/router.dart';

class AdaptiveGoRouterApp extends GoRouterApp {
  final Map<Breakpoint, Widget Function(BuildContext context)> topNavigation;
  final Map<Breakpoint, Widget Function(BuildContext context)>
      secondaryNavigation;
  final Widget Function(BuildContext context, Widget child)?
      bottomNavigationBuilder;
  final Widget Function(BuildContext context, Widget child, bool isExtended)?
      primaryNavigationBuilder;
  final Widget Function(BuildContext context, Widget child)? smallBodyBuilder;
  final Widget Function(BuildContext context, Widget child)? mediumBodyBuilder;
  final Widget Function(BuildContext context, Widget child)?
      secondaryBodyBuilder;

  AdaptiveGoRouterApp({
    required super.appName,
    required super.routes,
    this.topNavigation = const {},
    this.secondaryNavigation = const {},
    this.smallBodyBuilder,
    this.mediumBodyBuilder,
    this.secondaryBodyBuilder,
    this.bottomNavigationBuilder,
    this.primaryNavigationBuilder,
    super.key,
    super.theme,
    super.darkTheme,
    super.themeMode,
    super.locale,
    super.localizationsDelegates,
    super.supportedLocales,
    super.initialLocation,
    super.errorBuilder,
  });

  @override
  GoRouter get routerConfig => GoRouter(
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
        // refreshListenable: _observer,
        routes: [
          shellRouteBuilder(
            (context, state, child) {
              // Build list of destinations from routes data
              final destinations = <NavigationDestination>[];
              int? selectedIndex;
              for (int i = 0; i < routes.length; i++) {
                final route = routes[i];
                if (context.uri?.path.startsWith(route.path) == true) {
                  selectedIndex = route.icon == null ? null : i;
                }
                if (route.icon != null) {
                  destinations.add(NavigationDestination(
                    label: route.label,
                    icon: route.icon!,
                    selectedIcon: route.iconSelected,
                  ));
                }
              }

              return AdaptiveLayout(
                topNavigation: SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig>{
                    for (var entry in topNavigation.entries)
                      entry.key: SlotLayout.from(
                        inAnimation: AdaptiveScaffold.topToBottom,
                        key: const Key('Top Navigation'),
                        builder: (context) => entry.value(context),
                      ),
                  },
                ),

                // Built-in navigation bar for small screens
                bottomNavigation: SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig>{
                    if (bottomNavigationBuilder != null) ...{
                      Breakpoints.small: SlotLayout.from(
                        key: const Key('Bottom Navigation Small'),
                        inAnimation: AdaptiveScaffold.bottomToTop,
                        outAnimation: AdaptiveScaffold.topToBottom,
                        builder: (_) => bottomNavigationBuilder!(
                          context,
                          destinations.length >= 2
                              ? AdaptiveScaffold.standardBottomNavigationBar(
                                  destinations: destinations,
                                  currentIndex: selectedIndex,
                                  onDestinationSelected: (int newIndex) =>
                                      context.go(routes[newIndex].path),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    },
                  },
                ),

                // Built-in navigation bar for medium and larger screens
                primaryNavigation: SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig>{
                    if (primaryNavigationBuilder != null) ...{
                      Breakpoints.medium: SlotLayout.from(
                        inAnimation: AdaptiveScaffold.leftOutIn,
                        key: const Key('Primary Navigation Medium'),
                        builder: (_) => primaryNavigationBuilder!(
                          context,
                          destinations.length > 1
                              ? AdaptiveScaffold.standardNavigationRail(
                                  selectedIndex: selectedIndex,
                                  onDestinationSelected: (int newIndex) =>
                                      context.go(routes[newIndex].path),
                                  destinations: destinations
                                      .map((_) =>
                                          AdaptiveScaffold.toRailDestination(_))
                                      .toList(),
                                )
                              : const SizedBox.shrink(),
                          false,
                        ),
                      ),
                      Breakpoints.large: SlotLayout.from(
                        key: const Key('Primary Navigation Large'),
                        inAnimation: AdaptiveScaffold.leftOutIn,
                        builder: (_) => primaryNavigationBuilder!(
                          context,
                          destinations.length > 1
                              ? AdaptiveScaffold.standardNavigationRail(
                                  extended: true,
                                  selectedIndex: selectedIndex,
                                  onDestinationSelected: (int newIndex) =>
                                      context.go(routes[newIndex].path),
                                  destinations: destinations
                                      .map((_) =>
                                          AdaptiveScaffold.toRailDestination(_))
                                      .toList(),
                                )
                              : const SizedBox.shrink(),
                          true,
                        ),
                      ),
                    },
                  },
                ),
                secondaryNavigation: SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig>{
                    for (var entry in secondaryNavigation.entries)
                      entry.key: SlotLayout.from(
                        inAnimation: AdaptiveScaffold.rightOutIn,
                        key: const Key('Secondary Navigation'),
                        builder: (context) => entry.value(context),
                      ),
                  },
                ),
                body: SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig>{
                    if (smallBodyBuilder != null)
                      Breakpoints.smallAndUp: SlotLayout.from(
                        key: const Key('Body Small'),
                        builder: (context) => smallBodyBuilder!(context, child),
                      ),
                    if (mediumBodyBuilder != null)
                      Breakpoints.mediumAndUp: SlotLayout.from(
                        key: const Key('Body Medium'),
                        builder: (context) =>
                            mediumBodyBuilder!(context, child),
                      ),
                  },
                ),
                // Only visible on medium+ screens
                secondaryBody: SlotLayout(
                  config: <Breakpoint, SlotLayoutConfig>{
                    if (secondaryBodyBuilder != null)
                      Breakpoints.mediumAndUp: SlotLayout.from(
                        key: const Key('Secondary Body Medium'),
                        builder: (context) =>
                            secondaryBodyBuilder!(context, child),
                      ),
                  },
                ),
              );
            },
            routes,
          ),
        ],
      );
}
