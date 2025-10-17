
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 1. Update the router configuration to handle 'extra' data
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) {
        // Receive the data from the 'extra' parameter
        final String message = state.extra as String? ?? 'No message passed';
        return DetailsPage(message: message);
      },
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'GoRouter Basics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // 2. Pass data using the 'extra' parameter
              onPressed: () => context.go('/details', extra: 'Hello from the Home Page! (go)'),
              child: const Text('Go to Details (go)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/details', extra: 'Hello from the Home Page! (push)'),
              child: const Text('Go to Details (push)'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Update DetailsPage to accept and display the data
class DetailsPage extends StatelessWidget {
  final String message;
  const DetailsPage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message, // Display the passed message
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to Home'),
            ),
            if (context.canPop())
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back (pop)'),
              ),
          ],
        ),
      ),
    );
  }
}
