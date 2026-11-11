import '../../../../core/constants/vault_types.dart';
import '../../../../core/services/payload_sanitizer.dart';
import '../repositories/share_repository.dart';

/// Parameter object encapsulating the inputs required to route a shared payload.
class RoutePayloadParams {
  final VaultCategory? category;
  final String categoryKey;
  final String rawPayload;
  final String? filePath;
  final bool hasAutoPurge;

  RoutePayloadParams({
    this.category,
    String? categoryKey,
    required this.rawPayload,
    this.filePath,
    bool? hasAutoPurge,
  })  : categoryKey = categoryKey ?? (category != null ? category.dbKey : 'tempVault'),
        hasAutoPurge = hasAutoPurge ??
            (category == VaultCategory.tempVault || categoryKey == 'tempVault');
}

/// Orchestrates the instant capture and storage pipeline (<10ms).
///
/// Follows the Store-First architecture:
///   1. Sanitizes raw text / URL using pure-Dart [PayloadSanitizer].
///   2. Assigns a strict 72-hour auto-purge TTL if routed to a temporary vault or auto-purge category.
///   3. Persists the record via [ShareRepository] with PENDING status.
///   4. Returns the generated unique row ID.
///
/// Pure Dart class: ZERO dependencies on Flutter framework or platform channels.
class RouteRawPayloadUseCase {
  final ShareRepository _repository;

  const RouteRawPayloadUseCase(this._repository);

  /// Executes the sanitization and storage workflow.
  Future<int> call(RoutePayloadParams params) async {
    final sanitized = PayloadSanitizer.sanitize(
      params.rawPayload,
      filePath: params.filePath,
    );

    // Auto-calculate 72-hour auto-purge expiration for temporary vault items
    DateTime? ttlExpiry;
    if (params.hasAutoPurge || params.categoryKey == 'tempVault') {
      ttlExpiry = DateTime.now().toUtc().add(const Duration(hours: 72));
    }

    return await _repository.insertRawEntry(
      category: params.category,
      categoryKey: params.categoryKey,
      rawPayload: params.rawPayload,
      cleanUrl: sanitized.cleanUrl,
      filePath: sanitized.filePath,
      ttlExpiry: ttlExpiry,
    );
  }
}
