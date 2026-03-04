package com.example.flutter_anti_tampering

import android.content.Context
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayInputStream
import java.security.MessageDigest
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate

class DeviceIntegrityService(private var context: Context) {

    fun checkDeviceIntegrity(call: MethodCall, result: MethodChannel.Result) {
        try {
            val expectedSignature: String = call.argument<String>("signature") ?: ""
            val hasIntegrity = verifyAppSignature(expectedSignature =expectedSignature )
            result.success(hasIntegrity)
        } catch (e: Exception) {
            result.error("Integrity", e.message, null)

        }
    }

    private fun verifyAppSignature(expectedSignature: String): Boolean {

        val packageInfo = context.packageManager.getPackageInfo(
            context.packageName,
            PackageManager.GET_SIGNING_CERTIFICATES
        )
        val signatures = packageInfo?.signingInfo?.apkContentsSigners
        if (signatures != null) {
            for (signature in signatures) {
                val cert = CertificateFactory.getInstance("X509")
                    .generateCertificate(ByteArrayInputStream(signature.toByteArray())) as X509Certificate
                val md = MessageDigest.getInstance("SHA-256")
                val publicKeyHash = md.digest(cert.encoded).joinToString("") { "%02x".format(it) }
                if (publicKeyHash.equals(expectedSignature, ignoreCase = true)) {
                    return true // Signature matches
                }
            }
        }
        return false // Signature did not match
    }
}
