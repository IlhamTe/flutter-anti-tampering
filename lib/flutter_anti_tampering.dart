import 'dart:io';
import 'package:flutter/services.dart';

/// A service that checks whether the application has been tampered with
/// or modified on the current device.
///
/// This plugin performs integrity verification using platform-specific
/// mechanisms:
///
/// - **Android** → Verifies the app signing certificate using SHA-256.
/// - **iOS** → Uses `IOSSecuritySuite` to detect bundle tampering.
///
/// Example usage:
///
/// ```dart
/// final isSecure = await DeviceIntegrityService.instance.isDeviceHasIntegrity(
///   androidSignature: "your_sha256_signature",
///   iosBundleId: "com.example.app",
/// );
///
/// if (!isSecure) {
///   // App might be tampered
/// }
/// ```

class FlutterAntiTampering {
  FlutterAntiTampering._();

  static const MethodChannel _channel = MethodChannel('flutter_anti_tampering');

  /// Check whether the app/device integrity is valid
  static Future<bool> isDeviceSecure({
    required String androidSignature,
    required String iosBundleId,
  }) async {
    const method = 'checkDeviceIntegrity';

    final params = <String, dynamic>{
      if (Platform.isIOS) "bundleId": iosBundleId,
      if (Platform.isAndroid) "signature": androidSignature,
    };

    try {
      final result = await _channel.invokeMethod(method, params);
      return result == true;
    } catch (_) {
      return false;
    }
  }
}
