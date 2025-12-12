import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const primaryBlue = Color(0xFF005CBB);

  return ThemeData(
    primaryColor: primaryBlue,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryBlue),
    scaffoldBackgroundColor: const Color(0xFFF4F6FA),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    useMaterial3: true,
  );
}
