# CampusLost

CampusLost is an offline-first Flutter application for reporting, matching, verifying, and returning lost property on a university campus. It uses Material 3, Riverpod, a repository layer, Drift/SQLite, secure storage, GoRouter, biometrics/PIN gating, and QR vault tags.

## Run locally

Requirements: latest stable Flutter, Android SDK (API 26+), or Xcode 15+ for iOS.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

The database is seeded with demo records on first launch. The Admin Review Desk tries device authentication and falls back to academic demo PIN `2468` when biometrics are unavailable.

### Run locally in a browser

```powershell
flutter run -d chrome --web-hostname=127.0.0.1 --web-port=7357
```

To use an already open browser, run `flutter run -d web-server --web-hostname=127.0.0.1 --web-port=7357` and open http://127.0.0.1:7357. Keep that terminal running. Use the same address and port to retain access to the same browser database.

The browser target runs the same Flutter screens and repositories. Drift uses SQLite WebAssembly with browser-local persistent storage; Android and iOS continue to use native SQLite. The included `web/sqlite3.wasm` and `web/drift_worker.js` are the matching assets from the official [Drift 2.34.4 release](https://github.com/simolus3/drift/releases/tag/drift-2.34.4). Upgrade both assets together when changing Drift. Web photos are saved with their report instead of retaining a temporary upload URL. Biometrics are platform-dependent; the browser demo uses the existing staff PIN fallback.

On the current Windows host, the Android emulator reports a missing hardware acceleration driver and the Windows C++ desktop compiler is unavailable. Use a USB-connected Android phone or the browser target. The Android build script below handles the Java temporary-socket issue that previously stopped Gradle from starting.

## Architecture

- `lib/core`: domain models and design system
- `lib/data`: Drift database and repository implementation
- `lib/providers`: Riverpod dependency injection and derived state
- `lib/features`: route-level UI modules
- `lib/router`: declarative routes and deep links

Writes are committed to SQLite first and marked pending sync. The repository exposes reactive streams to the UI. Private proof is stored separately through platform secure storage. `connectivity_plus` powers network status; `markSynced` is the local demo seam for a future Dio synchronization service. The Backend tab includes FastAPI routes, an ER diagram, and the claim sequence.

## Android release and signing

For a local ARM64 debug APK on Windows:

```powershell
.\scripts\build-android.ps1
adb devices -l
adb -s DEVICE_SERIAL install --user 0 -r build\app\outputs\flutter-apk\app-debug.apk
adb -s DEVICE_SERIAL shell am start --user 0 -n com.smartcampus.campus_lost/.MainActivity
```

Replace `DEVICE_SERIAL` with the authorized device serial from `adb devices -l`. Unlock the phone and accept its USB debugging prompt. `--user 0` installs to the main Android profile, avoiding vendor clone-profile permission errors. Installation with `-r` preserves an existing app's data when its signing key matches.

The script places Java's temporary sockets in `build/java-sockets` for that command and restores the prior environment afterward. It defaults to ARM64; select `-TargetPlatform android-arm` or `android-x64` when needed. `dynamic_color` is pinned to 1.8.1 because the 1.9.0 Android Kotlin Gradle script failed with this project's AGP 8 setup.

Create a keystore outside source control:

```bash
keytool -genkeypair -v -keystore campuslost-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Add `android/key.properties` (never commit it) with `storePassword`, `keyPassword`, `keyAlias`, and `storeFile`, then configure the release signing block in `android/app/build.gradle.kts`. Build artifacts with:

```bash
flutter build apk --release
flutter build appbundle --release
```

For an offline academic demo on Android 8+, transfer `build/app/outputs/flutter-apk/app-release.apk`, allow **Install unknown apps** for the file manager or browser used to open it, then tap the APK. No Play Store account is required. For managed distribution, upload the AAB to Play Console Internal Testing.

## iOS distribution

Open `ios/Runner.xcworkspace`, select a development team and unique bundle identifier, then configure signing/provisioning in Xcode. Build with `flutter build ipa --release`. Upload the resulting archive through Xcode Organizer or Transporter for TestFlight. A Mac with Xcode and an Apple Developer account is required for signed `.ipa` output.

## Production integrations

Before deployment, provide Firebase platform files and initialize Firebase Messaging; connect the repository sync seam to the documented FastAPI API with Dio; schedule retries through Workmanager/background fetch; replace the demo staff fallback PIN with server-issued staff credentials; and add server-side push/device registration. Runtime permission prompts should be preceded by institution-specific rationale copy.

## Quality checks

```bash
flutter analyze
flutter test
flutter test integration_test
```

Core UI includes semantic labels, scalable text, large touch targets, light/dark themes, dynamic Android colors, and layouts that expand cleanly on phones and tablets.
