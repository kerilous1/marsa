import 'package:drift/drift.dart';
import '../../../../core/constants/vault_types.dart';
import '../../../../core/database/daos/vault_insert_dao.dart';
import '../../../../core/database/vault_database.dart';
import '../../domain/repositories/share_repository.dart';

/// Concrete implementation of [ShareRepository] backed by Drift SQLite.
///
/// Maps domain parameters to Drift's strongly typed [VaultEntriesCompanion].
class ShareRepositoryImpl implements ShareRepository {
  final VaultInsertDao _insertDao;

  const ShareRepositoryImpl(this._insertDao);

  @override
  Future<int> insertRawEntry({
    required VaultCategory category,
    required String rawPayload,
    String? cleanUrl,
    String? filePath,
    DateTime? ttlExpiry,
  }) async {
    final entry = VaultEntriesCompanion.insert(
      category: category.dbKey,
      rawPayload: rawPayload,
      cleanUrl: Value(cleanUrl),
      filePath: Value(filePath),
      processingStatus: const Value('pending'),
      ttlExpiry: Value(ttlExpiry),
      createdAt: Value(DateTime.now().toUtc()),
    );

    return await _insertDao.insertEntry(entry);
  }
}
