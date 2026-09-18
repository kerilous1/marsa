import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the application runtime locale (Arabic default, English secondary).
///
/// Supports dynamic switching between RTL and LTR layouts without app restart.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({Locale initialLocale = const Locale('ar')}) : super(initialLocale);

  /// Switches active locale to Arabic (RTL).
  void setArabic() => emit(const Locale('ar'));

  /// Switches active locale to English (LTR).
  void setEnglish() => emit(const Locale('en'));

  /// Toggles between Arabic and English.
  void toggleLocale() {
    if (state.languageCode == 'ar') {
      emit(const Locale('en'));
    } else {
      emit(const Locale('ar'));
    }
  }
}
