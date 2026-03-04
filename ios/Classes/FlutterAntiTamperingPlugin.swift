import Flutter
import UIKit

public class FlutterAntiTamperingPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_anti_tampering", binaryMessenger: registrar.messenger())
    let instance = FlutterAntiTamperingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "checkDeviceIntegrity":
      DeviceIntegrityService.checkDeviceIntegrity(
        result: result,
        params: call
      )
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
