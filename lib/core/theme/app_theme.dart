import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static const seed = Color(0xFF2563EB);

  static ThemeData light(ColorScheme? dynamic) =>
      _theme(dynamic ?? ColorScheme.fromSeed(seedColor: seed));

  static ThemeData dark(ColorScheme? dynamic) => _theme(
    dynamic ??
        ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
  );

  static ThemeData _theme(ColorScheme scheme) {
    final colors = scheme.copyWith(
      primary: seed,
      onPrimary: Colors.white,
      secondary: const Color(0xFF10B981),
      surface: scheme.brightness == Brightness.dark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colors,
      scaffoldBackgroundColor: scheme.brightness == Brightness.dark
          ? const Color(0xFF020617)
          : const Color(0xFFF1F5F9),
      textTheme: GoogleFonts.interTextTheme(
        ThemeData(brightness: colors.brightness).textTheme,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
