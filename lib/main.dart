import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 1. Define the router configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => const DetailsPage(),
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

// 2. Change MaterialApp to MaterialApp.router
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

// 3. Create the HomePage widget
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
              // 4. Use context.go() to navigate
              onPressed: () => context.go('/details'),
              child: const Text('Go to Details (go)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // 5. Use context.push() to navigate
              onPressed: () => context.push('/details'),
              child: const Text('Go to Details (push)'),
            ),
          ],
        ),
      ),
    );
  }
}

// 6. Create the DetailsPage widget
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You are on the details page.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go back to Home'),
            ),
            const SizedBox(height: 16),
            // The back button in the AppBar is automatically added by Flutter,
            // but if you use context.pop(), you can create a custom back button.
            // It will only work if there is a page to pop to (i.e., you used push).
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