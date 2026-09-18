import 'package:flutter/material.dart';

/// Centralized compile-time constant color tokens extracted from MARSA brand identity.
///
/// Designed to support both Light and OLED-friendly Dark surfaces without
/// hardcoded color values anywhere in the presentation layer.
abstract final class AppColors {
  // Brand Palette
  static const Color primaryGreen = Color(0xFF25D366);
  static const Color darkGreen = Color(0xFF128C7E);
  static const Color lightGreenBg = Color(0xFFE8F5EE);
  static const Color textDark = Color(0xFF111B1F);
  static const Color surfaceWhite = Color(0xFFFFFFFF);

  // Status & Utility Colors
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color pendingAmber = Color(0xFFF59E0B);

  // Dark Mode Tokens (OLED Friendly)
  static const Color darkScaffoldBg = Color(0xFF0B141A);
  static const Color darkCardBg = Color(0xFF111B21);
  static const Color darkBorder = Color(0xFF202C33);
  static const Color textLight = Color(0xFFE9EDEF);
  static const Color textMuted = Color(0xFF8696A0);
}

/// Backward compatibility alias for MarsaColors.
typedef MarsaColors = AppColors;
