import 'package:drift/drift.dart';
import '../../utils/arabic_text_normalizer.dart';
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

  /// Returns all entries matching a full-text and normalized Arabic/substring search [query]
  /// across rawPayload, title, description, siteName, cleanUrl, ocrExtractedText,
  /// nationalId, and governorate columns (`ISSUE-01` & `ISSUE-02`).
  ///
  /// Uses a Two-Tier Hybrid Engine:
  /// 1. Tier 1: SQLite FTS5 prefix matching (`token*`) ordered by BM25 `rank`.
  /// 2. Tier 2: Normalized Arabic & Eastern-numeral substring matching across all metadata columns.
  Future<List<VaultEntry>> searchEntries(String query) async {
    final rawTokens = ArabicTextNormalizer.tokenizeQuery(query);
    if (rawTokens.isEmpty) return const [];

    final ftsMatchExpr = ArabicTextNormalizer.buildFts5MatchExpression(query);
    final results = <VaultEntry>[];
    final seenIds = <int>{};

    // Tier 1: Fast FTS5 Prefix Match with BM25 ranking
    if (ftsMatchExpr.isNotEmpty) {
      try {
        final ftsRows = await customSelect(
          'SELECT v.* FROM vault_entries v '
          'INNER JOIN vault_fts f ON v.id = f.rowid '
          'WHERE vault_fts MATCH ? '
          'ORDER BY rank',
          variables: [Variable.withString(ftsMatchExpr)],
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
            siteName: row.readNullable<String>('site_name'),
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

        for (final entry in ftsRows) {
          if (seenIds.add(entry.id)) {
            results.add(entry);
          }
        }
      } catch (_) {
        // Fallback gracefully to Tier 2 if FTS5 encounters any unexpected query edge case
      }
    }

    // Tier 2: Normalized Arabic orthographic & substring matching across all columns
    final normalizedTokens = rawTokens
        .map(ArabicTextNormalizer.normalize)
        .where((t) => t.isNotEmpty)
        .toList();

    if (normalizedTokens.isNotEmpty) {
      final allEntries = await (select(vaultEntries)
            ..orderBy([
              (e) => OrderingTerm(expression: e.createdAt, mode: OrderingMode.desc)
            ]))
          .get();

      for (final entry in allEntries) {
        if (seenIds.contains(entry.id)) continue;

        final searchableComposite = [
          entry.title ?? '',
          entry.nationalId ?? '',
          entry.governorate ?? '',
          entry.siteName ?? '',
          entry.cleanUrl ?? '',
          entry.description ?? '',
          entry.ocrExtractedText ?? '',
          entry.rawPayload,
        ].join(' ');

        if (ArabicTextNormalizer.matchesNormalizedTokens(
          normalizedTokens,
          searchableComposite,
        )) {
          seenIds.add(entry.id);
          results.add(entry);
        }
      }
    }

    return results;
  }

  /// Returns all entries with a given [processingStatus].
  ///
  /// Used by background workers to find items needing deferred processing.
  Future<List<VaultEntry>> getEntriesByStatus(String status) {
    return (select(vaultEntries)
          ..where((e) => e.processingStatus.equals(status)))
        .get();
  }

  /// Returns all entries (in tempVault or any custom auto-purge category) whose TTL has expired (ttlExpiry <= now).
  ///
  /// Used by the purge logic on app launch to clean up expired temporary items.
  Future<List<VaultEntry>> getExpiredTempEntries() {
    return (select(vaultEntries)
          ..where((e) =>
              e.ttlExpiry.isNotNull() &
              e.ttlExpiry.isSmallerOrEqualValue(DateTime.now())))
        .get();
  }

  /// Returns all active auto-purge entries whose expiry is in the future (> now + 1 hour).
  ///
  /// Used on app launch / reboot recovery to reschedule AlarmManager notifications.
  Future<List<VaultEntry>> getActiveTempEntriesForNotification() {
    final threshold = DateTime.now().add(const Duration(hours: 1));
    return (select(vaultEntries)
          ..where((e) =>
              e.ttlExpiry.isNotNull() &
              e.ttlExpiry.isBiggerThanValue(threshold)))
        .get();
  }
}
