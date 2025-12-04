import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_learn/application/router/app_router.gr.dart';
import 'package:flutter_learn/infrastructure/services/navigation_service.dart';
import 'package:flutter_learn/presentation/utils/loader.dart';
import 'package:flutter_learn/presentation/viewmodel/login/login_state.dart';
import 'package:flutter_learn/presentation/viewmodel/view_model.dart';
import 'package:local_auth/local_auth.dart';

class LoginViewModel extends ViewModel<LoginState> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  final LocalAuthentication auth = LocalAuthentication();
  String _authorizedStatus = 'Not authorized';
  bool _isAuthenticating = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  LoginViewModel() : super(LoginState());

  /// Check and authenticate the user
  Future<void> authenticateUser() async {
    bool isAuthenticated = false;

    try {
      final bool canCheck = await auth.canCheckBiometrics;
      final bool isSupported = await auth.isDeviceSupported();

      if (!canCheck || !isSupported) {
        NavigationService.showGlobalSnackBar('Not supported on this device');
        return;
      }
      // Get available biometric types
      final biometrics = await auth.getAvailableBiometrics();
      debugPrint('Available biometrics: $biometrics');
      _isAuthenticating = true;
      _authorizedStatus = 'Authenticating...';
      // Trigger biometric authentication
      isAuthenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to continue',
          biometricOnly: true,
          persistAcrossBackgrounding: true,
          sensitiveTransaction: true);

      if (isAuthenticated) {
        NavigationService.pushAndPopUntil(HomeRoute());
      } else {
        NavigationService.showGlobalSnackBar('Authentication failed');
      }

      _isAuthenticating = false;
      _authorizedStatus =
          isAuthenticated ? 'Authorized ✅' : 'Authentication failed ❌';
    } on PlatformException catch (e) {
      NavigationService.showGlobalSnackBar('${e.message}');
      debugPrint('Error during authentication: ${e.message}');
      _isAuthenticating = false;
    } catch (e) {
      debugPrint('Error during authentication: $e');
      NavigationService.showGlobalSnackBar('Error during authentication');
    }
  }

  void handleBioLogin() {
    NavigationService.push(DashboardRoute());
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      GlobalLoader.show(message: 'Loading...');
      await Future.delayed(Duration(seconds: 3));
      GlobalLoader.hide();
    });
  }

  Future<void> _login() async {
    GlobalLoader.show(message: 'Loading...');
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ✅ If login succeeded
      if (authResult.user != null) {
        print('object');

        NavigationService.pushAndPopUntil(const DashboardRoute());
      } else {
        _showError('Login failed');
      }

    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Login failed');
    } finally {
      GlobalLoader.hide();
      updateState(state.copyWith(isLoading: false));
    }
  }

  void _showError(String message) {
    NavigationService.showGlobalSnackBar(message,background: Colors.redAccent,);
  }

  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      NavigationService.showGlobalSnackBar('Please fill in all fields',background: Colors.redAccent,);
      return;
    }

    _login();
    // TODO: Replace with your real login logic
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: const Text('Login successful'),
    //     backgroundColor: AppColors.primaryColor(context),
    //   ),
    // );
  }

}
