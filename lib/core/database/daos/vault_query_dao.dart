import 'package:drift/drift.dart';
import '../tables/vault_entries_table.dart';
import '../vault_database.dart';

part 'vault_query_dao.g.dart';

/// Data Access Object responsible ONLY for reading and querying vault entries.
///
/// Single Responsibility: Read operations only. No inserts, no deletes,
/// no updates. Supports category-filtered lists, single-item lookup,
/// and FTS5 full-text search.
@DriftAccessor(tables: [VaultEntries])
class VaultQueryDao extends DatabaseAccessor<VaultDatabase>
    with _$VaultQueryDaoMixin {
  VaultQueryDao(super.db);

  /// Returns all entries for a specific [category], ordered by [createdAt] desc.
  ///
  /// Used by each dashboard tab to display its vault contents.
  Future<List<VaultEntry>> getEntriesByCategory(String category) {
    return (select(vaultEntries)
          ..where((e) => e.category.equals(category))
          ..orderBy([
            (e) => OrderingTerm(expression: e.createdAt, mode: OrderingMode.desc)
          ]))
        .get();
  }

  /// Returns a stream of entries for a specific [category] for reactive UI updates.
  ///
  /// The dashboard tab listens to this stream so new entries appear
  /// instantly without manual refresh after a share-capture.
  Stream<List<VaultEntry>> watchEntriesByCategory(String category) {
    return (select(vaultEntries)
          ..where((e) => e.category.equals(category))
          ..orderBy([
            (e) => OrderingTerm(expression: e.createdAt, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  /// Returns a single vault entry by its [id].
  ///
  /// Used when navigating to a detail screen or performing a targeted action.
  Future<VaultEntry?> getEntryById(int id) {
    return (select(vaultEntries)..where((e) => e.id.equals(id)))
        .getSingleOrNull();
  }

  /// Returns all entries matching a full-text search [query] across
  /// rawPayload, title, ocrExtractedText, and nationalId columns.
  ///
  /// Uses SQLite FTS5 MATCH syntax for sub-50ms search performance
  /// across 10,000+ entries.
  Future<List<VaultEntry>> searchEntries(String query) {
    final sanitizedQuery = query.replaceAll(RegExp(r'[^\w\s\u0600-\u06FF]'), '');
    if (sanitizedQuery.trim().isEmpty) return Future.value([]);

    return customSelect(
      'SELECT v.* FROM vault_entries v '
      'INNER JOIN vault_fts f ON v.id = f.rowid '
      'WHERE vault_fts MATCH ? '
      'ORDER BY rank',
      variables: [Variable.withString(sanitizedQuery)],
      readsFrom: {vaultEntries},
    ).map((row) {
      return VaultEntry(
        id: row.read<int>('id'),
        category: row.read<String>('category'),
        rawPayload: row.read<String>('raw_payload'),
        cleanUrl: row.readNullable<String>('clean_url'),
        filePath: row.readNullable<String>('file_path'),
        title: row.readNullable<String>('title'),
        description: row.readNullable<String>('description'),
        thumbnailPath: row.readNullable<String>('thumbnail_path'),
        nationalId: row.readNullable<String>('national_id'),
        governorate: row.readNullable<String>('governorate'),
        birthDate: row.readNullable<DateTime>('birth_date'),
        gender: row.readNullable<String>('gender'),
        ocrExtractedText: row.readNullable<String>('ocr_extracted_text'),
        processingStatus: row.read<String>('processing_status'),
        ttlExpiry: row.readNullable<DateTime>('ttl_expiry'),
        createdAt: row.read<DateTime>('created_at'),
      );
    }).get();
  }

  /// Returns all entries with a given [processingStatus].
  ///
  /// Used by background workers to find items needing deferred processing.
  Future<List<VaultEntry>> getEntriesByStatus(String status) {
    return (select(vaultEntries)
          ..where((e) => e.processingStatus.equals(status)))
        .get();
  }

  /// Returns all tempVault entries whose TTL has expired (ttlExpiry < now).
  ///
  /// Used by the purge logic on app launch to clean up expired temporary items.
  Future<List<VaultEntry>> getExpiredTempEntries() {
    return (select(vaultEntries)
          ..where((e) =>
              e.category.equals('tempVault') &
              e.ttlExpiry.isSmallerThanValue(DateTime.now())))
        .get();
  }
}
