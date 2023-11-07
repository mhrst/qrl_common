import 'package:flutter/material.dart';
import 'package:qrl_common/flutter.dart';

void main() async {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  runApp(GoRouterApp(
    rootNavigatorKey: rootNavigatorKey,
    shellNavigatorKey: shellNavigatorKey,
    scaffoldMessengerKey: scaffoldMessengerKey,
    appName: 'Example',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    shellBuilder: (context, state, child) {
      return Row(
        children: [
          const SizedBox(width: 250, child: HomeView()),
          Expanded(child: child),
        ],
      );
    },
    routes: [
      GoRouterConfig(
          builder: (context, state) => Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    height: 2000,
                    color: const Color(0xFFefebc6),
                    child: const Row(
                      children: [
                        Text('Home'),
                      ],
                    ),
                  ),
                ),
                bottomSheet: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => const SizedBox.expand());
                        },
                        icon: const Icon(Icons.fork_left),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => const SizedBox.expand());
                        },
                        icon: const Icon(Icons.fork_right),
                      ),
                    ],
                  ),
                ),
              ),
          name: 'Home',
          path: kHomeRoutePath,
          children: [
            GoRouterConfig(
              // parentNavigatorKey: rootNavigatorKey,
              builder: (context, state) => const Scaffold(body: HomeView()),
              name: 'Notes',
              path: 'notes',
            ),
            GoRouterConfig(
              // parentNavigatorKey: rootNavigatorKey,
              builder: (context, state) => const Scaffold(body: OtherView()),
              name: 'Other',
              path: 'other',
            ),
          ]),
    ],
  ));
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => Material(
        child: InkWell(
          onTap: () {
            switch (index) {
              case 0:
                context.pop();
                break;
              case < 5:
                context.push('/notes');
                break;
              case < 10:
                context.go('/notes');
                break;
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  .withBlue(index * 30),
              height: 400,
            ),
          ),
        ),
      ),
    );
  }
}

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        height: 400,
      ),
    );
  }
}
