import 'package:flutter/material.dart';

/// 🎨 App color constants for both themes
class AppColors {
  // 🌞 Light theme colors
  static const Color lightPrimary = Color(0xFF5C6BC0); // Indigo
  static const Color lightAccent = Color(0xFF00BCD4); // Cyan/Turquoise accent
  static const Color lightBackground = Color(0xFFFAFAFA); // Lighter background
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Colors.black87;
  static const Color lightTextSecondary = Colors.black54;
  static const Color lightError = Colors.red;

  // 🌚 Dark theme colors (future use)
  static const Color darkPrimary = Color(0xFF1E1E1E); // Charcoal
  static const Color darkAccent = Color(0xFF64B5F6); // Soft blue highlight
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1F1F1F);
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Colors.white70;
  static const Color darkError = Color(0xFFEF5350);
}

/// 💡 Active Light Theme
ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
      bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
      titleLarge: TextStyle(
        color: AppColors.lightTextPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),

    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightAccent,
      surface: AppColors.lightSurface,
      error: AppColors.lightError,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
  );
}

/// 🌙 Dark Theme (defined but not active yet)
ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkAccent,
      foregroundColor: Colors.black,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
      titleLarge: TextStyle(
        color: AppColors.darkTextPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkAccent,
      surface: AppColors.darkSurface,
      error: AppColors.darkError,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
  );
}
