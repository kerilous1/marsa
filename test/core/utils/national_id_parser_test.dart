import 'package:flutter_test/flutter_test.dart';
import 'package:marsa/core/utils/national_id_parser.dart';

void main() {
  group('EgyptianNationalIdParser — Valid IDs', () {
    test('parses valid Cairo male born January 1, 1990', () {
      // Century=2 (1900s), Year=90, Month=01, Day=01, Gov=01 (Cairo),
      // Seq=012, Gender=3 (odd=male), Check=4
      final result =
          EgyptianNationalIdParser.parse('29001010101234');
      expect(result, isNotNull);
      expect(result!.isValid, isTrue);
      expect(result.birthDate, DateTime(1990, 1, 1));
      expect(result.governorate, 'القاهرة');
      expect(result.governorateCode, '01');
      expect(result.gender, Gender.male);
    });

    test('parses valid Alexandria female born March 15, 2002', () {
      // Century=3 (2000s), Year=02, Month=03, Day=15, Gov=02 (Alex),
      // Seq=001, Gender=2 (even=female), Check=5
      final result =
          EgyptianNationalIdParser.parse('30203150200125');
      expect(result, isNotNull);
      expect(result!.isValid, isTrue);
      expect(result.birthDate, DateTime(2002, 3, 15));
      expect(result.governorate, 'الإسكندرية');
      expect(result.gender, Gender.female);
    });

    test('parses valid Giza male born December 25, 1985', () {
      // Century=2, Year=85, Month=12, Day=25, Gov=21 (Giza)
      final result =
          EgyptianNationalIdParser.parse('28512252100131');
      expect(result, isNotNull);
      expect(result!.birthDate, DateTime(1985, 12, 25));
      expect(result.governorate, 'الجيزة');
      expect(result.gender, Gender.male);
    });

    test('parses ID with code 88 (born outside Egypt)', () {
      final result =
          EgyptianNationalIdParser.parse('29505208800171');
      expect(result, isNotNull);
      expect(result!.governorate, 'خارج الجمهورية');
      expect(result.governorateCode, '88');
    });

    test('extracts ID embedded in longer OCR text', () {
      const ocrText =
          'الرقم القومي: 29001010101234 الاسم: أحمد محمد';
      final result = EgyptianNationalIdParser.parse(ocrText);
      expect(result, isNotNull);
      expect(result!.nationalId, '29001010101234');
    });
  });

  group('EgyptianNationalIdParser — Leap Year Validation', () {
    test('accepts February 29 on leap year 2000', () {
      // 2000 is a leap year (divisible by 400)
      final result =
          EgyptianNationalIdParser.parse('30002290100131');
      expect(result, isNotNull);
      expect(result!.birthDate, DateTime(2000, 2, 29));
    });

    test('rejects February 29 on non-leap year 1999', () {
      // 1999 is not a leap year
      final result =
          EgyptianNationalIdParser.parse('29902290100131');
      expect(result, isNull);
    });

    test('accepts February 29 on leap year 1996', () {
      // 1996 is a leap year (divisible by 4, not by 100)
      final result =
          EgyptianNationalIdParser.parse('29602290100131');
      expect(result, isNotNull);
      expect(result!.birthDate.month, 2);
      expect(result.birthDate.day, 29);
    });

    test('rejects February 30 on any year', () {
      final result =
          EgyptianNationalIdParser.parse('29602300100131');
      expect(result, isNull);
    });
  });

  group('EgyptianNationalIdParser — Gender Detection', () {
    test('odd 13th digit is male', () {
      // Gender digit = 1 (odd)
      final result =
          EgyptianNationalIdParser.parse('29001010100110');
      expect(result, isNotNull);
      expect(result!.gender, Gender.male);
    });

    test('even 13th digit is female', () {
      // Gender digit = 2 (even)
      final result =
          EgyptianNationalIdParser.parse('29001010100120');
      expect(result, isNotNull);
      expect(result!.gender, Gender.female);
    });

    test('gender digit 9 is male', () {
      final result =
          EgyptianNationalIdParser.parse('29001010100190');
      expect(result, isNotNull);
      expect(result!.gender, Gender.male);
    });

    test('gender digit 0 is female', () {
      final result =
          EgyptianNationalIdParser.parse('29001010100100');
      expect(result, isNotNull);
      expect(result!.gender, Gender.female);
    });
  });

  group('EgyptianNationalIdParser — Invalid IDs', () {
    test('rejects 13-digit string (too short)', () {
      final result =
          EgyptianNationalIdParser.parse('2900101010123');
      expect(result, isNull);
    });

    test('rejects 15-digit string (too long)', () {
      final result =
          EgyptianNationalIdParser.parse('290010101012345');
      expect(result, isNull);
    });

    test('rejects invalid century digit (1)', () {
      final result =
          EgyptianNationalIdParser.parse('19001010100131');
      expect(result, isNull);
    });

    test('rejects invalid month (13)', () {
      final result =
          EgyptianNationalIdParser.parse('29013010100131');
      expect(result, isNull);
    });

    test('rejects invalid month (00)', () {
      final result =
          EgyptianNationalIdParser.parse('29000010100131');
      expect(result, isNull);
    });

    test('rejects invalid day (32)', () {
      final result =
          EgyptianNationalIdParser.parse('29001320100131');
      expect(result, isNull);
    });

    test('rejects unknown governorate code (99)', () {
      final result =
          EgyptianNationalIdParser.parse('29001019900131');
      expect(result, isNull);
    });

    test('rejects unknown governorate code (05)', () {
      final result =
          EgyptianNationalIdParser.parse('29001010500131');
      expect(result, isNull);
    });

    test('returns null for empty string', () {
      expect(EgyptianNationalIdParser.parse(''), isNull);
    });

    test('returns null for non-numeric text', () {
      expect(
        EgyptianNationalIdParser.parse('This is not a national ID'),
        isNull,
      );
    });
  });

  group('EgyptianNationalIdParser — Governorate Mapping', () {
    test('all 28 governorate codes are mapped', () {
      expect(EgyptianNationalIdParser.governorates.length, 28);
    });

    test('Cairo code is 01', () {
      expect(EgyptianNationalIdParser.governorates['01'], 'القاهرة');
    });

    test('Luxor code is 29', () {
      expect(EgyptianNationalIdParser.governorates['29'], 'الأقصر');
    });

    test('South Sinai code is 35', () {
      expect(EgyptianNationalIdParser.governorates['35'], 'جنوب سيناء');
    });

    test('Outside Egypt code is 88', () {
      expect(EgyptianNationalIdParser.governorates['88'], 'خارج الجمهورية');
    });
  });

  group('Gender — Display Labels', () {
    test('male Arabic label', () {
      expect(Gender.male.arabicLabel, 'ذكر');
    });

    test('female Arabic label', () {
      expect(Gender.female.arabicLabel, 'أنثى');
    });

    test('male English label', () {
      expect(Gender.male.englishLabel, 'Male');
    });

    test('female English label', () {
      expect(Gender.female.englishLabel, 'Female');
    });
  });

  group('EgyptianNationalIdParser — extractAndParse & Formatting Helpers', () {
    test('extracts ID with spaces between digit clusters (OCR formatting)', () {
      const noisyText = 'بطاقة تحقيق شخصية \n 2 95 06 15 21 0123 4 \n جمهورية مصر العربية';
      final result = EgyptianNationalIdParser.extractAndParse(noisyText);

      expect(result, isNotNull);
      expect(result!.nationalId, '29506152101234');
      expect(result.governorate, 'الجيزة');
      expect(result.birthDate, DateTime(1995, 6, 15));
      expect(result.gender, Gender.male);
    });

    test('extracts ID with Eastern Arabic-Indic numerals (٠-٩)', () {
      const arabicDigits = '٢٩٠٠١٠١٠١٠١٢٣٤';
      final result = EgyptianNationalIdParser.extractAndParse(arabicDigits);

      expect(result, isNotNull);
      expect(result!.nationalId, '29001010101234');
      expect(result.governorate, 'القاهرة');
      expect(result.gender, Gender.male);
    });

    test('extracts ID with hyphens or dots', () {
      const dashed = 'ID: 3-020315-020012-5';
      final result = EgyptianNationalIdParser.extractAndParse(dashed);

      expect(result, isNotNull);
      expect(result!.nationalId, '30203150200125');
      expect(result.governorate, 'الإسكندرية');
      expect(result.gender, Gender.female);
    });

    test('returns null when text contains no valid 14-digit ID', () {
      const invalid = 'Document without ID or with 12345 only';
      expect(EgyptianNationalIdParser.extractAndParse(invalid), isNull);
    });

    test('formatForDisplay formats 14 digits into visually spaced clusters', () {
      const raw = '29506152101234';
      final formatted = EgyptianNationalIdParser.formatForDisplay(raw);
      expect(formatted, '2 95 06 15 21 0123 4');
    });

    test('sanitizeForClipboard strips all spaces, hyphens, and non-digits', () {
      const formatted = '2 95 06 15 21 0123 4';
      final raw = EgyptianNationalIdParser.sanitizeForClipboard(formatted);
      expect(raw, '29506152101234');
    });
  });

  group('WP-4 — Future Date Guard, Mod-11 Checksum & OCR Resilience', () {
    test('rejects future birth date (e.g. year 2099)', () {
      // Century=3 (2000s), Year=99 (2099), Month=01, Day=01, Gov=01
      expect(EgyptianNationalIdParser.parse('39901010101234'), isNull);
    });

    test('computes and validates official Mod-11 check digit', () {
      // 2900101010123 -> weighted sum = 95 -> 95 % 11 = 7 -> 11 - 7 = 4
      expect(EgyptianNationalIdParser.computeCheckDigit('2900101010123'), 4);
      expect(EgyptianNationalIdParser.hasValidChecksum('29001010101234'), isTrue);
      expect(EgyptianNationalIdParser.hasValidChecksum('29001010101239'), isFalse);

      // Strict mode (enforceChecksum: true)
      expect(
        EgyptianNationalIdParser.parse('29001010101234', enforceChecksum: true),
        isNotNull,
      );
      expect(
        EgyptianNationalIdParser.parse('29001010101239', enforceChecksum: true),
        isNull,
      );
    });

    test('prioritizes candidate with valid check digit in noisy multi-number OCR text', () {
      // First 14-digit number has invalid check digit (ends in 9 instead of 4),
      // second 14-digit number has valid check digit (ends in 4).
      const noisyMultiNumberText = '''
        رقم المرجع: 29001010101239
        الرقم القومي: 29001010101234
      ''';
      final result = EgyptianNationalIdParser.extractAndParse(noisyMultiNumberText);
      expect(result, isNotNull);
      expect(result!.nationalId, '29001010101234');
      expect(result.hasValidChecksum, isTrue);
    });

    test('extracts ID with Extended Arabic-Indic / Persian numerals (۰-۹)', () {
      const extendedDigits = '۲۹۰۰۱۰۱۰۱۰۱۲۳۴';
      final result = EgyptianNationalIdParser.extractAndParse(extendedDigits);
      expect(result, isNotNull);
      expect(result!.nationalId, '29001010101234');
    });

    test('extracts ID from MRZ line without word boundaries (ID...<<<)', () {
      const mrzLine = 'IDegy29001010101234<<<<<<<<<<<<';
      final result = EgyptianNationalIdParser.extractAndParse(mrzLine);
      expect(result, isNotNull);
      expect(result!.nationalId, '29001010101234');
    });

    test('recovers embossed ID when Latin OCR misreads 0 as O and 1 as I/l', () {
      const misreadOcr = 'بطاقة الرقم القومي\n2 9O O1 OI O1 O123 4';
      final result = EgyptianNationalIdParser.extractAndParse(misreadOcr);
      expect(result, isNotNull);
      expect(result!.nationalId, '29001010101234');
      expect(result.governorate, 'القاهرة');
    });
  });
}
