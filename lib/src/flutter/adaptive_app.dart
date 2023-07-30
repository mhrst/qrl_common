import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart' hide GoRouterHelper;
import 'package:qrl_common/flutter.dart';

class AdaptiveGoRouterApp extends GoRouterApp {
  final Widget Function(BuildContext context, Widget child)? bodyBuilderSmall;
  final Widget Function(BuildContext context, Widget child)? bodyBuilderMedium;
  final Widget Function(BuildContext context, Widget child)?
      secondaryBodyBuilder;

  AdaptiveGoRouterApp({
    this.bodyBuilderSmall,
    this.bodyBuilderMedium,
    this.secondaryBodyBuilder,
    required super.appName,
    required super.routes,
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
        // observers: [_observer],
        routes: [
          shellRouteBuilder(
            (context, state, child) {
              return StatefulBuilder(builder: (context, setState) {
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
                  // Primary navigation config has nothing from 0 to 600 dp screen width,
                  // then an unextended NavigationRail with no labels and just icons then an
                  // extended NavigationRail with both icons and labels.
                  primaryNavigation: destinations.length >= 2
                      ? SlotLayout(
                          config: <Breakpoint, SlotLayoutConfig>{
                            Breakpoints.medium: SlotLayout.from(
                              inAnimation: AdaptiveScaffold.leftOutIn,
                              key: const Key('Primary Navigation Medium'),
                              builder: (_) =>
                                  AdaptiveScaffold.standardNavigationRail(
                                selectedIndex: selectedIndex,
                                onDestinationSelected: (int newIndex) =>
                                    context.go(routes[newIndex].path),
                                destinations: destinations
                                    .map((_) =>
                                        AdaptiveScaffold.toRailDestination(_))
                                    .toList(),
                              ),
                            ),
                            Breakpoints.large: SlotLayout.from(
                              key: const Key('Primary Navigation Large'),
                              inAnimation: AdaptiveScaffold.leftOutIn,
                              builder: (_) =>
                                  AdaptiveScaffold.standardNavigationRail(
                                extended: true,
                                selectedIndex: selectedIndex,
                                onDestinationSelected: (int newIndex) =>
                                    context.go(routes[newIndex].path),
                                destinations: destinations
                                    .map((_) =>
                                        AdaptiveScaffold.toRailDestination(_))
                                    .toList(),
                              ),
                            ),
                          },
                        )
                      : null,
                  // Body switches between a ListView and a GridView from small to medium
                  // breakpoints and onwards.
                  body: SlotLayout(
                    config: <Breakpoint, SlotLayoutConfig>{
                      if (bodyBuilderSmall != null)
                        Breakpoints.smallAndUp: SlotLayout.from(
                          key: const Key('Body Small'),
                          builder: (context) =>
                              bodyBuilderSmall!(context, child),
                        ),
                      if (bodyBuilderMedium != null)
                        Breakpoints.mediumAndUp: SlotLayout.from(
                          key: const Key('Body Medium'),
                          builder: (context) =>
                              bodyBuilderMedium!(context, child),
                        ),
                    },
                  ),
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
                  // BottomNavigation is only active in small views defined as under 600 dp
                  // width.
                  bottomNavigation: destinations.length >= 2
                      ? SlotLayout(
                          config: <Breakpoint, SlotLayoutConfig>{
                            Breakpoints.small: SlotLayout.from(
                              key: const Key('Bottom Navigation Small'),
                              inAnimation: AdaptiveScaffold.bottomToTop,
                              outAnimation: AdaptiveScaffold.topToBottom,
                              builder: (_) =>
                                  AdaptiveScaffold.standardBottomNavigationBar(
                                destinations: destinations,
                                currentIndex: selectedIndex,
                                onDestinationSelected: (int newIndex) =>
                                    context.go(routes[newIndex].path),
                              ),
                            )
                          },
                        )
                      : null,
                );
              });
            },
            routes,
          ),
        ],
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
      );
}
