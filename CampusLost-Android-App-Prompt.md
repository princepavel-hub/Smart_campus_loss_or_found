# Smart Campus Lost & Found — Flutter Application (CampusLost)

Create a complete, production-ready cross-platform mobile application called **"Smart Campus Lost & Found" (CampusLost)** — an intelligent tracking, recovery, and geolocation management platform for lost and found items on a university campus.

The application must be implemented in **Flutter** (Dart) using **Material Design 3**, targeting Android and iOS from a single codebase. It should be structured as a real Flutter project (ready to open in Android Studio / VS Code and run via `flutter run`), buildable into a signed Android APK/AAB and an iOS `.ipa`.

---

## 1. Technical Architecture & Stack

- **Language:** Dart (null-safe)
- **UI Toolkit:** Flutter with Material 3 (`useMaterial3: true`, dynamic color via `dynamic_color` package)
- **Architecture:** MVVM-style layering with Repository pattern; state management via **Riverpod** (or Bloc/Cubit if preferred), unidirectional data flow
- **Local persistence:** `drift` (SQLite) or `Isar` for offline-first local storage — the app must remain usable without network access
- **Networking:** `dio` or `http` package, syncing with the backend (see Section 5) when connectivity is available; `connectivity_plus` to detect network state
- **Background sync & reminders:** `workmanager` (Android) / `background_fetch` for cross-platform background tasks
- **Push notifications:** Firebase Cloud Messaging via `firebase_messaging` (claim status changes, item match alerts)
- **Camera & scanning:** `camera` package for photo capture; `mobile_scanner` (ML Kit-based) for QR tag generation/reading, `qr_flutter` for generating tags
- **Security:** `flutter_secure_storage` for locally cached verification answers; `local_auth` for biometric/PIN gating of the Admin Review Desk
- **Navigation:** `go_router` for declarative, deep-link-friendly routing
- **Dependency injection:** Riverpod providers (or `get_it` if using Bloc)
- **Min/target platform:** Android minSdk 26 / iOS 13+, using the latest stable Flutter SDK
- **Testing:** `flutter_test` for unit/widget tests, `integration_test` for end-to-end flows, `mocktail` for mocking repositories

---

## 2. Project Context & User Roles

The app solves the problem of misplaced belongings (student IDs, keys, smartphones, backpacks, laptops, calculators) across large university facilities by replacing decentralized paper logs with an automated digital system.

It supports two distinct user profiles with an in-app role switcher (gated by login/biometric for staff):

- **Student / User**
  - Browse and filter existing lost & found reports.
  - Submit a "Report Lost Item" declaration.
  - Submit a "Report Found Item" declaration.
  - File an ownership claim inquiry with anti-fraud proof questions.
  - Access the "Find My Phone" emergency radar tool (simulated visualization — see Section 3.5).
- **Campus Security & Administrator**
  - Access an Admin Review Desk (behind biometric/PIN authentication).
  - Inspect, approve, or reject student ownership claims.
  - Verify claimant student ID numbers (matricule) and phone numbers.
  - Scan physical item QR tags to instantly pull up item records.
  - Mark items as "In Security Vault", "Under Verification", or "Officially Returned".

---

## 3. Core Features & Modules

### 3.1 Real-Time Overview Dashboard
- Home screen built with `ListView.builder`/`CustomScrollView` + slivers, a `BottomNavigationBar` (or `NavigationBar` for Material 3), and a `FloatingActionButton` for quick reporting.
- Dynamic counter cards: Total Lost, Found & Stored in Security Vault, and Successfully Returned.
- Search bar (Material 3 `SearchBar` widget) with instant, debounced filtering by keyword.
- Category filter chips (`FilterChip`): All, Electronics, IDs & Cards, Keys, Books & Stationery, Clothing & Bags.
- Campus building filter: Amphitheaters, Central Library, Cafeteria, Science Labs, Sports Complex, Student Union.
- Status indicators via color-coded badges: Lost (Red/Amber), Found in Vault (Blue), Returned (Emerald).
- `RefreshIndicator` (pull-to-refresh) to trigger a manual sync with the backend.

### 3.2 Report Lost Item (full-screen form / modal bottom sheet)
- Fields: item title, category, last known campus location, date & approximate time, public description, and a **private verification section** (e.g., hidden marks, lock-screen wallpaper, key ring details) stored securely and used later to verify genuine owners.
- Presented via `showModalBottomSheet` or a dedicated route, built with `Form` + `TextFormField` validation.
- Optional photo attachment via the `camera` or `image_picker` package.

### 3.3 Report Found Item (full-screen form / modal bottom sheet)
- Fields: item title, category, location where found, current drop-off location (e.g., Central Security Desk, Building A Front Desk), and finder's contact or matricule.
- Auto-generates a printable **QR tag** (via `qr_flutter`) linked to the item's internal record, so it can be physically attached to the item in the security vault.

### 3.4 Anti-Fraud Ownership Verification System
- When a student files a claim, the app prompts them with specific verification questions (set by the finder or administrator) without ever revealing the secret answers to the claimant.
- The Admin Review Desk displays each claim with student ID, submitted answers, and timestamp, with one-tap Approve / Reject actions (requires biometric confirmation for irreversible actions).

### 3.5 "Find My Phone" Campus Radar (simulated demo module)
- An interactive on-screen radar visualization built with a `CustomPainter` on `Canvas`: animated spinning sweep (via `AnimationController`), a campus-zone signal-strength meter, and a simulated acoustic beep (`audioplayers`) / haptic pulse (`HapticFeedback`).
- Accepts an IMEI, phone model, or student matricule as input to look up matching found-item records.
- Clearly labeled in-app as a **simulated visualization for demonstration purposes** — it does not perform real remote device tracking, since this app cannot run on the lost device itself. Its actual function is to cross-reference the found-item database and present the result with an engaging radar-style animation.

### 3.6 QR Tag Scanning (Security staff)
- A dedicated scanner screen (`mobile_scanner`) for staff to scan an item's physical QR tag and instantly open its record, update its status, or log a hand-off.

---

## 4. Build, Signing & Distribution

- Standard Flutter project setup (`pubspec.yaml`, `analysis_options.yaml`), ready to run via `flutter run` and open in Android Studio, VS Code, or Xcode.
- Instructions for generating a signed release **Android APK/AAB** (`flutter build apk` / `flutter build appbundle`, keystore creation, `key.properties` signing config) and a signed **iOS build** (`flutter build ipa`, Xcode signing/provisioning).
- Steps for **direct APK sideloading** for offline academic demos: enabling "Install unknown apps" per-app on Android 8+, transferring the APK via USB/cloud link, and installing without a Play Store account.
- Optional guidance for publishing to the **Play Console Internal Testing track** and **TestFlight** for wider, lower-friction distribution.
- Adaptive Android app icon + iOS app icon set (via `flutter_launcher_icons`) and a native splash screen (via `flutter_native_splash`) with graceful fallback across platforms.

---

## 5. Educational Backend Reference (Academic Value)

An expandable in-app reference screen titled **"Backend Architecture"**, showing:
- Production-ready **Python FastAPI** route definitions the Flutter app's `dio`/`http` client talks to.
- **SQLite/PostgreSQL** relational schema (items, users, claims) with an ER diagram.
- A sequence diagram of a typical claim flow (report → claim → verification → approval → return), so students can explain or defend the full-stack architecture during university reviews.

---

## 6. Design & UI Guidelines

- Visual style: Dark Slate palette (`#0f172a` / `#020617`) with royal blue (`#2563eb`) primary accents and emerald green (`#10b981`) success states, expressed through a Flutter `ColorScheme` (Material 3 `ColorScheme.fromSeed`) with matching light and dark themes.
- Material 3 typography scale (Google Sans / Roboto pairing via `google_fonts`), accessible contrast meeting **WCAG AA**.
- Rounded corners (12–16dp) on cards via `ShapeBorder`/`RoundedRectangleBorder`, subtle elevation instead of heavy borders, smooth `Hero`/`PageRouteBuilder` transitions between screens.
- Full support for **edge-to-edge display**, gesture navigation, and system UI overlay styling (`SystemChrome`).
- Layouts responsive across phone sizes and foldables/tablets using `LayoutBuilder`/`MediaQuery` breakpoints, with iOS-appropriate adaptations where relevant (`Cupertino` fallbacks if targeting iOS parity).

---

## 7. Non-Functional Requirements

- **Accessibility:** full TalkBack (Android) and VoiceOver (iOS) support via `Semantics` widgets, scalable text respecting system font size (`MediaQuery.textScaleFactor`).
- **Offline-first:** all core actions (viewing, reporting, drafting claims) work without connectivity and sync automatically once online, using local-first state with background reconciliation.
- **Security & privacy:** verification answers encrypted at rest (`flutter_secure_storage`); least-privilege runtime permission requests (camera, location, notifications) via `permission_handler`, each with a clear rationale dialog before prompting.
- **Testing:** unit tests for repositories/state notifiers, widget tests for individual screens, `integration_test` for critical end-to-end flows (report → claim → approval).
- **Performance:** lazy-loaded/paginated lists (`ListView.builder`), paginated API calls, and image compression on upload (`flutter_image_compress`).
