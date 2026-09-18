import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Builds the unified MaterialApp [ThemeData] using MARSA brand tokens.
///
/// Uses Cairo font (Google Fonts) for full Arabic support with a 4-weight
/// hierarchy: Regular 400, Medium 500, Semi-Bold 600, Bold 700.
///
/// All color assignments reference [MarsaColors] — no raw hex values.
abstract final class MarsaTheme {
  /// Light theme for the MARSA application.
  ///
  /// Designed to match the brand identity guide with emerald green accents,
  /// high-contrast dark text, and clean white surfaces.
  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.cairoTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // -- Color Scheme --
      colorScheme: ColorScheme.fromSeed(
        seedColor: MarsaColors.primaryGreen,
        brightness: Brightness.light,
        primary: MarsaColors.primaryGreen,
        secondary: MarsaColors.darkGreen,
        surface: MarsaColors.surfaceWhite,
        onSurface: MarsaColors.textDark,
        error: MarsaColors.errorRed,
      ),

      // -- Scaffold --
      scaffoldBackgroundColor: MarsaColors.surfaceWhite,

      // -- App Bar --
      appBarTheme: AppBarTheme(
        backgroundColor: MarsaColors.darkGreen,
        foregroundColor: MarsaColors.surfaceWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: MarsaColors.surfaceWhite,
        ),
      ),

      // -- Tab Bar --
      tabBarTheme: TabBarThemeData(
        labelColor: MarsaColors.surfaceWhite,
        unselectedLabelColor: MarsaColors.surfaceWhite.withAlpha(178),
        indicatorColor: MarsaColors.primaryGreen,
        labelStyle: GoogleFonts.cairo(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),

      // -- Floating Action Button --
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: MarsaColors.primaryGreen,
        foregroundColor: MarsaColors.surfaceWhite,
        elevation: 4,
        shape: CircleBorder(),
      ),

      // -- Cards --
      cardTheme: CardThemeData(
        color: MarsaColors.surfaceWhite,
        elevation: 1,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: MarsaColors.divider, width: 0.5),
        ),
      ),

      // -- Bottom Sheet --
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: MarsaColors.lightGreenBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        showDragHandle: true,
        dragHandleColor: MarsaColors.darkGreen,
      ),

      // -- Input Decoration --
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MarsaColors.lightGreenBg,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: GoogleFonts.cairo(
          color: MarsaColors.textSecondary,
          fontSize: 14,
        ),
      ),

      // -- Divider --
      dividerTheme: const DividerThemeData(
        color: MarsaColors.divider,
        thickness: 0.5,
        space: 0,
      ),

      // -- Text Theme --
      textTheme: baseTextTheme.copyWith(
        // Display — used for splash/branding screens
        displayLarge: GoogleFonts.cairo(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: MarsaColors.textDark,
        ),
        // Headline — used for screen titles
        headlineMedium: GoogleFonts.cairo(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: MarsaColors.textDark,
        ),
        // Title — used for card headers and section titles
        titleLarge: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: MarsaColors.textDark,
        ),
        titleMedium: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: MarsaColors.textDark,
        ),
        // Body — used for primary content text
        bodyLarge: GoogleFonts.cairo(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: MarsaColors.textDark,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: MarsaColors.textDark,
        ),
        // Label — used for buttons, chips, metadata badges
        labelLarge: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: MarsaColors.surfaceWhite,
        ),
        labelSmall: GoogleFonts.cairo(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: MarsaColors.textSecondary,
        ),
      ),
    );
  }
}
