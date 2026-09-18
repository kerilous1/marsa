import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the application theme mode (system, light, dark).
///
/// Ensures reactive switching across the UI without application restart.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({ThemeMode initialMode = ThemeMode.system}) : super(initialMode);

  /// Toggles to explicit light theme mode.
  void setLight() => emit(ThemeMode.light);

  /// Toggles to explicit OLED-friendly dark theme mode.
  void setDark() => emit(ThemeMode.dark);

  /// Resets theme to track OS system preferences.
  void setSystem() => emit(ThemeMode.system);

  /// Toggles between light and dark modes directly.
  void toggleTheme() {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.dark);
    }
  }
}
