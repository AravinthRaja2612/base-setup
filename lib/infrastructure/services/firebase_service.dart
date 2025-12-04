import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_learn/firebase_options.dart';

/// Common Firebase initialization used for all flavors.
class FirebaseInitializer {
  static bool _initialized = false;

  /// Initialize Firebase only once
  static Future<void> init() async {
    if (_initialized) return; // avoid double initialization

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _initialized = true;
    print('✅ Firebase initialized successfully!');
  }
}
