import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'MARSA'**
  String get appName;

  /// No description provided for @slogan.
  ///
  /// In en, this message translates to:
  /// **'Capture. Route. Keep. — More than just sharing'**
  String get slogan;

  /// No description provided for @catDocs.
  ///
  /// In en, this message translates to:
  /// **'Official Docs'**
  String get catDocs;

  /// No description provided for @catDocsSub.
  ///
  /// In en, this message translates to:
  /// **'IDs, licenses, certificates'**
  String get catDocsSub;

  /// No description provided for @catReadLater.
  ///
  /// In en, this message translates to:
  /// **'Read Later'**
  String get catReadLater;

  /// No description provided for @catReadLaterSub.
  ///
  /// In en, this message translates to:
  /// **'Articles, posts, links'**
  String get catReadLaterSub;

  /// No description provided for @catQuickNotes.
  ///
  /// In en, this message translates to:
  /// **'Quick Notes'**
  String get catQuickNotes;

  /// No description provided for @catQuickNotesSub.
  ///
  /// In en, this message translates to:
  /// **'Snippets, accounts, ideas'**
  String get catQuickNotesSub;

  /// No description provided for @catTempVault.
  ///
  /// In en, this message translates to:
  /// **'Temp Vault'**
  String get catTempVault;

  /// No description provided for @catTempVaultSub.
  ///
  /// In en, this message translates to:
  /// **'Auto-purged after 72h'**
  String get catTempVaultSub;

  /// No description provided for @copyNationalId.
  ///
  /// In en, this message translates to:
  /// **'Copy National ID'**
  String get copyNationalId;

  /// No description provided for @nationalIdCopied.
  ///
  /// In en, this message translates to:
  /// **'National ID copied to clipboard'**
  String get nationalIdCopied;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search docs, links, notes...'**
  String get searchPlaceholder;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get savedSuccessfully;

  /// No description provided for @saveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save, please retry'**
  String get saveFailed;

  /// No description provided for @requiresReview.
  ///
  /// In en, this message translates to:
  /// **'Requires Review'**
  String get requiresReview;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @moveCategory.
  ///
  /// In en, this message translates to:
  /// **'Move Category'**
  String get moveCategory;

  /// No description provided for @emptyVaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Vault is currently empty'**
  String get emptyVaultTitle;

  /// No description provided for @emptyVaultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share any content from any app to find it here instantly'**
  String get emptyVaultSubtitle;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Stop WhatsApp Self-Chat'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Desc.
  ///
  /// In en, this message translates to:
  /// **'No more sending IDs, links, and quick notes to yourself in messy messaging threads.'**
  String get onboarding1Desc;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Sub-500ms Instant Capture'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Desc.
  ///
  /// In en, this message translates to:
  /// **'From browser, Facebook, or photos — MARSA floats over your active app and routes your content in a split second.'**
  String get onboarding2Desc;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'100% Local & Device Secured'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Desc.
  ///
  /// In en, this message translates to:
  /// **'Zero cloud leaks, zero third-party servers. Your personal records are securely stored and isolated on-device in sandboxed storage.'**
  String get onboarding3Desc;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @vaultLocked.
  ///
  /// In en, this message translates to:
  /// **'Vault is Locked'**
  String get vaultLocked;

  /// No description provided for @vaultLockedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please authenticate to unlock your private local vault'**
  String get vaultLockedSubtitle;

  /// No description provided for @unlockWithBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Unlock with Biometrics'**
  String get unlockWithBiometrics;

  /// No description provided for @usePinFallback.
  ///
  /// In en, this message translates to:
  /// **'Use PIN Code'**
  String get usePinFallback;

  /// No description provided for @authFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed, please try again'**
  String get authFailed;

  /// No description provided for @manageCategories.
  ///
  /// In en, this message translates to:
  /// **'Manage Categories'**
  String get manageCategories;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add New Category'**
  String get addCategory;

  /// No description provided for @editCategory.
  ///
  /// In en, this message translates to:
  /// **'Edit Category'**
  String get editCategory;

  /// No description provided for @deleteCategory.
  ///
  /// In en, this message translates to:
  /// **'Delete Category'**
  String get deleteCategory;

  /// No description provided for @categoryNameAr.
  ///
  /// In en, this message translates to:
  /// **'Category Name (Arabic)'**
  String get categoryNameAr;

  /// No description provided for @categoryNameEn.
  ///
  /// In en, this message translates to:
  /// **'Category Name (English)'**
  String get categoryNameEn;

  /// No description provided for @selectIcon.
  ///
  /// In en, this message translates to:
  /// **'Select Icon'**
  String get selectIcon;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get selectColor;

  /// No description provided for @cannotDeleteSystemCategory.
  ///
  /// In en, this message translates to:
  /// **'System categories cannot be deleted'**
  String get cannotDeleteSystemCategory;

  /// No description provided for @securitySettings.
  ///
  /// In en, this message translates to:
  /// **'Security & Lock Settings'**
  String get securitySettings;

  /// No description provided for @enableBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Enable Biometric Lock'**
  String get enableBiometrics;

  /// No description provided for @autoLockImmediate.
  ///
  /// In en, this message translates to:
  /// **'Lock immediately when app is backgrounded'**
  String get autoLockImmediate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this category?'**
  String get confirmDelete;

  /// No description provided for @systemCategoryBadge.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemCategoryBadge;

  /// No description provided for @autoPurgeBadge.
  ///
  /// In en, this message translates to:
  /// **'Auto-purge (72h)'**
  String get autoPurgeBadge;

  /// No description provided for @linkCopiedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Link copied to clipboard'**
  String get linkCopiedSuccessfully;

  /// No description provided for @couldNotLaunchUrl.
  ///
  /// In en, this message translates to:
  /// **'Could not open URL'**
  String get couldNotLaunchUrl;

  /// No description provided for @deleteCategoryCascadeWarning.
  ///
  /// In en, this message translates to:
  /// **'This category contains {count} item(s). What would you like to do with its content?'**
  String deleteCategoryCascadeWarning(int count);

  /// No description provided for @moveToTempVault.
  ///
  /// In en, this message translates to:
  /// **'Move to Temp Vault (72h Retention)'**
  String get moveToTempVault;

  /// No description provided for @deleteAllItems.
  ///
  /// In en, this message translates to:
  /// **'Delete Category & All Items Permanently'**
  String get deleteAllItems;

  /// No description provided for @categoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Category deleted successfully'**
  String get categoryDeleted;

  /// No description provided for @categoryMigrated.
  ///
  /// In en, this message translates to:
  /// **'Items migrated and category deleted'**
  String get categoryMigrated;

  /// No description provided for @noCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'No Vaults Configured'**
  String get noCategoriesTitle;

  /// No description provided for @noCategoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your first custom vault or pick a quick suggestion below.'**
  String get noCategoriesSubtitle;

  /// No description provided for @createFirstCategory.
  ///
  /// In en, this message translates to:
  /// **'Create New Vault'**
  String get createFirstCategory;

  /// No description provided for @quickSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Quick Suggestions'**
  String get quickSuggestions;

  /// No description provided for @tabVaults.
  ///
  /// In en, this message translates to:
  /// **'Vaults'**
  String get tabVaults;

  /// No description provided for @tabSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get tabSearch;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @permissionsPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'MARSA Privacy & Permissions'**
  String get permissionsPromptTitle;

  /// No description provided for @permissionsPromptDesc.
  ///
  /// In en, this message translates to:
  /// **'MARSA is 100% local-first with zero cloud servers. These permissions are needed exclusively on-device.'**
  String get permissionsPromptDesc;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @enablePinLock.
  ///
  /// In en, this message translates to:
  /// **'Enable PIN Lock'**
  String get enablePinLock;

  /// No description provided for @setPinCode.
  ///
  /// In en, this message translates to:
  /// **'Set PIN Code'**
  String get setPinCode;

  /// No description provided for @changePinCode.
  ///
  /// In en, this message translates to:
  /// **'Change PIN Code'**
  String get changePinCode;

  /// No description provided for @enterPinToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Enter PIN to Unlock'**
  String get enterPinToUnlock;

  /// No description provided for @enterNewPin.
  ///
  /// In en, this message translates to:
  /// **'Enter 4-digit PIN'**
  String get enterNewPin;

  /// No description provided for @confirmPin.
  ///
  /// In en, this message translates to:
  /// **'Confirm PIN'**
  String get confirmPin;

  /// No description provided for @pinMismatch.
  ///
  /// In en, this message translates to:
  /// **'PINs do not match'**
  String get pinMismatch;

  /// No description provided for @incorrectPin.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN, please try again'**
  String get incorrectPin;

  /// No description provided for @pinSetSuccess.
  ///
  /// In en, this message translates to:
  /// **'PIN set successfully'**
  String get pinSetSuccess;

  /// No description provided for @quickCaptureTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Capture'**
  String get quickCaptureTitle;

  /// No description provided for @quickCaptureHint.
  ///
  /// In en, this message translates to:
  /// **'Paste link or type note...'**
  String get quickCaptureHint;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your private on-device vault'**
  String get welcomeSubtitle;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @categoryNameHint.
  ///
  /// In en, this message translates to:
  /// **'Vault name'**
  String get categoryNameHint;

  /// No description provided for @tourNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get tourNext;

  /// No description provided for @tourSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tourSkip;

  /// No description provided for @tourFinish.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get tourFinish;

  /// No description provided for @tourStepCounter.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String tourStepCounter(int current, int total);

  /// No description provided for @tourStepSearchTitle.
  ///
  /// In en, this message translates to:
  /// **'Instant Vault Search'**
  String get tourStepSearchTitle;

  /// No description provided for @tourStepSearchDesc.
  ///
  /// In en, this message translates to:
  /// **'Search across all saved links, notes, and records in milliseconds with offline FTS5 engine.'**
  String get tourStepSearchDesc;

  /// No description provided for @tourStepVaultsTitle.
  ///
  /// In en, this message translates to:
  /// **'Dynamic Vault Categories'**
  String get tourStepVaultsTitle;

  /// No description provided for @tourStepVaultsDesc.
  ///
  /// In en, this message translates to:
  /// **'Swipe between your categories, where links, images, documents, and notes are neatly separated.'**
  String get tourStepVaultsDesc;

  /// No description provided for @tourStepLinksTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Content Interaction'**
  String get tourStepLinksTitle;

  /// No description provided for @tourStepLinksDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap any card to view details or open links, or long-press for quick actions like copying or sharing.'**
  String get tourStepLinksDesc;

  /// No description provided for @tourStepFabTitle.
  ///
  /// In en, this message translates to:
  /// **'Instant Fast Capture (+)'**
  String get tourStepFabTitle;

  /// No description provided for @tourStepFabDesc.
  ///
  /// In en, this message translates to:
  /// **'Jot down quick thoughts, paste copied links, or save files anytime in sub-seconds.'**
  String get tourStepFabDesc;

  /// No description provided for @tourStepNavTitle.
  ///
  /// In en, this message translates to:
  /// **'Fluid Bottom Navigation'**
  String get tourStepNavTitle;

  /// No description provided for @tourStepNavDesc.
  ///
  /// In en, this message translates to:
  /// **'Switch effortlessly between your vaults, instant search, and app settings.'**
  String get tourStepNavDesc;

  /// No description provided for @tourStepShareTitle.
  ///
  /// In en, this message translates to:
  /// **'The Real Superpower: External Share'**
  String get tourStepShareTitle;

  /// No description provided for @tourStepShareDesc.
  ///
  /// In en, this message translates to:
  /// **'Share any link, photo, or document from external apps (WhatsApp, browser..) to MARSA directly in the background!'**
  String get tourStepShareDesc;

  /// No description provided for @tourStepSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & 100% Privacy'**
  String get tourStepSettingsTitle;

  /// No description provided for @tourStepSettingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Customize theme and language, and inspect our 100% local-first zero-cloud privacy policy.'**
  String get tourStepSettingsDesc;

  /// No description provided for @settingsTourTile.
  ///
  /// In en, this message translates to:
  /// **'App Walkthrough Tour'**
  String get settingsTourTile;

  /// No description provided for @settingsTourTileDesc.
  ///
  /// In en, this message translates to:
  /// **'Learn how to use MARSA and master its quick gestures'**
  String get settingsTourTileDesc;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicySubtitle.
  ///
  /// In en, this message translates to:
  /// **'100% Local-First with Zero Cloud & Zero Tracking'**
  String get privacyPolicySubtitle;

  /// No description provided for @privacyPolicyLocalHeading.
  ///
  /// In en, this message translates to:
  /// **'100% On-Device (Zero-Cloud)'**
  String get privacyPolicyLocalHeading;

  /// No description provided for @privacyPolicyLocalDesc.
  ///
  /// In en, this message translates to:
  /// **'All your links, documents, images, and notes are stored exclusively on your device within sandboxed app storage. Not a single byte is uploaded to any external server.'**
  String get privacyPolicyLocalDesc;

  /// No description provided for @privacyPolicyZeroDataHeading.
  ///
  /// In en, this message translates to:
  /// **'Zero Tracking & Zero Ads'**
  String get privacyPolicyZeroDataHeading;

  /// No description provided for @privacyPolicyZeroDataDesc.
  ///
  /// In en, this message translates to:
  /// **'MARSA contains zero telemetry, zero analytics, and zero advertising SDKs. We collect zero identifiable information.'**
  String get privacyPolicyZeroDataDesc;

  /// No description provided for @privacyPolicyStorageHeading.
  ///
  /// In en, this message translates to:
  /// **'Total Data Ownership'**
  String get privacyPolicyStorageHeading;

  /// No description provided for @privacyPolicyStorageDesc.
  ///
  /// In en, this message translates to:
  /// **'You can edit, export, or delete any record at any time. Uninstalling the app permanently erases all data from your device.'**
  String get privacyPolicyStorageDesc;

  /// No description provided for @permissionsTransparencyTitle.
  ///
  /// In en, this message translates to:
  /// **'App Permissions Transparency'**
  String get permissionsTransparencyTitle;

  /// No description provided for @permissionsTransparencyDesc.
  ///
  /// In en, this message translates to:
  /// **'Clear and honest explanation of permissions used by MARSA'**
  String get permissionsTransparencyDesc;

  /// No description provided for @permShareSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Content Reception'**
  String get permShareSheetTitle;

  /// No description provided for @permShareSheetDesc.
  ///
  /// In en, this message translates to:
  /// **'MARSA only receives content when you explicitly share it via the official Android Share Sheet without needing full storage access.'**
  String get permShareSheetDesc;

  /// No description provided for @permUrlLauncherTitle.
  ///
  /// In en, this message translates to:
  /// **'Opening Links in Browser'**
  String get permUrlLauncherTitle;

  /// No description provided for @permUrlLauncherDesc.
  ///
  /// In en, this message translates to:
  /// **'Used to open your saved links in your preferred external browser upon clicking.'**
  String get permUrlLauncherDesc;

  /// No description provided for @permNoSensorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Zero Sensitive Permissions'**
  String get permNoSensorsTitle;

  /// No description provided for @permNoSensorsDesc.
  ///
  /// In en, this message translates to:
  /// **'No biometric, camera, location, or contacts permissions are requested or used. Your security is absolute.'**
  String get permNoSensorsDesc;

  /// No description provided for @expiryNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'MARSA Temp Vault Alert'**
  String get expiryNotificationTitle;

  /// No description provided for @expiryNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'«{itemTitle}» will be permanently deleted in 1 hour!'**
  String expiryNotificationBody(String itemTitle);

  /// No description provided for @ttlBadgeUrgent.
  ///
  /// In en, this message translates to:
  /// **'< 1h left (Purging Soon)'**
  String get ttlBadgeUrgent;

  /// No description provided for @ocrProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing document data...'**
  String get ocrProcessing;

  /// No description provided for @ocrRequiresReview.
  ///
  /// In en, this message translates to:
  /// **'Requires review (Tap to edit)'**
  String get ocrRequiresReview;

  /// No description provided for @ocrCompleted.
  ///
  /// In en, this message translates to:
  /// **'Data extracted successfully'**
  String get ocrCompleted;

  /// No description provided for @editNationalId.
  ///
  /// In en, this message translates to:
  /// **'Edit National ID'**
  String get editNationalId;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @documentPreview.
  ///
  /// In en, this message translates to:
  /// **'Document Preview'**
  String get documentPreview;

  /// No description provided for @rawOcrText.
  ///
  /// In en, this message translates to:
  /// **'Extracted Text'**
  String get rawOcrText;

  /// No description provided for @enterNationalIdHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 14-digit National ID'**
  String get enterNationalIdHint;

  /// No description provided for @nationalIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Egyptian National ID'**
  String get nationalIdLabel;

  /// No description provided for @enrichmentPending.
  ///
  /// In en, this message translates to:
  /// **'Fetching link details...'**
  String get enrichmentPending;

  /// No description provided for @linkEnriched.
  ///
  /// In en, this message translates to:
  /// **'Link details loaded'**
  String get linkEnriched;

  /// No description provided for @thumbnailsCache.
  ///
  /// In en, this message translates to:
  /// **'Link Thumbnails Cache'**
  String get thumbnailsCache;

  /// No description provided for @clearThumbnails.
  ///
  /// In en, this message translates to:
  /// **'Clear Thumbnails'**
  String get clearThumbnails;

  /// No description provided for @thumbnailsCleared.
  ///
  /// In en, this message translates to:
  /// **'Thumbnail cache cleared'**
  String get thumbnailsCleared;

  /// No description provided for @openInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open in browser'**
  String get openInBrowser;

  /// No description provided for @backupAndRestore.
  ///
  /// In en, this message translates to:
  /// **'Encrypted Backup & Security'**
  String get backupAndRestore;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export Encrypted Backup (.marsa)'**
  String get exportBackup;

  /// No description provided for @exportBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Save full vault into a password-protected offline file'**
  String get exportBackupDesc;

  /// No description provided for @importBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore from Backup'**
  String get importBackup;

  /// No description provided for @importBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Import and securely decrypt a previous vault'**
  String get importBackupDesc;

  /// No description provided for @enterBackupPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Backup Password'**
  String get enterBackupPassword;

  /// No description provided for @confirmBackupPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmBackupPassword;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @backupExportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Encrypted backup created successfully'**
  String get backupExportSuccess;

  /// No description provided for @backupImportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Vault restored successfully'**
  String get backupImportSuccess;

  /// No description provided for @invalidBackupPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password or corrupted file'**
  String get invalidBackupPassword;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
