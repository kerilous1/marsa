import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Produces Light and Dark ThemeData for MARSA adhering to Material 3 standards.
///
/// Uses GoogleFonts.cairo for clean Arabic and English typographic balance.
abstract final class MarsaTheme {
  /// Enterprise Light Theme adhering to Material 3 and MARSA brand guidelines.
  static ThemeData get lightTheme {
    final baseLight = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.surfaceWhite,
      cardColor: AppColors.lightGreenBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryGreen,
        secondary: AppColors.darkGreen,
        surface: AppColors.surfaceWhite,
        onSurface: AppColors.textDark,
        outline: AppColors.divider,
        error: AppColors.errorRed,
      ),
    );

    return baseLight.copyWith(
      textTheme: GoogleFonts.cairoTextTheme(baseLight.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surfaceWhite,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        centerTitle: true,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        modalBackgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  /// OLED-Friendly Dark Theme designed for battery preservation and high contrast.
  static ThemeData get darkTheme {
    final baseDark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkScaffoldBg,
      cardColor: AppColors.darkCardBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryGreen,
        secondary: AppColors.darkGreen,
        surface: AppColors.darkCardBg,
        onSurface: AppColors.textLight,
        outline: AppColors.darkBorder,
        error: AppColors.errorRed,
      ),
    );

    return baseDark.copyWith(
      textTheme: GoogleFonts.cairoTextTheme(baseDark.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkScaffoldBg,
        foregroundColor: AppColors.textLight,
        elevation: 0,
        centerTitle: true,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        modalBackgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
