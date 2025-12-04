
import 'package:flutter/material.dart';
import 'package:flutter_learn/application/appconfig/app_config.dart';
import 'package:flutter_learn/infrastructure/services/firebase_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  checkDateAndSetIcon();
  FirebaseInitializer.init();
  /// Option 1: Initialize + run together
  AppConfig.initializeAndRunApp(
    flavour: 'dev',
    appName: 'Learn App',
    versionName: '1.0.0',
    versionCode: 1,
    app: const MyApp(),
  );


}

