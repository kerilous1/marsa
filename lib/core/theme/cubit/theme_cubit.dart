import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the application theme mode (system, light, dark) with local persistence.
///
/// Ensures reactive switching across the UI without application restart and
/// persists choice across cold boots.
class ThemeCubit extends Cubit<ThemeMode> {
  final SharedPreferences? _prefs;
  static const String _prefThemeKey = 'theme_mode';

  ThemeCubit({SharedPreferences? prefs, ThemeMode? initialMode})
      : _prefs = prefs,
        super(initialMode ?? _resolveInitialMode(prefs));

  static ThemeMode _resolveInitialMode(SharedPreferences? prefs) {
    final saved = prefs?.getString(_prefThemeKey);
    if (saved == 'dark') return ThemeMode.dark;
    if (saved == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }

  Future<void> _persist(ThemeMode mode) async {
    try {
      final p = _prefs ?? await SharedPreferences.getInstance();
      final str = mode == ThemeMode.dark
          ? 'dark'
          : mode == ThemeMode.light
              ? 'light'
              : 'system';
      await p.setString(_prefThemeKey, str);
    } catch (_) {}
  }

  /// Toggles to explicit light theme mode.
  void setLight() {
    emit(ThemeMode.light);
    _persist(ThemeMode.light);
  }

  /// Toggles to explicit OLED-friendly dark theme mode.
  void setDark() {
    emit(ThemeMode.dark);
    _persist(ThemeMode.dark);
  }

  /// Resets theme to track OS system preferences.
  void setSystem() {
    emit(ThemeMode.system);
    _persist(ThemeMode.system);
  }

  /// Toggles between light and dark modes directly.
  void toggleTheme() {
    if (state == ThemeMode.dark) {
      setLight();
    } else {
      setDark();
    }
  }
}

