# 🗺️ GoRouter in Flutter — Zero to Hero Roadmap

## 🔰 Basics
1 - [x] **What & Why:** Understand GoRouter's declarative API vs. the imperative Navigator 1.0.
2 - [x] **Installation:** Add `go_router` to `pubspec.yaml` and configure the `GoRouter` instance.
3 - [x] **Simple Routes:** Define your first static routes for pages like `/home` and `/about`.
4 - [x] **Navigation (`go` vs. `push`):** Learn when to rebuild the stack with `context.go()` vs. adding to it with `context.push()`.
5 - [x] **Passing Data:** Use the `extra` parameter to pass complex objects between routes.

---

## ⚙️ Intermediate
6 - [x] **Named Routes:** Use names to navigate, avoiding hardcoded URL strings.
7 - [x] **Path & Query Parameters:** Extract dynamic data from paths (`/users/:id`) and query strings (`/search?q=term`).
8 - [ ] **Returning Data:** Pass data from a child route back to a parent using `context.pop(result)`.
9 - [ ] **`GoRouterState`:** Access route-specific information like parameters, path, and location.
10 - [ ] **`ShellRoute`:** Create persistent UI (like a `BottomNavigationBar` or `Drawer`) for a group of routes.
11 - [ ] **Redirection & Guards:** Protect routes by redirecting based on app state (e.g., user authentication).
12 - [ ] **Error Handling:** Implement a custom "404 - Page Not Found" screen using `errorBuilder`.

---

## 🚀 Advanced
13 - [ ] **Deep Linking:** Configure your app to open specific screens from external URL links.
14 - [ ] **Custom Transitions:** Animate page navigation using `pageBuilder` for custom `Page` transitions.
15 - [ ] **Modular Routes:** Organize routes into separate, feature-based files for a clean architecture.
16 - [ ] **Async Redirects:** Handle asynchronous checks (e.g., validating a session token) before navigation.
17 - [ ] **State-Driven Navigation:** Use `refreshListenable` with a state manager (Provider/Riverpod) for reactive routing.
18 - [ ] **Code Generation:** Use `go_router_builder` to generate type-safe routes and reduce boilerplate.
19 - [ ] **Navigator Observers:** Integrate with observers to track navigation history or analytics.

---

## 🏆 Mini Projects
20 - [ ] **📝 3-Page App:** Build a simple app with Home, About, and Profile pages.
21 - [ ] **🔐 Auth Flow App:** Create an app with a login screen that guards a protected dashboard.
22 - [ ] **📱 Bottom Navigation App:** Implement a multi-tab experience using `ShellRoute` that preserves state.
23 - [ ] **🌐 Web Dashboard:** A Flutter web app where URLs in the browser sync with the app state and support deep links.