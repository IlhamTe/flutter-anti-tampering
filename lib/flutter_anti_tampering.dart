import 'dart:io';
import 'package:flutter/services.dart';

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
