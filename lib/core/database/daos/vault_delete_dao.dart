import 'package:drift/drift.dart';
import '../tables/vault_entries_table.dart';
import '../vault_database.dart';

part 'vault_delete_dao.g.dart';

/// Data Access Object responsible ONLY for deleting vault entries.
///
/// Single Responsibility: Delete operations only. No inserts, no queries,
/// no updates. Supports single-item deletion and bulk TTL purge.
@DriftAccessor(tables: [VaultEntries])
class VaultDeleteDao extends DatabaseAccessor<VaultDatabase>
    with _$VaultDeleteDaoMixin {
  VaultDeleteDao(super.db);

  /// Deletes a single vault entry by its [id].
  ///
  /// Returns the number of affected rows (0 if entry not found, 1 if deleted).
  Future<int> deleteEntryById(int id) {
    return (delete(vaultEntries)..where((e) => e.id.equals(id))).go();
  }

  /// Purges all tempVault entries whose [ttlExpiry] has passed.
  ///
  /// Called on app launch and periodically to enforce auto-cleanup policy.
  /// Returns the number of purged entries.
  Future<int> purgeExpiredTempEntries() {
    return (delete(vaultEntries)
          ..where((e) =>
              e.category.equals('tempVault') &
              e.ttlExpiry.isSmallerThanValue(DateTime.now())))
        .go();
  }
}
