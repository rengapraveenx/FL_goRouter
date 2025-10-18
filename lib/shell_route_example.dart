import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// To run this example, open main.dart and change runApp() to:
// runApp(const ShellRouteExampleApp());

// 1. Define the routes for the ShellRoute
final _router = GoRouter(
  initialLocation: '/a', // Set initial location
  routes: [
    // 2. Create the ShellRoute
    ShellRoute(
      // 3. Define a navigator key for the shell
      navigatorKey: GlobalKey<NavigatorState>(),
      // 4. The builder for the shell UI (e.g., Scaffold with BottomNavBar)
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      // 5. Define the routes that will be displayed within the shell
      routes: [
        GoRoute(
          path: '/a',
          builder: (context, state) => const PageA(),
        ),
        GoRoute(
          path: '/b',
          builder: (context, state) => const PageB(),
        ),
        GoRoute(
          path: '/c',
          builder: (context, state) => const PageC(),
        ),
      ],
    ),
  ],
);

class ShellRouteExampleApp extends StatelessWidget {
  const ShellRouteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'GoRouter ShellRoute',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}

// 6. The Shell UI Widget
class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({required this.child, super.key});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/a')) {
      return 0;
    }
    if (location.startsWith('/b')) {
      return 1;
    }
    if (location.startsWith('/c')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/a');
        break;
      case 1:
        GoRouter.of(context).go('/b');
        break;
      case 2:
        GoRouter.of(context).go('/c');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Page B',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Page C',
          ),
        ],
      ),
    );
  }
}

// 7. The pages for the tabs
class PageA extends StatelessWidget {
  const PageA({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page A')),
      body: const Center(child: Text('This is Page A')),
    );
  }
}

class PageB extends StatelessWidget {
  const PageB({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page B')),
      body: const Center(child: Text('This is Page B')),
    );
  }
}

class PageC extends StatelessWidget {
  const PageC({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page C')),
      body: const Center(child: Text('This is Page C')),
    );
  }
}
