import 'package:flutter/material.dart';

import 'app_appearance.dart';

ThemeData buildAppTheme(AppAppearance appearance) {
  final colors = appearance;
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: colors.background,
    colorScheme: ColorScheme(
      brightness: colors == AppAppearance.nuln
          ? Brightness.dark
          : Brightness.light,
      primary: colors.accent,
      onPrimary: colors.onAccent,
      secondary: colors.accent,
      onSecondary: colors.onAccent,
      error: colors == AppAppearance.nuln
          ? const Color(0xFFF0A0A8)
          : const Color(0xFFA32732),
      onError: colors.onAccent,
      surface: colors.surface,
      onSurface: colors.primaryText,
      outline: colors.border,
    ),
    textTheme: TextTheme(
      headlineMedium: TextStyle(
        color: colors.primaryText,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: colors.primaryText,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: colors.primaryText,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: colors.primaryText),
      bodyMedium: TextStyle(color: colors.secondaryText),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.background,
      foregroundColor: colors.primaryText,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.border),
      ),
    ),
  );
}
