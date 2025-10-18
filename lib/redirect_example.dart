import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// To run this example, open main.dart and change runApp() to:
// runApp(const RedirectExampleApp());

// --- 1. App State ---

// Simple authentication state holder.
class AuthService extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void login() {
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}

// --- 2. Router Configuration ---

class RedirectExampleApp extends StatefulWidget {
  const RedirectExampleApp({super.key});

  @override
  State<RedirectExampleApp> createState() => _RedirectExampleAppState();
}

class _RedirectExampleAppState extends State<RedirectExampleApp> {
  final AuthService _authService = AuthService();
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    _router = GoRouter(
      refreshListenable: _authService, // Re-evaluate the routes on auth changes
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginPage(authService: _authService),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
      // 3. The redirect logic
      redirect: (BuildContext context, GoRouterState state) {
        final bool loggedIn = _authService.isAuthenticated;
        final bool loggingIn = state.uri.toString() == '/login';

        // If the user is not logged in and not on the login page, redirect to login
        if (!loggedIn && !loggingIn) {
          return '/login';
        }

        // If the user is logged in and on the login page, redirect to home
        if (loggedIn && loggingIn) {
          return '/';
        }

        // No redirect needed
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'GoRouter Redirect',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}

// --- 4. The Pages ---

class LoginPage extends StatelessWidget {
  final AuthService authService;
  const LoginPage({required this.authService, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authService.login(); // This will trigger the redirect
          },
          child: const Text('Log In'),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // A real app would use a provider/service to logout
              // For simplicity, we access it via a hacky global or pass it down.
              // Here, we assume you have access to your auth service.
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is your protected profile.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
