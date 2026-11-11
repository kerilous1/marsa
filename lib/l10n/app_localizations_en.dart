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

  @override
  String get onboarding1Title => 'Stop WhatsApp Self-Chat';

  @override
  String get onboarding1Desc =>
      'No more sending IDs, links, and quick notes to yourself in messy messaging threads.';

  @override
  String get onboarding2Title => 'Sub-500ms Instant Capture';

  @override
  String get onboarding2Desc =>
      'From browser, Facebook, or photos — MARSA floats over your active app and routes your content in a split second.';

  @override
  String get onboarding3Title => '100% Local & Device Secured';

  @override
  String get onboarding3Desc =>
      'Zero cloud leaks, zero third-party servers. Your personal records are securely stored and isolated on-device in sandboxed storage.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'Next';

  @override
  String get vaultLocked => 'Vault is Locked';

  @override
  String get vaultLockedSubtitle =>
      'Please authenticate to unlock your private local vault';

  @override
  String get unlockWithBiometrics => 'Unlock with Biometrics';

  @override
  String get usePinFallback => 'Use PIN Code';

  @override
  String get authFailed => 'Authentication failed, please try again';

  @override
  String get manageCategories => 'Manage Categories';

  @override
  String get addCategory => 'Add New Category';

  @override
  String get editCategory => 'Edit Category';

  @override
  String get deleteCategory => 'Delete Category';

  @override
  String get categoryNameAr => 'Category Name (Arabic)';

  @override
  String get categoryNameEn => 'Category Name (English)';

  @override
  String get selectIcon => 'Select Icon';

  @override
  String get selectColor => 'Select Color';

  @override
  String get cannotDeleteSystemCategory =>
      'System categories cannot be deleted';

  @override
  String get securitySettings => 'Security & Lock Settings';

  @override
  String get enableBiometrics => 'Enable Biometric Lock';

  @override
  String get autoLockImmediate => 'Lock immediately when app is backgrounded';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirmDelete => 'Are you sure you want to delete this category?';

  @override
  String get systemCategoryBadge => 'System';

  @override
  String get autoPurgeBadge => 'Auto-purge (72h)';

  @override
  String get linkCopiedSuccessfully => 'Link copied to clipboard';

  @override
  String get couldNotLaunchUrl => 'Could not open URL';

  @override
  String deleteCategoryCascadeWarning(int count) {
    return 'This category contains $count item(s). What would you like to do with its content?';
  }

  @override
  String get moveToTempVault => 'Move to Temp Vault (72h Retention)';

  @override
  String get deleteAllItems => 'Delete Category & All Items Permanently';

  @override
  String get categoryDeleted => 'Category deleted successfully';

  @override
  String get categoryMigrated => 'Items migrated and category deleted';

  @override
  String get noCategoriesTitle => 'No Vaults Configured';

  @override
  String get noCategoriesSubtitle =>
      'Create your first custom vault or pick a quick suggestion below.';

  @override
  String get createFirstCategory => 'Create New Vault';

  @override
  String get quickSuggestions => 'Quick Suggestions';

  @override
  String get tabVaults => 'Vaults';

  @override
  String get tabSearch => 'Search';

  @override
  String get tabSettings => 'Settings';

  @override
  String get permissionsPromptTitle => 'MARSA Privacy & Permissions';

  @override
  String get permissionsPromptDesc =>
      'MARSA is 100% local-first with zero cloud servers. These permissions are needed exclusively on-device.';

  @override
  String get continueAction => 'Continue';

  @override
  String get enablePinLock => 'Enable PIN Lock';

  @override
  String get setPinCode => 'Set PIN Code';

  @override
  String get changePinCode => 'Change PIN Code';

  @override
  String get enterPinToUnlock => 'Enter PIN to Unlock';

  @override
  String get enterNewPin => 'Enter 4-digit PIN';

  @override
  String get confirmPin => 'Confirm PIN';

  @override
  String get pinMismatch => 'PINs do not match';

  @override
  String get incorrectPin => 'Incorrect PIN, please try again';

  @override
  String get pinSetSuccess => 'PIN set successfully';

  @override
  String get quickCaptureTitle => 'Quick Capture';

  @override
  String get quickCaptureHint => 'Paste link or type note...';

  @override
  String get welcomeSubtitle => 'Your private on-device vault';

  @override
  String get unlock => 'Unlock';

  @override
  String get categoryNameHint => 'Vault name';

  @override
  String get tourNext => 'Next';

  @override
  String get tourSkip => 'Skip';

  @override
  String get tourFinish => 'Get Started';

  @override
  String tourStepCounter(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get tourStepSearchTitle => 'Instant Vault Search';

  @override
  String get tourStepSearchDesc =>
      'Search across all saved links, notes, and records in milliseconds with offline FTS5 engine.';

  @override
  String get tourStepVaultsTitle => 'Dynamic Vault Categories';

  @override
  String get tourStepVaultsDesc =>
      'Swipe between your categories, where links, images, documents, and notes are neatly separated.';

  @override
  String get tourStepLinksTitle => 'Smart Content Interaction';

  @override
  String get tourStepLinksDesc =>
      'Tap any card to view details or open links, or long-press for quick actions like copying or sharing.';

  @override
  String get tourStepFabTitle => 'Instant Fast Capture (+)';

  @override
  String get tourStepFabDesc =>
      'Jot down quick thoughts, paste copied links, or save files anytime in sub-seconds.';

  @override
  String get tourStepNavTitle => 'Fluid Bottom Navigation';

  @override
  String get tourStepNavDesc =>
      'Switch effortlessly between your vaults, instant search, and app settings.';

  @override
  String get tourStepShareTitle => 'The Real Superpower: External Share';

  @override
  String get tourStepShareDesc =>
      'Share any link, photo, or document from external apps (WhatsApp, browser..) to MARSA directly in the background!';

  @override
  String get tourStepSettingsTitle => 'Settings & 100% Privacy';

  @override
  String get tourStepSettingsDesc =>
      'Customize theme and language, and inspect our 100% local-first zero-cloud privacy policy.';

  @override
  String get settingsTourTile => 'App Walkthrough Tour';

  @override
  String get settingsTourTileDesc =>
      'Learn how to use MARSA and master its quick gestures';

  @override
  String get privacyPolicyTitle => 'Privacy & Security Policy';

  @override
  String get privacyPolicySubtitle =>
      '100% Local-First with Zero Cloud & Zero Tracking';

  @override
  String get privacyPolicyLocalHeading => '100% On-Device (Zero-Cloud)';

  @override
  String get privacyPolicyLocalDesc =>
      'All your links, documents, images, and notes are stored exclusively on your device within sandboxed app storage. Not a single byte is uploaded to any external server.';

  @override
  String get privacyPolicyZeroDataHeading => 'Zero Tracking & Zero Ads';

  @override
  String get privacyPolicyZeroDataDesc =>
      'MARSA contains zero telemetry, zero analytics, and zero advertising SDKs. We collect zero identifiable information.';

  @override
  String get privacyPolicyStorageHeading => 'Total Data Ownership';

  @override
  String get privacyPolicyStorageDesc =>
      'You can edit, export, or delete any record at any time. Uninstalling the app permanently erases all data from your device.';

  @override
  String get permissionsTransparencyTitle => 'App Permissions Transparency';

  @override
  String get permissionsTransparencyDesc =>
      'Clear and honest explanation of permissions used by MARSA';

  @override
  String get permShareSheetTitle => 'Content Reception';

  @override
  String get permShareSheetDesc =>
      'MARSA only receives content when you explicitly share it via the official Android Share Sheet without needing full storage access.';

  @override
  String get permUrlLauncherTitle => 'Opening Links in Browser';

  @override
  String get permUrlLauncherDesc =>
      'Used to open your saved links in your preferred external browser upon clicking.';

  @override
  String get permNoSensorsTitle => 'Zero Sensitive Permissions';

  @override
  String get permNoSensorsDesc =>
      'No biometric, camera, location, or contacts permissions are requested or used. Your security is absolute.';

  @override
  String get expiryNotificationTitle => 'MARSA Temp Vault Alert';

  @override
  String expiryNotificationBody(String itemTitle) {
    return '«$itemTitle» will be permanently deleted in 1 hour!';
  }

  @override
  String get ttlBadgeUrgent => '< 1h left (Purging Soon)';

  @override
  String get ocrProcessing => 'Processing document data...';

  @override
  String get ocrRequiresReview => 'Requires review (Tap to edit)';

  @override
  String get ocrCompleted => 'Data extracted successfully';

  @override
  String get editNationalId => 'Edit National ID';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get documentPreview => 'Document Preview';

  @override
  String get rawOcrText => 'Extracted Text';

  @override
  String get enterNationalIdHint => 'Enter 14-digit National ID';

  @override
  String get nationalIdLabel => 'Egyptian National ID';

  @override
  String get enrichmentPending => 'Fetching link details...';

  @override
  String get linkEnriched => 'Link details loaded';

  @override
  String get thumbnailsCache => 'Link Thumbnails Cache';

  @override
  String get clearThumbnails => 'Clear Thumbnails';

  @override
  String get thumbnailsCleared => 'Thumbnail cache cleared';

  @override
  String get openInBrowser => 'Open in browser';

  @override
  String get backupAndRestore => 'Encrypted Backup & Security';

  @override
  String get exportBackup => 'Export Encrypted Backup (.marsa)';

  @override
  String get exportBackupDesc =>
      'Save full vault into a password-protected offline file';

  @override
  String get importBackup => 'Restore from Backup';

  @override
  String get importBackupDesc => 'Import and securely decrypt a previous vault';

  @override
  String get enterBackupPassword => 'Enter Backup Password';

  @override
  String get confirmBackupPassword => 'Confirm Password';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get backupExportSuccess => 'Encrypted backup created successfully';

  @override
  String get backupImportSuccess => 'Vault restored successfully';

  @override
  String get invalidBackupPassword => 'Incorrect password or corrupted file';
}
