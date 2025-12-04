import 'package:flutter_learn/application/appconfig/app_config.dart';



void main() {

  /// Option 1: Initialize + run together
  AppConfig.initializeAndRunApp(
    flavour: 'LIVE',
    appName: 'Learn App',
    versionName: '1.0.0',
    versionCode: 1,
    app: const MyApp(),
  );

  /// Option 2 (Alternative): Initialize first, run manually
  /*
  AppConfig.init(
    flavour: 'prod',
    appName: 'Learn App',
    versionName: '1.0.0',
    versionCode: 1,
  );
  runApp(const MyApp());
  */
}

