import '../../../../core/constants/vault_types.dart';
import '../../../../core/services/payload_sanitizer.dart';
import '../../../../core/utils/national_id_parser.dart';
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

  static final RegExp _otpOrTempKeywords = RegExp(
    r'(?:رمز التحقق|كود التفعيل|كود التحقق|الرقم السري المتغير|صالح لمدة|otp|verification code|security code|passcode|one-time)',
    caseSensitive: false,
  );

  static final RegExp _docKeywords = RegExp(
    r'(?:الرقم القومي|بطاقة|جواز سفر|رخصة|شهادة|عقد|فاتورة|إيصال|ايصال|حساب بنكي|iban|invoice|receipt|passport|national id|contract)',
    caseSensitive: false,
  );

  /// Smartly suggests the best default category key (`docs`, `readLater`, `tempVault`, `quickNotes`)
  /// based on deterministic local heuristics (zero cloud / zero latency).
  static String suggestSmartCategoryKey({
    required String rawPayload,
    String? filePath,
  }) {
    if (filePath != null && filePath.trim().isNotEmpty) {
      return 'docs';
    }

    final text = rawPayload.trim();
    if (text.isEmpty) return 'quickNotes';

    // 1. OTP / temporary verification codes -> tempVault
    if (_otpOrTempKeywords.hasMatch(text)) {
      return 'tempVault';
    }

    // 2. Contains valid 14-digit Egyptian National ID -> docs
    if (EgyptianNationalIdParser.extractAndParse(text) != null) {
      return 'docs';
    }

    // 3. Contains a web URL -> readLater
    final sanitized = PayloadSanitizer.sanitize(text);
    if (sanitized.cleanUrl != null && sanitized.cleanUrl!.isNotEmpty) {
      return 'readLater';
    }

    // 4. Financial / official document keywords -> docs
    if (_docKeywords.hasMatch(text)) {
      return 'docs';
    }

    return 'quickNotes';
  }

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
