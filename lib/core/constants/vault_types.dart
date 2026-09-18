/// Enum representing the 4 mutually exclusive vault categories.
///
/// Each captured payload is routed into exactly one of these categories
/// via the Quick Router Modal. The category determines:
///   - Which dashboard tab displays the item.
///   - What deferred processing pipeline runs (OCR for docs, OG scraping for links).
///   - Whether a TTL auto-purge applies (tempVault only).
enum VaultCategory {
  /// Official documents: National IDs, passports, driving licenses, certificates.
  /// Triggers OCR processing in Sprint 2+ to extract identity data.
  docs,

  /// URLs and articles saved for later reading or watching.
  /// Triggers OpenGraph metadata scraping in Sprint 2+ for rich previews.
  readLater,

  /// Raw text snippets, account numbers, ideas, and short memos.
  /// No deferred processing needed — stored and indexed as-is.
  quickNotes,

  /// Temporary items with auto-purge TTL (default: 72 hours).
  /// Also serves as the fallback route for accidental modal dismissals.
  tempVault,
}

/// Extension providing human-readable labels for each [VaultCategory].
extension VaultCategoryExtension on VaultCategory {
  /// Arabic display label for UI rendering.
  String get arabicLabel {
    switch (this) {
      case VaultCategory.docs:
        return 'ورق رسمي';
      case VaultCategory.readLater:
        return 'للقراءة والمشاهدة';
      case VaultCategory.quickNotes:
        return 'ملاحظات وأفكار';
      case VaultCategory.tempVault:
        return 'مخزن مؤقت';
    }
  }

  /// English display label for UI subtitle rendering.
  String get englishLabel {
    switch (this) {
      case VaultCategory.docs:
        return 'Official Docs';
      case VaultCategory.readLater:
        return 'Read Later';
      case VaultCategory.quickNotes:
        return 'Quick Notes';
      case VaultCategory.tempVault:
        return 'Temp Vault';
    }
  }

  /// Database string key used for Drift storage and queries.
  String get dbKey {
    switch (this) {
      case VaultCategory.docs:
        return 'docs';
      case VaultCategory.readLater:
        return 'readLater';
      case VaultCategory.quickNotes:
        return 'quickNotes';
      case VaultCategory.tempVault:
        return 'tempVault';
    }
  }

  /// Parses a database string key back into a [VaultCategory] enum value.
  /// Returns [VaultCategory.tempVault] as fallback for unknown keys.
  static VaultCategory fromDbKey(String key) {
    switch (key) {
      case 'docs':
        return VaultCategory.docs;
      case 'readLater':
        return VaultCategory.readLater;
      case 'quickNotes':
        return VaultCategory.quickNotes;
      case 'tempVault':
        return VaultCategory.tempVault;
      default:
        return VaultCategory.tempVault;
    }
  }
}
