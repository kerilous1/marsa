import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the application runtime locale with system-aware defaults and local persistence.
///
/// On first launch (no saved preference), reads the OS system locale:
///   - Arabic system → Arabic app locale
///   - Any other language → English app locale
/// After the user explicitly chooses a language, that choice persists across cold boots.
class LocaleCubit extends Cubit<Locale> {
  final SharedPreferences? _prefs;
  static const String _prefLocaleKey = 'language_code';
  static const String _prefAltLocaleKey = 'marsa_locale';

  LocaleCubit({SharedPreferences? prefs, Locale? initialLocale})
      : _prefs = prefs,
        super(initialLocale ?? _resolveInitialLocale(prefs));

  /// Resolves locale: saved preference > system locale > English fallback.
  static Locale _resolveInitialLocale(SharedPreferences? prefs) {
    // 1. Check for explicitly saved user preference
    final saved = prefs?.getString(_prefLocaleKey) ?? prefs?.getString(_prefAltLocaleKey);
    if (saved == 'en') return const Locale('en');
    if (saved == 'ar') return const Locale('ar');

    // 2. No saved preference → read system locale from OS
    return _resolveSystemLocale();
  }

  /// Detects the OS locale, matching any Arabic dialect (ar, ar-EG, ar-SA, etc.) to 'ar',
  /// and all other languages to 'en'.
  static Locale _resolveSystemLocale() {
    final systemLocales = ui.PlatformDispatcher.instance.locales;
    if (systemLocales.isNotEmpty) {
      for (final l in systemLocales) {
        if (l.languageCode.toLowerCase().startsWith('ar')) {
          return const Locale('ar');
        }
      }
    }
    final systemLocale = ui.PlatformDispatcher.instance.locale;
    if (systemLocale.languageCode.toLowerCase().startsWith('ar')) {
      return const Locale('ar');
    }

    return const Locale('en');
  }

  /// Whether the user has explicitly chosen and persisted a language.
  bool get hasUserExplicitPreference {
    final saved = _prefs?.getString(_prefLocaleKey) ?? _prefs?.getString(_prefAltLocaleKey);
    return saved == 'en' || saved == 'ar';
  }

  /// Called when the OS language configuration changes at runtime.
  void onSystemLocalesChanged(List<Locale>? locales) {
    if (!hasUserExplicitPreference) {
      if (locales != null && locales.isNotEmpty) {
        for (final l in locales) {
          if (l.languageCode.toLowerCase().startsWith('ar')) {
            emit(const Locale('ar'));
            return;
          }
        }
      }
      emit(const Locale('en'));
    }
  }

  Future<void> _persist(String code) async {
    try {
      final p = _prefs ?? await SharedPreferences.getInstance();
      await p.setString(_prefLocaleKey, code);
      await p.setString(_prefAltLocaleKey, code);
    } catch (_) {}
  }

  /// Switches active locale to Arabic (RTL).
  void setArabic() {
    emit(const Locale('ar'));
    _persist('ar');
  }

  /// Switches active locale to English (LTR).
  void setEnglish() {
    emit(const Locale('en'));
    _persist('en');
  }

  /// Toggles between Arabic and English.
  void toggleLocale() {
    if (state.languageCode == 'ar') {
      setEnglish();
    } else {
      setArabic();
    }
  }
}
