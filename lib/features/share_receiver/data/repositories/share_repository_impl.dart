import 'dart:async';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/constants/vault_types.dart';
import '../../../../core/database/daos/vault_insert_dao.dart';
import '../../../../core/database/daos/vault_update_dao.dart';
import '../../../../core/database/vault_database.dart';
import '../../../../core/security/encryption/vault_crypto_service.dart';
import '../../../../core/services/expiry_notification_service.dart';
import '../../../documents/domain/usecases/process_document_ocr_usecase.dart';
import '../../../links/domain/usecases/enrich_link_usecase.dart';
import '../../domain/repositories/share_repository.dart';

/// Concrete implementation of [ShareRepository] backed by Drift SQLite.
///
/// Maps domain parameters to Drift's strongly typed [VaultEntriesCompanion],
/// schedules native 1-hour auto-purge notifications for temporary vault items,
/// fires non-blocking background OCR processing for document images,
/// encrypts sensitive documents at-rest via [VaultCryptoService],
/// and fires non-blocking background OpenGraph enrichment for web links.
class ShareRepositoryImpl implements ShareRepository {
  final VaultInsertDao _insertDao;
  final VaultUpdateDao? _updateDao;
  final ExpiryNotificationService _notificationService;
  final ProcessDocumentOcrUseCase? _processDocumentOcrUseCase;
  final EnrichLinkUseCase? _enrichLinkUseCase;
  final VaultCryptoService? _vaultCryptoService;

  ShareRepositoryImpl(
    this._insertDao, [
    ExpiryNotificationService? notificationService,
    ProcessDocumentOcrUseCase? processDocumentOcrUseCase,
    EnrichLinkUseCase? enrichLinkUseCase,
    VaultCryptoService? vaultCryptoService,
    VaultUpdateDao? updateDao,
  ])  : _notificationService =
            notificationService ?? ExpiryNotificationService(),
        _processDocumentOcrUseCase = processDocumentOcrUseCase,
        _enrichLinkUseCase = enrichLinkUseCase,
        _vaultCryptoService = vaultCryptoService,
        _updateDao = updateDao;

  @override
  Future<int> insertRawEntry({
    VaultCategory? category,
    String? categoryKey,
    required String rawPayload,
    String? cleanUrl,
    String? filePath,
    DateTime? ttlExpiry,
  }) async {
    final catKey = categoryKey ?? category?.dbKey ?? 'tempVault';

    // Duplicate Detection Guard: If an identical URL or text note already exists in this category,
    // return the existing entry ID instead of creating a duplicate record.
    if (filePath == null || filePath.isEmpty) {
      final duplicate = await _insertDao.findDuplicateEntry(
        category: catKey,
        rawPayload: rawPayload,
        cleanUrl: cleanUrl,
      );
      if (duplicate != null) {
        debugPrint('ℹ️ [ShareRepositoryImpl] Duplicate entry detected (#${duplicate.id}) in $catKey. Skipping duplicate insert.');
        return duplicate.id;
      }
    }

    final entry = VaultEntriesCompanion.insert(
      category: catKey,
      rawPayload: rawPayload,
      cleanUrl: Value(cleanUrl),
      filePath: Value(filePath),
      processingStatus: const Value('pending'),
      ttlExpiry: Value(ttlExpiry),
      createdAt: Value(DateTime.now().toUtc()),
    );

    final id = await _insertDao.insertEntry(entry);

    // Execute OCR and at-rest encryption pipeline before returning so external share
    // activities do not terminate mid-encryption (`ISSUE-19`).
    if (filePath != null && filePath.isNotEmpty) {
      await _processAndEncryptDocument(id, filePath, catKey);
    }

    // Fire non-blocking background OpenGraph link enrichment if entry has a clean URL
    if (cleanUrl != null &&
        cleanUrl.isNotEmpty &&
        _enrichLinkUseCase != null) {
      unawaited(
        _enrichLinkUseCase(itemId: id, url: cleanUrl),
      );
    }

    if (ttlExpiry != null) {
      final displayTitle = cleanUrl ??
          (rawPayload.length > 50
              ? '${rawPayload.substring(0, 50)}...'
              : rawPayload);

      _notificationService.scheduleExpiryNotification(
        itemId: id,
        title: 'تنبيه خزانة مَرسى المؤقتة',
        message: 'سيتم حذف «$displayTitle» تلقائياً خلال ساعة واحدة!',
        ttlExpiry: ttlExpiry,
      );
    }

    return id;
  }

  Future<void> _processAndEncryptDocument(
    int id,
    String filePath,
    String catKey,
  ) async {
    // 1. Process OCR first while the file is readable
    if (_processDocumentOcrUseCase != null) {
      try {
        await _processDocumentOcrUseCase(itemId: id, imagePath: filePath);
      } catch (e) {
        debugPrint('⚠️ [ShareRepositoryImpl] OCR execution error for #$id: $e');
      }
    }

    // 2. Encrypt at rest and remove plaintext from disk (Enterprise Guard 1)
    // Preserves the original extension before `.enc` (e.g. `.jpg.enc`, `.pdf.enc`) (`ISSUE-05`).
    if (_vaultCryptoService != null && (catKey == 'docs' || catKey == 'tempVault')) {
      try {
        final file = File(filePath);
        if (file.existsSync() && !filePath.toLowerCase().endsWith('.enc')) {
          final encPath = '$filePath.enc';
          await _vaultCryptoService.encryptFileAtRest(filePath, encPath);
          await _updateDao?.updateFilePath(id, encPath);
          debugPrint('🔒 [ShareRepositoryImpl] Encrypted document #$id at rest: $encPath');
        }
      } catch (e) {
        debugPrint('⚠️ [ShareRepositoryImpl] At-rest encryption error for #$id: $e');
      }
    }
  }
}
