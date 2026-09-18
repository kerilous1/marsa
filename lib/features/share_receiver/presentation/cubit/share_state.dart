import 'package:equatable/equatable.dart';
import '../../../../core/constants/vault_types.dart';

/// Base sealed state hierarchy for [ShareCubit].
sealed class ShareState extends Equatable {
  const ShareState();

  @override
  List<Object?> get props => [];
}

/// Initial state when share modal is displayed with captured payload.
final class ShareInitial extends ShareState {
  final String rawPayload;
  final String? filePath;

  const ShareInitial({
    required this.rawPayload,
    this.filePath,
  });

  @override
  List<Object?> get props => [rawPayload, filePath];
}

/// State emitted immediately when routing begins to trigger optimistic feedback.
final class ShareSaving extends ShareState {
  final VaultCategory category;

  const ShareSaving(this.category);

  @override
  List<Object?> get props => [category];
}

/// State emitted upon successful database write (<10ms).
final class ShareSuccess extends ShareState {
  final int entryId;
  final VaultCategory category;

  const ShareSuccess({
    required this.entryId,
    required this.category,
  });

  @override
  List<Object?> get props => [entryId, category];
}

/// State emitted in the unlikely event of a local persistence failure.
final class ShareFailure extends ShareState {
  final String errorMessage;

  const ShareFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
