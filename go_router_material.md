# GoRouter Basics: A Summary

This document summarizes the foundational concepts of `go_router` covered so far.

---

## 1. What is GoRouter & Why Use It?

GoRouter is a declarative routing package for Flutter that simplifies navigation, especially for apps that need to handle deep linking and complex navigation logic.

- **Imperative (Old Way):** You manually manage a stack of pages using `Navigator.of(context).push()` and `pop()`. This is like giving turn-by-turn directions. It can become complex and scattered.

- **Declarative (GoRouter Way):** You define a list of all possible routes (URLs) your app can handle. To navigate, you simply change the current "location" (e.g., `/home` or `/details`), and the router figures out which screen(s) to show. This centralizes your routing logic.

---

## 2. Installation & Initial Setup

### Installation

Add the package to your project by running:
```sh
flutter pub add go_router
```

### Basic Configuration

To enable GoRouter, you must:
1.  Define a `GoRouter` object with a list of `GoRoute`s.
2.  Change your `MaterialApp` to `MaterialApp.router` and pass your router configuration to it.

**Example (`lib/main.dart`):**
```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 1. Define the router
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

// 2. Use MaterialApp.router
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router, // Assign the router
      title: 'GoRouter Example',
    );
  }
}

// Define your page widgets (HomePage, DetailsPage, etc.)
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // ...
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  // ...
}
```

---

## 3. Core Navigation Methods

Navigation is performed using extension methods on the `BuildContext`.

### `context.go(path)`
- **What it does:** Replaces the entire navigation stack with the new route. It's like typing a new URL in a browser.
- **When to use:** For primary navigation where you don't want a "back" history, such as switching tabs in a `BottomNavigationBar`.
- **Example:** `context.go('/profile');`

### `context.push(path)`
- **What it does:** Adds a new route on top of the current navigation stack.
- **When to use:** For sequential navigation where the user should be able to go back, like opening a details screen from a list. This will show a back button in the `AppBar`.
- **Example:** `context.push('/settings/notifications');`

### `context.pop()`
- **What it does:** Removes the top-most route from the navigation stack, going back to the previous page.
- **Important:** This only works if a page was previously pushed onto the stack. You can check if popping is possible with `context.canPop()`.
- **Example:** `if (context.canPop()) { context.pop(); }`

---

## 4. Passing Data Between Routes

The simplest way to pass data is using the `extra` parameter, which can hold any `Object`.

### Sending Data
Pass the data as the `extra` argument to `go()` or `push()`.

```dart
// In HomePage
ElevatedButton(
  onPressed: () => context.go(
    '/details',
    extra: 'Hello from the Home Page!', // This can be any object
  ),
  child: const Text('Go to Details'),
),
```

### Receiving Data
In the route's `builder`, the data is available in the `GoRouterState` object.

```dart
// In your GoRouter configuration
GoRoute(
  path: '/details',
  builder: (context, state) {
    // 1. Receive the data from state.extra
    final String message = state.extra as String? ?? 'No message';

    // 2. Pass it to your widget
    return DetailsPage(message: message);
  },
),

// Your DetailsPage widget
class DetailsPage extends StatelessWidget {
  final String message;
  const DetailsPage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message), // "Hello from the Home Page!"
      ),
    );
  }
}
```

---

## 5. Named Routes and Path Parameters

Using names for routes and parameters in the path makes your navigation code more robust and maintainable.

### Defining Named Routes
Assign a unique `name` string to a `GoRoute`.

```dart
// In your GoRouter configuration
GoRoute(
  name: 'user_details', // Route name
  path: '/user/:userId', // Path with a parameter
  builder: (context, state) {
    // ...
  },
),
```

### Navigating with Names
Use `context.goNamed()` or `context.pushNamed()`. This is safer than using raw paths.

```dart
// Pass the value for ':userId' in the pathParameters map
context.goNamed(
  'user_details',
  pathParameters: {'userId': '123'},
  extra: 'Some extra data',
);
```

### Receiving Path Parameters
In the route's `builder`, path parameters are available in the `state.pathParameters` map.

```dart
// In your GoRouter configuration
GoRoute(
  name: 'user_details',
  path: '/user/:userId',
  builder: (context, state) {
    // Extract the parameter value by its key
    final String userId = state.pathParameters['userId']!;
    return UserDetailsPage(userId: userId);
  },
),
```

---

## 6. `pathParameters` vs. `extra`

This is a critical distinction for passing data correctly.

| Feature | `pathParameters` | `extra` |
| :--- | :--- | :--- |
| **Visibility** | Part of the URL path, visible to the user (e.g., `/users/123`) | Not part of the URL; hidden from the user |
| **Data Type** | Always a `String` | Can be **any** Dart `Object` |
| **Purpose** | To identify a specific resource (e.g., a unique ID) | To pass complex data or temporary state |
| **Persistence** | Persistent (works with bookmarks, history, deep links) | Not persistent (lost on page refresh) |

### When to Use Which?

-   Use **`pathParameters`** when the data is a simple, unique identifier that you want to be able to link to directly.
-   Use **`extra`** when you need to pass a complex Dart object or temporary state that doesn't need to be represented in the URL.
