# 🛡️ AntiTampering

A Flutter plugin to detect app integrity and prevent tampering on **Android** and **iOS**.

Built for apps that need stronger security such as fintech, enterprise, and high-risk mobile environments.

---

## ✨ Features

* 🔐 Android APK signature verification
* 🍏 iOS bundle integrity check (IOSSecuritySuite)
* ⚡ Simple async Dart API
* 🧩 Works with Flutter 3+

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  anti_tampering: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Usage

Import the package:

```dart
import 'package:anti_tampering/anti_tampering.dart';
```

---

### ✅ Check Device Integrity

```dart
final isSecure = await AntiTampering.isDeviceSecure(
  androidSignature: 'YOUR_SHA256_NO_COLON',
  iosBundleId: 'com.example.app',
);

print('Is secure: $isSecure');
```

**Expected behavior**

| Condition            | Result  |
| -------------------- | ------- |
| Original app         | ✅ true  |
| Re-signed / tampered | ❌ false |

---

## 🤖 Android Setup

### Minimum requirements

* minSdkVersion ≥ 21
* Google Play services available
* Play Store installed on device

---

### Get SHA-256 signature

Run:

```bash
keytool -list -v \
-alias androiddebugkey \
-keystore ~/.android/debug.keystore \
-storepass android \
-keypass android
```

Convert the SHA-256 to:

* lowercase
* remove `:`

Example:

```
AB:CD:EF → abcdef
```

---

## 🍏 iOS Setup

### Requirements

* iOS 12.0+
* Real device recommended for testing

The plugin uses **IOSSecuritySuite** internally.

---

### Get Bundle ID

Open:

```
ios/Runner.xcworkspace → Runner → General → Bundle Identifier
```

Example:

```
com.example.app
```

Use that value in Dart.

---

## 🤝 Contributing

PRs and issues are welcome.

---

## 📄 License

MIT License.
