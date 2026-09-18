import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/vault_entries_table.dart';
import 'daos/vault_insert_dao.dart';
import 'daos/vault_query_dao.dart';
import 'daos/vault_delete_dao.dart';
import 'daos/vault_update_dao.dart';

part 'vault_database.g.dart';

/// Central Drift database for MARSA's local-first encrypted vault.
///
/// Architecture:
///   - Single SQLite database file stored in the app-private documents directory.
///   - FTS5 virtual table (vault_fts) for sub-50ms full-text search.
///   - 4 segregated DAOs following Interface Segregation Principle:
///     [VaultInsertDao], [VaultQueryDao], [VaultDeleteDao], [VaultUpdateDao].
///
/// The database schema includes all columns needed through Sprint 6,
/// populated incrementally as each sprint's processors come online.
@DriftDatabase(
  tables: [VaultEntries],
  daos: [VaultInsertDao, VaultQueryDao, VaultDeleteDao, VaultUpdateDao],
)
class VaultDatabase extends _$VaultDatabase {
  VaultDatabase({String? dbName}) : super(_openConnection(dbName));

  /// Constructor for testing with an in-memory or custom database executor.
  VaultDatabase.forTesting(super.e);

  /// Schema version — increment this when adding migrations.
  @override
  int get schemaVersion => 1;

  /// Called when the database is first created. Sets up the FTS5 virtual
  /// table and composite indices for optimized query performance.
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        // Create the main VaultEntries table with all columns.
        await m.createAll();

        // Create composite indices for fast filtered queries.
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_vault_category '
          'ON vault_entries (category)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_vault_status '
          'ON vault_entries (processing_status)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_vault_created '
          'ON vault_entries (created_at DESC)',
        );
        await customStatement(
          'CREATE INDEX IF NOT EXISTS idx_vault_national_id '
          'ON vault_entries (national_id)',
        );

        // Create FTS5 virtual table for full-text search.
        // Tokenizes: raw_payload, title, description, ocr_extracted_text, national_id.
        await customStatement(
          'CREATE VIRTUAL TABLE IF NOT EXISTS vault_fts '
          'USING fts5('
          '  raw_payload, '
          '  title, '
          '  description, '
          '  ocr_extracted_text, '
          '  national_id, '
          '  content=vault_entries, '
          '  content_rowid=id'
          ')',
        );

        // Create triggers to keep FTS5 index in sync with the main table.
        await customStatement(
          'CREATE TRIGGER IF NOT EXISTS vault_fts_insert '
          'AFTER INSERT ON vault_entries BEGIN '
          '  INSERT INTO vault_fts(rowid, raw_payload, title, description, ocr_extracted_text, national_id) '
          '  VALUES (new.id, new.raw_payload, new.title, new.description, new.ocr_extracted_text, new.national_id); '
          'END',
        );

        await customStatement(
          'CREATE TRIGGER IF NOT EXISTS vault_fts_delete '
          'AFTER DELETE ON vault_entries BEGIN '
          '  INSERT INTO vault_fts(vault_fts, rowid, raw_payload, title, description, ocr_extracted_text, national_id) '
          '  VALUES (\'delete\', old.id, old.raw_payload, old.title, old.description, old.ocr_extracted_text, old.national_id); '
          'END',
        );

        await customStatement(
          'CREATE TRIGGER IF NOT EXISTS vault_fts_update '
          'AFTER UPDATE ON vault_entries BEGIN '
          '  INSERT INTO vault_fts(vault_fts, rowid, raw_payload, title, description, ocr_extracted_text, national_id) '
          '  VALUES (\'delete\', old.id, old.raw_payload, old.title, old.description, old.ocr_extracted_text, old.national_id); '
          '  INSERT INTO vault_fts(rowid, raw_payload, title, description, ocr_extracted_text, national_id) '
          '  VALUES (new.id, new.raw_payload, new.title, new.description, new.ocr_extracted_text, new.national_id); '
          'END',
        );
      },
    );
  }
}

/// Opens a persistent SQLite database connection stored in the
/// app-private documents directory.
///
/// The database file name is dynamic based on environment flavor
/// ('marsa_dev.sqlite' or 'marsa.sqlite').
LazyDatabase _openConnection([String? dbName]) {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final fileName = dbName ?? 'marsa.sqlite';
    final file = File(p.join(dbFolder.path, fileName));
    return NativeDatabase.createInBackground(file);
  });
}
