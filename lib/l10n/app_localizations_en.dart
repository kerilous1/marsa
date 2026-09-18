// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'MARSA';

  @override
  String get slogan => 'Capture. Route. Keep. — More than just sharing';

  @override
  String get catDocs => 'Official Docs';

  @override
  String get catDocsSub => 'IDs, licenses, certificates';

  @override
  String get catReadLater => 'Read Later';

  @override
  String get catReadLaterSub => 'Articles, posts, links';

  @override
  String get catQuickNotes => 'Quick Notes';

  @override
  String get catQuickNotesSub => 'Snippets, accounts, ideas';

  @override
  String get catTempVault => 'Temp Vault';

  @override
  String get catTempVaultSub => 'Auto-purged after 72h';

  @override
  String get copyNationalId => 'Copy National ID';

  @override
  String get nationalIdCopied => 'National ID copied to clipboard';

  @override
  String get searchPlaceholder => 'Search docs, links, notes...';

  @override
  String get saving => 'Saving...';

  @override
  String get savedSuccessfully => 'Saved successfully';

  @override
  String get saveFailed => 'Failed to save, please retry';

  @override
  String get requiresReview => 'Requires Review';

  @override
  String get delete => 'Delete';

  @override
  String get share => 'Share';

  @override
  String get moveCategory => 'Move Category';

  @override
  String get emptyVaultTitle => 'Vault is currently empty';

  @override
  String get emptyVaultSubtitle =>
      'Share any content from any app to find it here instantly';
}
