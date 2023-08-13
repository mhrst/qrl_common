import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart' hide GoRouterHelper;
import 'package:qrl_common/flutter.dart';

class AdaptiveGoRouterApp extends GoRouterApp {
  final Map<Breakpoint, Widget Function(BuildContext context)> topNavigation;
  final Map<Breakpoint, Widget Function(BuildContext context)>
      secondaryNavigation;
  final Widget Function(BuildContext context, Widget child)? bodyBuilderSmall;
  final Widget Function(BuildContext context, Widget child)? bodyBuilderMedium;
  final Widget Function(BuildContext context, Widget child)?
      secondaryBodyBuilder;

  AdaptiveGoRouterApp({
    required super.appName,
    required super.routes,
    this.topNavigation = const {},
    this.secondaryNavigation = const {},
    this.bodyBuilderSmall,
    this.bodyBuilderMedium,
    this.secondaryBodyBuilder,
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

                // Built-in navigation bar for medium and larger screens
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
                    if (bodyBuilderSmall != null)
                      Breakpoints.smallAndUp: SlotLayout.from(
                        key: const Key('Body Small'),
                        builder: (context) => bodyBuilderSmall!(context, child),
                      ),
                    if (bodyBuilderMedium != null)
                      Breakpoints.mediumAndUp: SlotLayout.from(
                        key: const Key('Body Medium'),
                        builder: (context) =>
                            bodyBuilderMedium!(context, child),
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
