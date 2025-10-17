import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 1. Add names to routes and define path parameters
final _router = GoRouter(
  routes: [
    GoRoute(
      name: 'home', // Route name
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'user_details', // Route name
      path: '/user/:userId', // Path parameter: userId
      builder: (context, state) {
        // Extract data from path parameter and 'extra'
        final userId = state.pathParameters['userId']!;
        final message = state.extra as String? ?? 'No message';
        return UserDetailsPage(userId: userId, message: message);
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
      title: 'GoRouter Intermediate',
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
              // 2. Navigate using goNamed with path parameters
              onPressed: () => context.goNamed(
                'user_details',
                pathParameters: {'userId': '123'},
                extra: 'Hello User 123 from Home!',
              ),
              child: const Text('Go to User 123 Details (go)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              // 3. Navigate using pushNamed with path parameters
              onPressed: () => context.pushNamed(
                'user_details',
                pathParameters: {'userId': '456'},
                extra: 'Hello User 456 from Home!',
              ),
              child: const Text('Push User 456 Details (push)'),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Renamed and updated the details page
class UserDetailsPage extends StatelessWidget {
  final String userId;
  final String message;

  const UserDetailsPage({required this.userId, required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User ID: $userId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Message: $message',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.goNamed('home'),
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