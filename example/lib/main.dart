import 'package:flutter/material.dart';
import 'package:qrl_common/flutter.dart';

void main() async {
  runApp(AdaptiveGoRouterApp(
    appName: 'Example',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    primaryNavigation: {
      Breakpoints.large: (context) => const NavigationDrawer(
            children: [
              NavigationDrawerDestination(
                label: Text('Home'),
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
              ),
            ],
          ),
    },
    secondaryNavigation: {
      Breakpoints.large: (context) => const NavigationDrawer(
            children: [
              NavigationDrawerDestination(
                label: Text('Home'),
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
              ),
            ],
          ),
    },
    smallBodyBuilder: (context, child) => child,
    mediumBodyBuilder: (context, child) {
      return Container(
        color: Colors.black12,
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: child,
          ),
        ),
      );
    },
    // secondaryBodyBuilder: (context, child) {
    //   if (context.uri?.path == kHomeRoutePath) {
    //     return Scaffold(
    //         body: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Text(
    //         'Home',
    //         style: Theme.of(context).textTheme.displayLarge,
    //       ),
    //     ));
    //   }
    //   return child;
    // },
    routes: [
      GoRouterConfig(
        builder: (context, state) => Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: 2000,
              child: Row(
                children: [
                  Text('Home'),
                ],
              ),
              color: const Color(0xFFefebc6),
            ),
          ),
          bottomSheet: Container(
            // height: 200,
            child: Padding(
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
        ),
        label: 'Home',
        path: kHomeRoutePath,
        icon: const Icon(Icons.home_outlined),
        iconSelected: const Icon(Icons.home),
        children: [],
      ),
      GoRouterConfig(
        builder: (context, state) => const Scaffold(body: ContactView()),
        label: 'Notes',
        path: '/notes',
        icon: const Icon(Icons.note_add_outlined),
        iconSelected: const Icon(Icons.note_add),
      ),
    ],
  ));
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          height: 400,
        ),
      ),
    );
  }
}

class ContactView extends StatelessWidget {
  const ContactView({super.key});

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
