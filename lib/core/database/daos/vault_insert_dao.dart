import 'package:drift/drift.dart';
import '../tables/vault_entries_table.dart';
import '../vault_database.dart';

part 'vault_insert_dao.g.dart';

/// Data Access Object responsible ONLY for inserting new vault entries.
///
/// Single Responsibility: Write operations only. No queries, no deletes,
/// no updates. This ensures the Store-First pattern's write path remains
/// minimal and predictable (SLA target: <10ms per insert).
@DriftAccessor(tables: [VaultEntries])
class VaultInsertDao extends DatabaseAccessor<VaultDatabase>
    with _$VaultInsertDaoMixin {
  VaultInsertDao(super.db);

  /// Inserts a raw vault entry and returns the auto-generated row ID.
  ///
  /// This is the critical synchronous write used by the Quick Router Modal.
  /// The entry is created with [processingStatus] = 'pending' by default,
  /// meaning deferred processors (OCR, OpenGraph) will pick it up later.
  Future<int> insertEntry(VaultEntriesCompanion entry) {
    return into(vaultEntries).insert(entry);
  }

  /// Checks if an identical URL or text note already exists in the given [category]
  /// to prevent accidental duplicate shares.
  Future<VaultEntry?> findDuplicateEntry({
    required String category,
    required String rawPayload,
    String? cleanUrl,
  }) {
    if (cleanUrl != null && cleanUrl.isNotEmpty) {
      return (select(vaultEntries)
            ..where((e) =>
                e.category.equals(category) & e.cleanUrl.equals(cleanUrl))
            ..limit(1))
          .getSingleOrNull();
    }

    return (select(vaultEntries)
          ..where((e) =>
              e.category.equals(category) &
              e.filePath.isNull() &
              e.rawPayload.equals(rawPayload))
          ..limit(1))
        .getSingleOrNull();
  }
}
