import 'package:drift/drift.dart';
import '../tables/vault_entries_table.dart';
import '../vault_database.dart';

part 'vault_update_dao.g.dart';

/// Data Access Object responsible ONLY for updating existing vault entries.
///
/// Single Responsibility: Update operations only. No inserts, no queries,
/// no deletes. Used by:
///   - Sprint 2 OCR processor to enrich document entries with extracted data.
///   - Sprint 2 OpenGraph scraper to enrich link entries with metadata.
///   - Dashboard category-move action to reassign an item's vault.
@DriftAccessor(tables: [VaultEntries])
class VaultUpdateDao extends DatabaseAccessor<VaultDatabase>
    with _$VaultUpdateDaoMixin {
  VaultUpdateDao(super.db);

  /// Updates specific fields of a vault entry identified by [id].
  ///
  /// Only the non-null fields in [companion] are updated; all other columns
  /// remain unchanged. This is critical for the deferred processing pipeline
  /// where OCR results are written without overwriting the original payload.
  Future<bool> updateEntry(int id, VaultEntriesCompanion companion) {
    return (update(vaultEntries)..where((e) => e.id.equals(id)))
        .write(companion)
        .then((rowsAffected) => rowsAffected > 0);
  }

  /// Moves an entry to a different vault category.
  ///
  /// Used by the dashboard "Move" action to reclassify an item.
  /// Clears [ttlExpiry] when moving OUT of tempVault (item becomes permanent).
  Future<bool> updateCategory(int id, String newCategory) {
    final companion = VaultEntriesCompanion(
      category: Value(newCategory),
      ttlExpiry: newCategory == 'tempVault'
          ? Value(DateTime.now().add(const Duration(hours: 72)))
          : const Value(null),
    );
    return updateEntry(id, companion);
  }

  /// Atomically updates OCR extracted results and national ID metadata.
  Future<bool> updateOcrResult(
    int id, {
    String? nationalId,
    String? governorate,
    DateTime? birthDate,
    String? gender,
    String? ocrExtractedText,
    required String processingStatus,
  }) {
    final companion = VaultEntriesCompanion(
      nationalId: Value(nationalId),
      governorate: Value(governorate),
      birthDate: Value(birthDate),
      gender: Value(gender),
      ocrExtractedText: Value(ocrExtractedText),
      processingStatus: Value(processingStatus),
    );
    return updateEntry(id, companion);
  }

  /// Atomically updates OpenGraph link enrichment results.
  Future<bool> updateEnrichmentResult(
    int id, {
    String? title,
    String? description,
    String? siteName,
    String? thumbnailPath,
    required String processingStatus,
  }) {
    final companion = VaultEntriesCompanion(
      title: Value(title),
      description: Value(description),
      siteName: Value(siteName),
      thumbnailPath: Value(thumbnailPath),
      processingStatus: Value(processingStatus),
    );
    return updateEntry(id, companion);
  }

  /// Returns all entries with cleanUrl != null that are pending enrichment.
  Future<List<VaultEntry>> getPendingEnrichmentEntries() {
    return (select(vaultEntries)
          ..where((e) =>
              e.cleanUrl.isNotNull() &
              (e.processingStatus.equals('pending') |
                  e.processingStatus.equals('pendingEnrichment'))))
        .get();
  }

  /// Clears thumbnailPath references across all vault entries when cache is purged.
  /// Enforces Trap 3 Guard: avoids broken image paths in UI cards.
  Future<int> clearAllThumbnails() {
    return (update(vaultEntries)
          ..where((tbl) => tbl.thumbnailPath.isNotNull()))
        .write(const VaultEntriesCompanion(thumbnailPath: Value(null)));
  }

  /// Atomically updates the stored file path for an entry (e.g. after at-rest encryption).
  Future<bool> updateFilePath(int id, String newFilePath) {
    return updateEntry(id, VaultEntriesCompanion(filePath: Value(newFilePath)));
  }
}
