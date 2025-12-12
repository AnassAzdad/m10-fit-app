import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  // Kleuren (neon + dark)
  const background = Color(0xFF050816); // Donkere achtergrond
  const surface = Color(0xFF0B1020);    // Kaart-achtergrond
  const neonCyan = Color(0xFF00F5FF);
  const neonPurple = Color(0xFF9B5CFF);

  final base = ThemeData.dark();

  return base.copyWith(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    colorScheme: base.colorScheme.copyWith(
      primary: neonCyan,
      secondary: neonPurple,
      background: background,
      surface: surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: neonCyan,
        foregroundColor: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface.withOpacity(0.8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.15),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(
          color: neonCyan,
          width: 1.5,
        ),
      ),
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.7),
      ),
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.5),
      ),
    ),
    textTheme: base.textTheme.copyWith(
      headlineSmall: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white.withOpacity(0.85),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF050816),
      selectedItemColor: neonCyan,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
