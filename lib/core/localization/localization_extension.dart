import 'package:flutter/widgets.dart';
import 'package:marsa/l10n/app_localizations.dart';

/// Extension on BuildContext to provide clean, concise access to localized strings.
///
/// Eliminates raw text literals and guarantees compile-time check for all UI copy.
/// Usage: `context.l10n.appName`
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
