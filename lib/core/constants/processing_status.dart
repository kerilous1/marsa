/// Processing lifecycle status for vault entries.
///
/// Tracks the deferred processing state of each captured item.
/// The Store-First pattern writes items as [pending], then background
/// processors update them to [completed] or [requiresReview].
enum ProcessingStatus {
  /// Item has been saved but not yet processed by background workers.
  /// OCR has not run, OpenGraph has not been scraped.
  pending,

  /// All deferred processing completed successfully.
  /// OCR text extracted, national ID parsed, or OG metadata fetched.
  completed,

  /// Background processing attempted but failed (e.g., blurry image for OCR).
  /// Item is preserved with a manual review flag — NOT deleted.
  requiresReview,

  /// Unrecoverable processing failure (corrupt file, invalid format).
  failed,
}

/// Extension providing database serialization for [ProcessingStatus].
extension ProcessingStatusExtension on ProcessingStatus {
  /// Database string key for Drift storage.
  String get dbKey {
    switch (this) {
      case ProcessingStatus.pending:
        return 'pending';
      case ProcessingStatus.completed:
        return 'completed';
      case ProcessingStatus.requiresReview:
        return 'requiresReview';
      case ProcessingStatus.failed:
        return 'failed';
    }
  }

  /// Parses a database string key back into a [ProcessingStatus] enum.
  /// Returns [ProcessingStatus.pending] as fallback for unknown keys.
  static ProcessingStatus fromDbKey(String key) {
    switch (key) {
      case 'pending':
        return ProcessingStatus.pending;
      case 'completed':
        return ProcessingStatus.completed;
      case 'requiresReview':
        return ProcessingStatus.requiresReview;
      case 'failed':
        return ProcessingStatus.failed;
      default:
        return ProcessingStatus.pending;
    }
  }
}
