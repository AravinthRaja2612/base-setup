import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn/infrastructure/services/navigation_service.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';
class AppConfig {
  // Singleton instance
  static AppConfig? _instance;

  // Configuration fields
  final String flavour;
  final String appName;
  final String versionName;
  final int versionCode;

  // Private constructor
  AppConfig._internal({
    required this.flavour,
    required this.appName,
    required this.versionName,
    required this.versionCode,
  });

  /// Factory constructor ensures only one instance
  factory AppConfig.init({
    required String flavour,
    required String appName,
    required String versionName,
    required int versionCode,
  }) {
    _instance ??= AppConfig._internal(
      flavour: flavour,
      appName: appName,
      versionName: versionName,
      versionCode: versionCode,
    );

    return _instance!;
  }

  /// Access the singleton instance safely anywhere
  static AppConfig get instance {
    if (_instance == null) {
      throw Exception('AppConfig not initialized! Call AppConfig.init() first.');
    }
    return _instance!;
  }

  /// Optional helper to initialize and run the app
  static void initializeAndRunApp({
    required String flavour,
    required String appName,
    required String versionName,
    required int versionCode,
    required Widget app,
  }) {
    AppConfig.init(
      flavour: flavour,
      appName: appName,
      versionName: versionName,
      versionCode: versionCode,
    );
    runApp(app);
  }
}




class MyApp extends StatelessWidget {



  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final config = AppConfig.instance;

    return MaterialApp.router(
      title: config.appName,
      routerConfig: router.config(),
      scaffoldMessengerKey: rootScaffoldMessengerKey, // for global snackbars
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Auto-switch (light/dark)
      theme: lightNeonTheme(context),
      darkTheme: darkNeonTheme(context),

    );
  }
}

 const MethodChannel _iconChannel = MethodChannel('com.example.flutter_learn/icon');

Future<void> setAndroidIcon(String alias) async {
  try {
    if (Platform.isAndroid) {
      await _iconChannel.invokeMethod('setIcon', {'alias': alias});
    }
  } on PlatformException catch (e) {
    print('Error changing icon: ${e.message}');
  }
}

Future<void> checkDateAndSetIcon() async {
  final now = DateTime.now();

  if (now.month == 12 && now.day == 25) {
    await setAndroidIcon('christmas');
  } else if (now.month == 1 && now.day == 1) {
    await setAndroidIcon('newyear');
  } else {
    await setAndroidIcon('');
  }
}