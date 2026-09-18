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
  final RouteRawPayloadUseCase _routeRawPayloadUseCase;
  final FileStorageService _fileStorageService;

  ShareCubit({
    required RouteRawPayloadUseCase routeRawPayloadUseCase,
    required FileStorageService fileStorageService,
    required String rawPayload,
    String? filePath,
  })  : _routeRawPayloadUseCase = routeRawPayloadUseCase,
        _fileStorageService = fileStorageService,
        super(ShareInitial(rawPayload: rawPayload, filePath: filePath));

  /// Routes the payload to the selected vault category.
  Future<void> routePayload(VaultCategory category) async {
    final currentState = state;
    if (currentState is! ShareInitial) return;

    emit(ShareSaving(category));

    try {
      String? persistedFilePath = currentState.filePath;

      // Clone transient content URI file to sandboxed storage before OS revokes permissions
      if (persistedFilePath != null && persistedFilePath.isNotEmpty) {
        persistedFilePath = await _fileStorageService.copyToVault(persistedFilePath);
      }

      final entryId = await _routeRawPayloadUseCase(
        RoutePayloadParams(
          category: category,
          rawPayload: currentState.rawPayload,
          filePath: persistedFilePath,
        ),
      );

      emit(ShareSuccess(entryId: entryId, category: category));
    } catch (e) {
      emit(ShareFailure(e.toString()));
    }
  }

  /// Safety fallback: routes to [VaultCategory.tempVault] when dismissed by outside tap.
  Future<void> dismissToTempVault() async {
    if (state is ShareInitial) {
      await routePayload(VaultCategory.tempVault);
    }
  }
}
