import 'package:flutter/material.dart';

/// Centralized color tokens extracted from the MARSA brand identity guide.
///
/// These colors are defined as static constants for compile-time safety
/// and consistent usage across all widgets. Do NOT use raw hex values
/// elsewhere in the codebase — always reference [MarsaColors].
///
/// Color palette source: images/MARSA_Logo.png
abstract final class MarsaColors {
  /// Primary interactive green — used for FAB, save buttons, success indicators.
  static const Color primaryGreen = Color(0xFF25D366);

  /// Dark green accent — used for app bar, active tabs, high-priority cards.
  static const Color darkGreen = Color(0xFF128C7E);

  /// Light green background — used for BottomSheet surfaces, category tiles.
  static const Color lightGreenBg = Color(0xFFE8F5EE);

  /// Dark heading text — used for primary headings and high-contrast body text.
  static const Color textDark = Color(0xFF111B1F);

  /// Surface white — used for cards, input fields, modal sheet backgrounds.
  static const Color surfaceWhite = Color(0xFFFFFFFF);

  /// Subtle grey for secondary text, timestamps, and metadata labels.
  static const Color textSecondary = Color(0xFF6B7280);

  /// Light divider color for card borders and separators.
  static const Color divider = Color(0xFFE5E7EB);

  /// Error / warning red for failed OCR or invalid data indicators.
  static const Color errorRed = Color(0xFFEF4444);

  /// Pending status amber for items awaiting background processing.
  static const Color pendingAmber = Color(0xFFF59E0B);
}
