import 'package:flutter/material.dart';
import 'package:qrl_common/flutter.dart';

void main() async {
  runApp(GoRouterApp(
    appName: 'Example',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
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
        children: [],
      ),
      GoRouterConfig(
        builder: (context, state) => const Scaffold(body: ContactView()),
        name: 'Notes',
        path: '/notes',
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
