import Foundation
import Flutter
import IOSSecuritySuite

class DeviceIntegrityService {
    static func checkDeviceIntegrity(
    result: @escaping FlutterResult, params: FlutterMethodCall
    ) {
        if let args = params.arguments as? [String: Any],
        let bundleId = args["bundleId"] as? String {

            let isTampered = IOSSecuritySuite.amITampered([.bundleID(bundleId)]).result

            // If isTampered == true → return false (Means the device is TAMPERED)
            // If isTampered == false → return true (Means the device is NOT TAMPERED)
            result(!isTampered)
        } else {
            result(FlutterError(code: "INVALID_ARGS", message: "Missing bundleId", details: nil))
        }
    }
}