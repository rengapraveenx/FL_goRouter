import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// To run this example, open main.dart and change runApp() to:
// runApp(const ErrorHandlingExampleApp());

// 1. Configure the router
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsScreen(),
    ),
  ],
  // 2. Add the errorBuilder
  errorBuilder: (context, state) {
    return ErrorScreen(error: state.error);
  },
);

class ErrorHandlingExampleApp extends StatelessWidget {
  const ErrorHandlingExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'GoRouter Error Handling',
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}

// --- Pages ---

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/details'),
              child: const Text('Go to Details (Exists)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 3. Navigate to a route that does not exist
                context.go('/some-non-existent-path');
              },
              child: const Text('Go to a Bad Route'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: const Center(
        child: Text('This is the details page.'),
      ),
    );
  }
}

// 4. The custom error screen
class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({this.error, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 50, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'The route you requested was not found.\n${error?.toString() ?? ''}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}