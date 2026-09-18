import '../../../../core/constants/vault_types.dart';

/// Abstract domain contract defining persistence capabilities for raw captured payloads.
///
/// Strictly isolated from Drift SQLite or Flutter UI details.
/// Implemented by the Data layer ([ShareRepositoryImpl]).
abstract class ShareRepository {
  /// Inserts a raw vault entry with PENDING processing status.
  ///
  /// Returns the newly generated unique database integer ID.
  Future<int> insertRawEntry({
    required VaultCategory category,
    required String rawPayload,
    String? cleanUrl,
    String? filePath,
    DateTime? ttlExpiry,
  });
}
