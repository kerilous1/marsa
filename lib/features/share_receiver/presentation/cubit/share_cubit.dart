import 'package:path/path.dart' as p;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/vault_types.dart';
import '../../../../core/services/file_storage_service.dart';
import '../../domain/usecases/route_raw_payload_usecase.dart';
import 'share_state.dart';

/// Manages the state and routing execution for the incoming share modal.
///
/// Ensures compliance with the <500ms SLA by writing raw data immediately
/// and delegating heavy transformations (OCR / OpenGraph) to background workers.
class ShareCubit extends Cubit<ShareState> {
  final RouteRawPayloadUseCase routeRawPayloadUseCase;
  final FileStorageService fileStorageService;

  ShareCubit({
    required this.routeRawPayloadUseCase,
    required this.fileStorageService,
    required String rawPayload,
    String? filePath,
    List<String> additionalFilePaths = const [],
  }) : super(
          ShareInitial(
            rawPayload: rawPayload,
            filePath: filePath,
            additionalFilePaths: additionalFilePaths,
          ),
        );

  /// Attaches a local image or PDF file picked directly inside the Quick Capture modal.
  void attachFile(String pickedFilePath, {String? customTitle}) {
    final current = state;
    final existingPayload = current is ShareInitial ? current.rawPayload : '';
    emit(
      ShareInitial(
        rawPayload: customTitle ??
            (existingPayload.isNotEmpty
                ? existingPayload
                : p.basename(pickedFilePath)),
        filePath: pickedFilePath,
      ),
    );
  }

  /// Clears any attached file inside the Quick Capture modal.
  void clearAttachedFile() {
    final current = state;
    if (current is ShareInitial) {
      emit(ShareInitial(rawPayload: current.rawPayload, filePath: null));
    }
  }

  /// Routes the payload to the selected vault category enum.
  Future<void> routePayload(VaultCategory category) async {
    await routePayloadWithKey(
      categoryKey: category.dbKey,
      hasAutoPurge: category == VaultCategory.tempVault,
    );
  }

  /// Routes payload using dynamic categoryKey string, optional explicit content, and auto-purge flag.
  Future<void> routePayloadWithKey({
    required String categoryKey,
    String? explicitPayload,
    bool hasAutoPurge = false,
  }) async {
    final currentState = state;
    if (currentState is! ShareInitial) return;

    final catEnum = VaultCategoryExtension.fromDbKey(categoryKey);
    emit(ShareSaving(catEnum));

    try {
      String? persistedFilePath = currentState.filePath;
      String? originalName;

      // Clone transient content URI file to sandboxed storage before OS revokes permissions
      if (persistedFilePath != null && persistedFilePath.isNotEmpty) {
        originalName = p.basename(persistedFilePath);
        persistedFilePath = await fileStorageService.copyToVault(persistedFilePath);
      }

      String payloadToRoute;
      if (explicitPayload != null && explicitPayload.isNotEmpty) {
        payloadToRoute = explicitPayload;
      } else if (persistedFilePath != null &&
          (currentState.rawPayload.isEmpty ||
              currentState.rawPayload == currentState.filePath ||
              currentState.rawPayload.startsWith('/') ||
              currentState.rawPayload.startsWith('file:') ||
              currentState.rawPayload.startsWith('content:'))) {
        payloadToRoute = originalName ?? p.basename(persistedFilePath);
      } else {
        payloadToRoute = currentState.rawPayload;
      }

      final entryId = await routeRawPayloadUseCase(
        RoutePayloadParams(
          categoryKey: categoryKey,
          category: catEnum,
          rawPayload: payloadToRoute,
          filePath: persistedFilePath,
          hasAutoPurge: hasAutoPurge,
        ),
      );

      // Multi-file share support (`ACTION_SEND_MULTIPLE` — `ISSUE-20`):
      // Persist all additional shared files into the same selected category.
      for (final extraPath in currentState.additionalFilePaths) {
        if (extraPath.trim().isEmpty) continue;
        final extraOriginalName = p.basename(extraPath);
        final copiedExtraPath = await fileStorageService.copyToVault(extraPath);
        await routeRawPayloadUseCase(
          RoutePayloadParams(
            categoryKey: categoryKey,
            category: catEnum,
            rawPayload: extraOriginalName,
            filePath: copiedExtraPath,
            hasAutoPurge: hasAutoPurge,
          ),
        );
      }

      emit(ShareSuccess(entryId: entryId, category: catEnum));
    } catch (e) {
      emit(ShareFailure(e.toString()));
    }
  }

  /// Safety fallback: routes to [VaultCategory.tempVault] when dismissed by outside tap.
  Future<void> dismissToTempVault() async {
    if (state is ShareInitial) {
      await routePayloadWithKey(categoryKey: 'tempVault', hasAutoPurge: true);
    }
  }
}
