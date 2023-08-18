import 'package:flutter/material.dart';
import 'package:qrl_common/flutter.dart';

void main() async {
  runApp(AdaptiveGoRouterApp(
    appName: 'Example',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    smallBodyBuilder: (context, child) => child,
    mediumBodyBuilder: (context, child) {
      return GridView.count(
        crossAxisCount: 2,
        children: List.generate(10, (index) => index)
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    height: 400,
                  ),
                ))
            .toList(),
      );
    },
    secondaryBodyBuilder: (context, child) {
      if (context.uri?.path == kHomeRoutePath) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Home',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ));
      }
      return child;
    },
    routes: [
      GoRouterConfig(
        builder: (context, state) => const Scaffold(body: HomeView()),
        label: 'Home',
        path: kHomeRoutePath,
        icon: const Icon(Icons.home_outlined),
        iconSelected: const Icon(Icons.home),
        children: [],
      ),
      GoRouterConfig(
        builder: (context, state) => const Scaffold(body: ContactView()),
        label: 'Contact',
        path: '/contact',
        icon: const Icon(Icons.alternate_email_outlined),
        iconSelected: const Icon(Icons.alternate_email),
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
