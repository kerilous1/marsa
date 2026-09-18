import 'package:drift/drift.dart';

/// Drift table definition for the primary MARSA vault storage.
///
/// Each row represents a single captured payload — whether it's a text snippet,
/// a URL, an image of an official document, or a temporary item.
///
/// Columns marked as [Sprint 2] are present in the schema from day one
/// to avoid database migrations, but are populated by deferred processors
/// (OCR, OpenGraph scraper) that ship in Sprint 2.
///
/// Indexed columns:
///   - [category]: Enables fast filtered queries per dashboard tab.
///   - [processingStatus]: Enables background workers to find pending items.
///   - [createdAt]: Enables chronological sorting within each tab.
///   - [nationalId]: Enables direct lookup of Egyptian National IDs.
class VaultEntries extends Table {
  /// Auto-incrementing primary key.
  IntColumn get id => integer().autoIncrement()();

  /// Vault routing category: docs, readLater, quickNotes, or tempVault.
  /// Stored as a string key matching [VaultCategory.dbKey].
  TextColumn get category => text()();

  /// Original unsanitized payload exactly as received from the Share Sheet.
  /// Preserved for debugging and fallback display.
  TextColumn get rawPayload => text()();

  /// Sanitized clean URL after stripping tracking parameters.
  /// Null for non-URL payloads (plain text, images without URLs).
  TextColumn get cleanUrl => text().nullable()();

  /// Local file path for image/document payloads stored in /vault/docs/.
  /// Null for text-only or URL-only payloads.
  TextColumn get filePath => text().nullable()();

  /// [Sprint 2] Page title extracted from OpenGraph or OCR document header.
  TextColumn get title => text().nullable()();

  /// [Sprint 2] Page description from OpenGraph metadata.
  TextColumn get description => text().nullable()();

  /// [Sprint 2] Local cached path for OpenGraph thumbnail image.
  TextColumn get thumbnailPath => text().nullable()();

  /// [Sprint 2] Extracted 14-digit Egyptian National ID string.
  TextColumn get nationalId => text().nullable()();

  /// [Sprint 2] Governorate name decoded from the National ID.
  TextColumn get governorate => text().nullable()();

  /// [Sprint 2] Birth date decoded from the National ID.
  DateTimeColumn get birthDate => dateTime().nullable()();

  /// [Sprint 2] Gender decoded from the National ID (male/female).
  TextColumn get gender => text().nullable()();

  /// [Sprint 2] Full OCR-extracted text from document images.
  TextColumn get ocrExtractedText => text().nullable()();

  /// Processing pipeline status: pending, completed, requiresReview, failed.
  /// Stored as a string key matching [ProcessingStatus.dbKey].
  TextColumn get processingStatus =>
      text().withDefault(const Constant('pending'))();

  /// Auto-purge expiry timestamp for tempVault items.
  /// Null for non-temporary items (docs, readLater, quickNotes).
  DateTimeColumn get ttlExpiry => dateTime().nullable()();

  /// Timestamp of when the item was first captured and saved.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
