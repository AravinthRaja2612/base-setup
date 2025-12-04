import 'package:flutter/material.dart';

class AppColors {
  ///  Brand Colors
  static const Color _primary = Color(0xFF00FFFF); // Neon Cyan
  static const Color _secondary = Color(0xFF9D00FF); // Neon Purple
  static const Color _accent = Color(0xFF6C63FF); // Blue Violet Glow

  ///  Light Mode Colors
  static const Color _lightBackground = Color(0xFFF9FAFB);
  static const Color _lightSurface = Color(0xFFFFFFFF);
  static const Color _lightTextPrimary = Color(0xFF0D0D0D);
  static const Color _lightTextSecondary = Color(0xFF4A4A4A);

  ///  Dark Mode Colors
  static const Color _darkBackground = Color(0xFF0D0D0D);
  static const Color _darkSurface = Color(0xFF1A1A1A);
  static const Color _darkTextPrimary = Color(0xFFEAEAEA);
  static const Color _darkTextSecondary = Color(0xFFB3B3B3);

  ///  Common helper
  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  ///  Adaptive getters
  static Color primaryColor(BuildContext context) => _primary;

  static Color secondaryColor(BuildContext context) => _secondary;

  static Color accentColor(BuildContext context) => _accent;

  static Color backgroundColor(BuildContext context) =>
      _isDark(context) ? _darkBackground : _lightBackground;

  static Color surfaceColor(BuildContext context) =>
      _isDark(context) ? _darkSurface : _lightSurface;

  static Color textPrimaryColor(BuildContext context) =>
      _isDark(context) ? _darkTextPrimary : _lightTextPrimary;

  static Color textSecondaryColor(BuildContext context) =>
      _isDark(context) ? _darkTextSecondary : _lightTextSecondary;

  static Color cardColor(BuildContext context) => surfaceColor(context);

  static Color dividerColor(BuildContext context) =>
      _isDark(context) ? Colors.grey.shade800 : Colors.grey.shade300;

  static Color iconColor(BuildContext context) => textSecondaryColor(context);

  static Color hintTextColor(BuildContext context) =>
      textSecondaryColor(context).withValues(alpha: 0.7);

  static Color disabledColor(BuildContext context) =>
      textSecondaryColor(context).withValues(alpha:0.5);
}

/// Helper to get InputDecorationTheme dynamically
InputDecorationTheme getAppInputDecorationTheme(BuildContext context) {
  // final Color textPrimary = AppColors.textPrimaryColor(context);
  final Color textSecondary = AppColors.textSecondaryColor(context);
  final Color surface = AppColors.surfaceColor(context);
  final Color primary = AppColors.primaryColor(context);
  // final Color secondary = AppColors.secondaryColor(context);

  return InputDecorationTheme(
    labelStyle: TextStyle(color: textSecondary),
    floatingLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      color: primary,
    ),
    helperStyle: TextStyle(
      color: textSecondary.withValues(alpha:0.8),
      fontSize: 12,
    ),
    hintStyle: TextStyle(
      color: textSecondary.withValues(alpha:0.6),
    ),
    errorStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 12,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    iconColor: primary,
    prefixIconColor: primary,
    suffixIconColor: primary,
    filled: true,
    fillColor: surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: textSecondary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: textSecondary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.redAccent, width: 2),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: textSecondary.withValues(alpha:0.4), width: 1),
    ),
  );
}

/// Text themes (now use context for dynamic colors)
TextTheme appTextTheme(BuildContext context) {
  final color = AppColors.textPrimaryColor(context);
  final colorSecondary = AppColors.textSecondaryColor(context);

  return TextTheme(
    displayLarge:
        TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: color),
    displayMedium:
        TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: color),
    displaySmall:
        TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color),
    headlineLarge:
        TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
    headlineMedium:
        TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
    headlineSmall:
        TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
    titleLarge:
        TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
    titleMedium:
        TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color),
    titleSmall:
        TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    bodyLarge: TextStyle(fontSize: 16, color: color),
    bodyMedium: TextStyle(fontSize: 14, color: colorSecondary),
    bodySmall: TextStyle(fontSize: 12, color: colorSecondary),
    labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor(context)),
    labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor(context)),
    labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor(context)),
  );
}

///  Dark Theme
ThemeData darkNeonTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundColor(context),
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryColor(context),
        secondary: AppColors.secondaryColor(context),
        surface: AppColors.surfaceColor(context),
        onPrimary: AppColors.backgroundColor(context),
        onSecondary: AppColors.backgroundColor(context),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceColor(context),
        foregroundColor: AppColors.textPrimaryColor(context),
        elevation: 0,
      ),
      textTheme: appTextTheme(context),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor(context),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      inputDecorationTheme: getAppInputDecorationTheme(context),
    );

/// ️ Light Theme
ThemeData lightNeonTheme(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundColor(context),
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor(context),
        secondary: AppColors.secondaryColor(context),
        surface: AppColors.surfaceColor(context),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceColor(context),
        foregroundColor: AppColors.textPrimaryColor(context),
        elevation: 0,
      ),
      textTheme: appTextTheme(context),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor(context),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      inputDecorationTheme: getAppInputDecorationTheme(context),
    );
