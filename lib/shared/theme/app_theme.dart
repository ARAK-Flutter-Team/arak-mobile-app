import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // ================================
  // 🌞 LIGHT COLOR SCHEME
  // ================================
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: Color(0xFF1877F2),
    onPrimary: Colors.white,

    secondary: Color(0xFF42B0FF),
    onSecondary: Colors.white,

    tertiary: Color(0xFF0B2545),
    onTertiary: Colors.white,

    error: Color(0xFFED1A1A),
    onError: Colors.white,

    background: Colors.white,
    onBackground: Colors.black,

    surface: Colors.white,
    onSurface: Colors.black,

    surfaceVariant: Color(0xFFF1F3F5),
    onSurfaceVariant: Color(0xFF6C757D),

    outline: Color(0xFFE0E0E0),

    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Colors.black,
    onInverseSurface: Colors.white,
    inversePrimary: Color(0xFF42B0FF),
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.background,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: lightColorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightColorScheme.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightColorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightColorScheme.primary),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  // ================================
  // 🌙 DARK COLOR SCHEME
  // ================================
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    primary: Color(0xFF42B0FF),
    onPrimary: Colors.black,

    secondary: Color(0xFF1877F2),
    onSecondary: Colors.black,

    tertiary: Color(0xFF90CAF9),
    onTertiary: Colors.black,

    error: Color(0xFFFF6B6B),
    onError: Colors.black,

    // 👇 خلفية سوداء
    background: Color(0xFF121212),
    onBackground: Colors.white,

    // 👇 الكروت أفتح
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,

    // 👇 الفيلدز
    surfaceVariant: Color(0xFF2A2A2A),
    onSurfaceVariant: Color(0xFFB0B0B0),

    outline: Color(0xFF2C2C2C),

    shadow: Colors.black,
    scrim: Colors.black,
    inverseSurface: Colors.white,
    onInverseSurface: Colors.black,
    inversePrimary: Color(0xFF1877F2),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    scaffoldBackgroundColor: darkColorScheme.background,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
    ),

    cardTheme: CardThemeData(
      color: darkColorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkColorScheme.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkColorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkColorScheme.primary),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}