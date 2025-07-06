import 'package:flutter/material.dart';

class AppConfig {
  static const String appName = 'Random Quote Generator';
  static const String appVersion = '1.0.0';
  
  // Theme Configuration
  static ThemeData get lightTheme {
    const Color primaryColor = Color(0xFF4B2EFF); // Deep blue/purple
    const Color accentColor = Color(0xFFFFD600); // Bright yellow
    const Color backgroundColor = Color(0xFFF8F9FB); // Very light gray
    const Color textColor = Color(0xFF222222); // Dark gray/black

    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: accentColor,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        background: backgroundColor,
        onBackground: textColor,
        surface: Colors.white,
        onSurface: textColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: primaryColor,
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 12,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        titleLarge: TextStyle(
          color: primaryColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: primaryColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      iconTheme: const IconThemeData(color: primaryColor, size: 32),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentColor,
        foregroundColor: Colors.black,
      ),
    );
  }
  
  // API Configuration
  static const int apiTimeout = 30; // seconds
  static const int maxRetries = 3;
} 