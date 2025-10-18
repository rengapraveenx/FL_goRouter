import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouting/shell_route_example.dart';
import 'package:gorouting/redirect_example.dart';
import 'package:gorouting/error_handling_example.dart';

// To see the ShellRoute example, change runApp() in main() to:
// runApp(const ShellRouteExampleApp());

// To see the Redirect example, change runApp() in main() to:
// runApp(const RedirectExampleApp());

// To see the Error Handling example, change runApp() in main() to:
// runApp(const ErrorHandlingExampleApp());

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
        // 1. Pass the state down to the page
        return UserDetailsPage(
          userId: userId,
          message: message,
          state: state,
        );
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
                // Pass query parameters to see them in the state
                queryParameters: {'source': 'home', 'debug': 'true'},
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

// 2. Accept and use the GoRouterState
class UserDetailsPage extends StatelessWidget {
  final String userId;
  final String message;
  final GoRouterState state; // Accept the state

  const UserDetailsPage({
    required this.userId,
    required this.message,
    required this.state, // Add to constructor
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 3. Display state information
    final queryParams = state.uri.queryParameters;
    final allParams = state.pathParameters;

    return Scaffold(
      appBar: AppBar(title: Text('User ID: $userId')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Message: $message', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Text('GoRouterState Info:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Path: ${state.path}'), // e.g., /user/:userId
              Text('Full Path: ${state.fullPath}'), // e.g., /user/123
              Text('Location: ${state.uri.toString()}'), // e.g., /user/123?q=abc
              Text('Path Parameters: $allParams'),
              Text('Query Parameters: $queryParams'),
              Text('Extra: ${state.extra}'),
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
      ),
    );
  }
}