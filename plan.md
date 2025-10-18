# 🗺️ GoRouter in Flutter — Zero to Hero Roadmap

## 🔰 Basics
- [x] **What & Why:** Understand GoRouter's declarative API vs. the imperative Navigator 1.0.
- [x] **Installation:** Add `go_router` to `pubspec.yaml` and configure the `GoRouter` instance.
- [x] **Simple Routes:** Define your first static routes for pages like `/home` and `/about`.
- [x] **Navigation (`go` vs. `push`):** Learn when to rebuild the stack with `context.go()` vs. adding to it with `context.push()`.
- [x] **Passing Data:** Use the `extra` parameter to pass complex objects between routes.

---

## ⚙️ Intermediate
- [x] **Named Routes:** Use names to navigate, avoiding hardcoded URL strings.
- [x] **Path & Query Parameters:** Extract dynamic data from paths (`/users/:id`) and query strings (`/search?q=term`).
- [ ] **`GoRouterState`:** Access route-specific information like parameters, path, and location.
- [ ] **`ShellRoute`:** Create persistent UI (like a `BottomNavigationBar` or `Drawer`) for a group of routes.
- [ ] **Redirection & Guards:** Protect routes by redirecting based on app state (e.g., user authentication).
- [ ] **Error Handling:** Implement a custom "404 - Page Not Found" screen using `errorBuilder`.

---

## 🚀 Advanced
- [ ] **Deep Linking:** Configure your app to open specific screens from external URL links.
- [ ] **Custom Transitions:** Animate page navigation using `pageBuilder` for custom `Page` transitions.
- [ ] **Modular Routes:** Organize routes into separate, feature-based files for a clean architecture.
- [ ] **Async Redirects:** Handle asynchronous checks (e.g., validating a session token) before navigation.
- [ ] **State-Driven Navigation:** Use `refreshListenable` with a state manager (Provider/Riverpod) for reactive routing.
- [ ] **Code Generation:** Use `go_router_builder` to generate type-safe routes and reduce boilerplate.
- [ ] **Navigator Observers:** Integrate with observers to track navigation history or analytics.

---

## 🏆 Mini Projects
- [ ] **📝 3-Page App:** Build a simple app with Home, About, and Profile pages.
- [ ] **🔐 Auth Flow App:** Create an app with a login screen that guards a protected dashboard.
- [ ] **📱 Bottom Navigation App:** Implement a multi-tab experience using `ShellRoute` that preserves state.
- [ ] **🌐 Web Dashboard:** A Flutter web app where URLs in the browser sync with the app state and support deep links.