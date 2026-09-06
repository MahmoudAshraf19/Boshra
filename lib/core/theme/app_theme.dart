import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'IBMPlexSansArabic',
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        primaryContainer: AppColors.lightPrimaryDark,
        secondary: AppColors.lightGoldenAccent,
        secondaryContainer: AppColors.lightTerracottaAccent,
        surface: AppColors.lightSurface,
        error: AppColors.lightError,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightPrimaryDark,
        onSurfaceVariant: AppColors.lightPrimaryDark,
        onError: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightPrimaryDark),
        bodyMedium: TextStyle(color: AppColors.lightPrimaryDark),
        titleLarge: TextStyle(color: AppColors.lightPrimaryDark),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'IBMPlexSansArabic',
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        primaryContainer: AppColors.darkPrimaryDark,
        secondary: AppColors.darkGoldenAccent,
        secondaryContainer: AppColors.darkTerracottaAccent,
        surface: AppColors.darkSurface,
        surfaceContainerHighest: AppColors.darkElevatedSurface,
        error: AppColors.darkError,
        onPrimary: AppColors.darkBackground,
        onSecondary: AppColors.darkBackground,
        onSurface: AppColors.darkMainText,
        onError: Colors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkMainText),
        bodyMedium: TextStyle(color: AppColors.darkSecondaryText),
        titleLarge: TextStyle(color: AppColors.darkMainText),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
      ),
      useMaterial3: true,
    );
  }
}
