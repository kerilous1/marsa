/// Describes the detected type of a shared payload.
///
/// Used by [PayloadSanitizer] to classify incoming content so the Quick Router
/// can suggest an appropriate default vault category.
enum PayloadType {
  /// Payload contains at least one valid URL.
  url,

  /// Payload is plain text with no detectable URLs.
  text,

  /// Payload is an image file path (received via Share Sheet image intent).
  image,
}

/// Sanitizes raw shared payloads from social media and messaging apps.
///
/// Responsibilities:
///   1. Extract the first valid URL from noisy shared text
///      (e.g., Facebook wraps URLs with "Look at this post: <url>").
///   2. Strip all known tracking query parameters:
///      fbclid, igsh, si, gclid, utm_source, utm_medium, utm_campaign,
///      utm_term, utm_content, ref, feature.
///   3. Detect the payload type: [PayloadType.url], [PayloadType.text],
///      or [PayloadType.image].
///
/// This class is **pure Dart** with zero Flutter dependencies,
/// making it safe for the Domain layer and fully unit-testable.
class PayloadSanitizer {
  /// Regex pattern matching a valid HTTP/HTTPS URL within surrounding text.
  static final RegExp _urlPattern = RegExp(
    r'https?://[^\s<>"{}|\\^`\[\]]+',
    caseSensitive: false,
  );

  /// Set of tracking query parameter names to strip from URLs.
  /// Covers Facebook, Google, Instagram, TikTok, YouTube, and UTM standards.
  static const Set<String> _trackingParams = {
    'fbclid',
    'igsh',
    'igshid',
    'si',
    'gclid',
    'utm_source',
    'utm_medium',
    'utm_campaign',
    'utm_term',
    'utm_content',
    'ref',
    'feature',
    'ref_src',
    'ref_url',
    'share_id',
    't', // TikTok tracking
    '_nc_sid',
    '_nc_ohc',
    '_nc_ht',
  };

  /// Extracts the first valid URL from [rawText], or returns null if none found.
  ///
  /// Example:
  /// ```
  /// extractUrl('Check this out https://example.com/page?fbclid=abc Hey!')
  /// // Returns: 'https://example.com/page?fbclid=abc'
  /// ```
  static String? extractUrl(String rawText) {
    final match = _urlPattern.firstMatch(rawText);
    return match?.group(0);
  }

  /// Strips all tracking query parameters from a [url].
  ///
  /// Preserves all non-tracking parameters. If the URL has no remaining
  /// query parameters after stripping, the query string is removed entirely.
  ///
  /// Example:
  /// ```
  /// stripTrackingParams('https://example.com/page?id=5&fbclid=abc&utm_source=fb')
  /// // Returns: 'https://example.com/page?id=5'
  /// ```
  static String stripTrackingParams(String url) {
    final Uri uri;
    try {
      uri = Uri.parse(url);
    } catch (_) {
      return url;
    }

    if (!uri.hasQuery) return url;

    // Filter out tracking parameters, keeping only clean ones.
    final cleanParams = <String, List<String>>{};
    for (final entry in uri.queryParametersAll.entries) {
      if (!_trackingParams.contains(entry.key.toLowerCase())) {
        cleanParams[entry.key] = entry.value;
      }
    }

    // Rebuild the URI from scratch to avoid Dart's Uri.replace quirks.
    // When all params are stripped, we must omit the query string entirely.
    if (cleanParams.isEmpty) {
      // Build a clean URI with no query string at all.
      final cleanUri = Uri(
        scheme: uri.scheme,
        userInfo: uri.userInfo,
        host: uri.host,
        port: uri.hasPort ? uri.port : null,
        pathSegments: uri.pathSegments,
        fragment: uri.hasFragment ? uri.fragment : null,
      );
      return cleanUri.toString();
    }

    // Rebuild with only the non-tracking query parameters.
    final cleanUri = uri.replace(queryParameters: cleanParams);
    return cleanUri.toString();
  }

  /// Detects the type of a shared payload.
  ///
  /// - If [filePath] is provided and non-empty → [PayloadType.image].
  /// - If [rawText] contains a valid URL → [PayloadType.url].
  /// - Otherwise → [PayloadType.text].
  static PayloadType detectType(String rawText, {String? filePath}) {
    if (filePath != null && filePath.isNotEmpty) {
      return PayloadType.image;
    }
    if (_urlPattern.hasMatch(rawText)) {
      return PayloadType.url;
    }
    return PayloadType.text;
  }

  /// Full sanitization pipeline: extract URL, strip tracking, and return results.
  ///
  /// Returns a [SanitizedPayload] containing:
  ///   - The detected [PayloadType].
  ///   - The clean URL (if applicable), or null for text/image payloads.
  ///   - The original raw text preserved as-is.
  static SanitizedPayload sanitize(String rawText, {String? filePath}) {
    final type = detectType(rawText, filePath: filePath);

    if (type == PayloadType.url) {
      final rawUrl = extractUrl(rawText);
      final cleanUrl =
          rawUrl != null ? stripTrackingParams(rawUrl) : null;
      return SanitizedPayload(
        type: type,
        rawText: rawText,
        cleanUrl: cleanUrl,
        filePath: filePath,
      );
    }

    return SanitizedPayload(
      type: type,
      rawText: rawText,
      cleanUrl: null,
      filePath: filePath,
    );
  }
}

/// Immutable result of the [PayloadSanitizer.sanitize] pipeline.
///
/// Contains the classified payload type, the original raw text,
/// and the cleaned URL (if the payload contained a link).
class SanitizedPayload {
  /// The detected type of the payload (url, text, or image).
  final PayloadType type;

  /// The original unsanitized text exactly as shared by the user.
  final String rawText;

  /// The clean URL with tracking parameters stripped, or null if not a URL payload.
  final String? cleanUrl;

  /// The local file path for image payloads, or null for text/URL payloads.
  final String? filePath;

  const SanitizedPayload({
    required this.type,
    required this.rawText,
    required this.cleanUrl,
    required this.filePath,
  });
}
