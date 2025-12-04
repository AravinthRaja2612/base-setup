

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/application/router/app_router.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();


AppRouter router = AppRouter();


class NavigationService {
  static BuildContext? get _context => router.navigatorKey.currentContext;

  static Future<void> push(PageRouteInfo route) async {
    await router.push(route);
  }
  static Future<void> pushAndPopUntil(PageRouteInfo route) async {
    await router.pushAndPopUntil(route, predicate: (Route<dynamic> route) { return false; });
  }

 static Future<void> showGlobalSnackBar(String message, {Color? background}) async {
    final context = router.navigatorKey.currentContext; // optional use
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: AppColors.textPrimaryColor(context!),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: background ?? AppColors.surfaceColor(context),
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.primaryColor(context).withValues(alpha: 0.7),
            width: 1.2,
          ),
        ),
        elevation: 8,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Future<void> showDialogBox(String title, String message) async {
    if (_context == null) return;
    await showDialog(
      context: _context!,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(_context!),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
