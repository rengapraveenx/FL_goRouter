import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 1. Add the new route
final _router = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'user_details',
      path: '/user/:userId',
      builder: (context, state) {
        final userId = state.pathParameters['userId']!;
        final message = state.extra as String? ?? 'No message';
        return UserDetailsPage(userId: userId, message: message);
      },
    ),
    GoRoute(
      path: '/selection',
      builder: (context, state) => const SelectionPage(),
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

// 2. Convert HomePage to a StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _resultFromSelection = 'No result yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result: $_resultFromSelection',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              // 3. Push and await the result
              onPressed: () async {
                final result = await context.push<String>('/selection');
                if (result != null) {
                  setState(() {
                    _resultFromSelection = result;
                  });
                }
              },
              child: const Text('Select Data from Child Page'),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.goNamed(
                'user_details',
                pathParameters: {'userId': '123'},
                extra: 'Hello User 123 from Home!',
              ),
              child: const Text('Go to User 123 Details (go)'),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Create the SelectionPage
class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select an Option')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // 5. Pop with a result
              onPressed: () => context.pop('Option A'),
              child: const Text('Return "Option A"'),
            ),
            ElevatedButton(
              onPressed: () => context.pop('Option B'),
              child: const Text('Return "Option B"'),
            ),
          ],
        ),
      ),
    );
  }
}


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