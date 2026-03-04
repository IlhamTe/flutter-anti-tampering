import 'package:flutter/material.dart';
import 'package:flutter_anti_tampering/flutter_anti_tampering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDeviceSecure = true;

  void _checkDeviceIntegrity() async {
    _isDeviceSecure = await FlutterAntiTampering.isDeviceSecure(
      androidSignature:
          'e47c1b656e879f2960c88b4a582a6b0a70aa07a85795b2ae96fa97f24b9eb565',
      iosBundleId: 'com.example.flutterAntiTamperingExample',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Test Flutter Anti Tampering')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: [
              Text('Is Device Secure : $_isDeviceSecure'),
              FilledButton(
                onPressed: _checkDeviceIntegrity,
                child: Text('Check Tampering'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
