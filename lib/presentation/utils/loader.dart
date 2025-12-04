

import 'package:flutter/material.dart';
import 'package:flutter_learn/infrastructure/services/navigation_service.dart';
import 'package:flutter_learn/presentation/appcommon_things/app_color.dart';

/// A simple global loader utility
class GlobalLoader {
  static bool _isShowing = false;

  /// Show a blocking loader dialog
  static void show({String? message}) {
    final context = router.navigatorKey.currentContext;
    if (context == null || _isShowing) return;

    _isShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (_) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceColor(context),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primaryColor(context).withOpacity(0.6),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor(context).withOpacity(0.25),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primaryColor(context),
                  strokeWidth: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  message ?? 'Loading...',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimaryColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Hide the loader dialog
  static void hide() {
    if (!_isShowing) return;
    final context = router.navigatorKey.currentContext;
    if (context == null) return;

    Navigator.of(context, rootNavigator: true).pop();
    _isShowing = false;
  }
}
