import 'package:flutter_test/flutter_test.dart';
import 'package:marsa/core/services/payload_sanitizer.dart';

void main() {
  group('PayloadSanitizer.extractUrl', () {
    test('extracts URL from clean text', () {
      const input = 'https://example.com/article';
      expect(PayloadSanitizer.extractUrl(input), 'https://example.com/article');
    });

    test('extracts URL from Facebook-wrapped shared text', () {
      const input =
          'شوف البوست ده 🔥 https://www.facebook.com/post/12345?fbclid=abc123 حاجة جامدة!';
      expect(
        PayloadSanitizer.extractUrl(input),
        'https://www.facebook.com/post/12345?fbclid=abc123',
      );
    });

    test('extracts first URL when multiple URLs present', () {
      const input =
          'Link 1: https://first.com/page Link 2: https://second.com/page';
      expect(PayloadSanitizer.extractUrl(input), 'https://first.com/page');
    });

    test('returns null for plain text with no URLs', () {
      const input = 'This is just a plain text note with no links';
      expect(PayloadSanitizer.extractUrl(input), isNull);
    });

    test('returns null for empty string', () {
      expect(PayloadSanitizer.extractUrl(''), isNull);
    });
  });

  group('PayloadSanitizer.stripTrackingParams', () {
    test('strips fbclid from Facebook URL', () {
      const input =
          'https://example.com/article?id=5&fbclid=IwAR3abc123def456';
      expect(
        PayloadSanitizer.stripTrackingParams(input),
        'https://example.com/article?id=5',
      );
    });

    test('strips igsh from Instagram URL', () {
      const input =
          'https://www.instagram.com/p/ABC123/?igsh=xyz789&utm_source=ig';
      final result = PayloadSanitizer.stripTrackingParams(input);
      expect(result, isNot(contains('igsh')));
      expect(result, isNot(contains('utm_source')));
    });

    test('strips all utm_* parameters', () {
      const input =
          'https://example.com/page?utm_source=fb&utm_medium=social&utm_campaign=launch&id=42';
      final result = PayloadSanitizer.stripTrackingParams(input);
      expect(result, isNot(contains('utm_')));
      expect(result, contains('id=42'));
    });

    test('strips si from YouTube URL', () {
      const input = 'https://youtu.be/dQw4w9WgXcQ?si=abc123tracking';
      final result = PayloadSanitizer.stripTrackingParams(input);
      expect(result, isNot(contains('si=')));
      expect(result, contains('dQw4w9WgXcQ'));
    });

    test('preserves URL with no tracking params', () {
      const input = 'https://example.com/clean-page?page=2&lang=ar';
      expect(
        PayloadSanitizer.stripTrackingParams(input),
        'https://example.com/clean-page?page=2&lang=ar',
      );
    });

    test('removes trailing question mark when all params stripped', () {
      const input = 'https://example.com/page?fbclid=abc123';
      final result = PayloadSanitizer.stripTrackingParams(input);
      expect(result, isNot(contains('?')));
      expect(result, 'https://example.com/page');
    });

    test('returns malformed URL unchanged', () {
      const input = 'not-a-valid-url';
      expect(PayloadSanitizer.stripTrackingParams(input), input);
    });
  });

  group('PayloadSanitizer.detectType', () {
    test('detects URL payload', () {
      expect(
        PayloadSanitizer.detectType('Check https://example.com out'),
        PayloadType.url,
      );
    });

    test('detects plain text payload', () {
      expect(
        PayloadSanitizer.detectType('رقم الحساب: 1234567890'),
        PayloadType.text,
      );
    });

    test('detects image payload when filePath is provided', () {
      expect(
        PayloadSanitizer.detectType(
          'Some text',
          filePath: '/data/user/0/com.marsa/cache/image.jpg',
        ),
        PayloadType.image,
      );
    });

    test('image type takes priority over URL in text', () {
      expect(
        PayloadSanitizer.detectType(
          'https://example.com/page',
          filePath: '/path/to/image.jpg',
        ),
        PayloadType.image,
      );
    });
  });

  group('PayloadSanitizer.sanitize (full pipeline)', () {
    test('sanitizes Facebook shared text end-to-end', () {
      const input =
          'شوف المقال ده 👀 https://www.example.com/article?id=42&fbclid=IwAR3abc&utm_source=facebook عجبني جداً';
      final result = PayloadSanitizer.sanitize(input);

      expect(result.type, PayloadType.url);
      expect(result.rawText, input);
      expect(result.cleanUrl, contains('id=42'));
      expect(result.cleanUrl, isNot(contains('fbclid')));
      expect(result.cleanUrl, isNot(contains('utm_source')));
    });

    test('sanitizes plain text without modification', () {
      const input = 'ملاحظة سريعة: اتصل بالدكتور الساعة 4';
      final result = PayloadSanitizer.sanitize(input);

      expect(result.type, PayloadType.text);
      expect(result.rawText, input);
      expect(result.cleanUrl, isNull);
    });

    test('sanitizes image payload', () {
      final result = PayloadSanitizer.sanitize(
        'Shared image',
        filePath: '/cache/national_id.jpg',
      );

      expect(result.type, PayloadType.image);
      expect(result.filePath, '/cache/national_id.jpg');
      expect(result.cleanUrl, isNull);
    });
  });
}
