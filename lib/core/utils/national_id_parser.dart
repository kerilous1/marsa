/// Complete mathematical decoder for 14-digit Egyptian National IDs.
///
/// Validates and extracts structured data from the Egyptian Civil Registry
/// National ID number format:
///   - Digit 1: Century indicator (2 = 1900s, 3 = 2000s).
///   - Digits 2-3: Birth year (YY).
///   - Digits 4-5: Birth month (01-12).
///   - Digits 6-7: Birth day (01-31).
///   - Digits 8-9: Governorate code (official Ministry of Interior mapping).
///   - Digits 10-12: Sequential registration number.
///   - Digit 13: Gender indicator (odd = male, even = female).
///   - Digit 14: Check digit.
///
/// This class is **pure Dart** with zero Flutter dependencies,
/// making it safe for the Domain layer and fully unit-testable.
///
/// Usage:
/// ```dart
/// final result = EgyptianNationalIdParser.parse('29001010101234');
/// if (result != null) {
///   print(result.governorate); // 'القاهرة'
///   print(result.gender);      // Gender.male
///   print(result.birthDate);   // DateTime(1990, 1, 1)
/// }
/// ```
class EgyptianNationalIdParser {
  /// Regex validating the complete 14-digit structure:
  ///   - Century digit: 2 or 3.
  ///   - Valid month: 01-12.
  ///   - Valid day: 01-31 (calendar sanity checked separately).
  ///   - Official governorate codes from Ministry of Interior.
  ///   - 3-digit sequence + gender digit + check digit.
  static final RegExp idRegex = RegExp(
    r'\b([23])(\d{2})(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])'
    r'(01|02|03|04|11|12|13|14|15|16|17|18|19|21|22|23|24|25|26|27|28|29|31|32|33|34|35|88)'
    r'(\d{3})(\d)(\d)\b',
  );

  /// Official governorate codes as defined by the Egyptian Ministry of Interior.
  ///
  /// Codes 01-04: Metropolitan governorates (Cairo, Alexandria, etc.).
  /// Codes 11-19: Lower Egypt (Delta) governorates.
  /// Codes 21-29: Upper Egypt governorates.
  /// Codes 31-35: Frontier governorates.
  /// Code 88: Born outside the Arab Republic of Egypt.
  static const Map<String, String> governorates = {
    '01': 'القاهرة',
    '02': 'الإسكندرية',
    '03': 'بورسعيد',
    '04': 'السويس',
    '11': 'دمياط',
    '12': 'الدقهلية',
    '13': 'الشرقية',
    '14': 'القليوبية',
    '15': 'كفر الشيخ',
    '16': 'الغربية',
    '17': 'المنوفية',
    '18': 'البحيرة',
    '19': 'الإسماعيلية',
    '21': 'الجيزة',
    '22': 'بني سويف',
    '23': 'الفيوم',
    '24': 'المنيا',
    '25': 'أسيوط',
    '26': 'سوهاج',
    '27': 'قنا',
    '28': 'أسوان',
    '29': 'الأقصر',
    '31': 'البحر الأحمر',
    '32': 'الوادي الجديد',
    '33': 'مطروح',
    '34': 'شمال سيناء',
    '35': 'جنوب سيناء',
    '88': 'خارج الجمهورية',
  };

  /// Official Ministry of Interior Modulo-11 weights for the first 13 digits.
  static const List<int> _checkWeights = [
    2,
    7,
    6,
    5,
    4,
    3,
    2,
    7,
    6,
    5,
    4,
    3,
    2,
  ];

  /// Computes the official Ministry of Interior Modulo-11 check digit (14th digit)
  /// from the first 13 digits of an Egyptian National ID.
  ///
  /// Returns `null` if [idOrFirst13] contains fewer than 13 digits.
  static int? computeCheckDigit(String idOrFirst13) {
    final normalized = normalizeArabicDigits(idOrFirst13);
    final digits = normalized.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 13) return null;

    var sum = 0;
    for (var i = 0; i < 13; i++) {
      final d = digits.codeUnitAt(i) - 0x30;
      if (d < 0 || d > 9) return null;
      sum += d * _checkWeights[i];
    }

    final remainder = sum % 11;
    final check = (11 - remainder) % 11;
    return check == 10 ? 0 : check;
  }

  /// Verifies whether a 14-digit Egyptian National ID has a valid 14th check digit.
  static bool hasValidChecksum(String nationalId) {
    final normalized = normalizeArabicDigits(nationalId);
    final digits = normalized.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 14) return false;

    final expected = computeCheckDigit(digits);
    if (expected == null) return false;
    final actual = digits.codeUnitAt(13) - 0x30;
    return actual == expected;
  }

  /// Parses a 14-digit Egyptian National ID from [rawText].
  ///
  /// Scans [rawText] for the first valid 14-digit sequence matching the
  /// National ID format. Performs full mathematical validation:
  ///   - Century and year decoding.
  ///   - Calendar sanity (e.g., Feb 29 only on leap years).
  ///   - Future birth date rejection (cannot be born after today).
  ///   - Governorate code existence.
  ///   - Gender parity extraction.
  ///   - Modulo-11 check digit computation (strictly enforced when [enforceChecksum] is `true`).
  ///
  /// Returns a [NationalIdResult] with all decoded fields if valid,
  /// or `null` if no valid National ID is found in the input text.
  static NationalIdResult? parse(
    String rawText, {
    bool enforceChecksum = false,
  }) {
    final match = idRegex.firstMatch(rawText);
    if (match == null) return null;

    final fullMatch = match.group(0)!;
    final centuryDigit = int.parse(match.group(1)!);
    final yearPart = int.parse(match.group(2)!);
    final monthPart = int.parse(match.group(3)!);
    final dayPart = int.parse(match.group(4)!);
    final govCode = match.group(5)!;
    final genderDigit = int.parse(match.group(7)!);

    // Decode the full 4-digit year from century indicator + year digits.
    final fullYear = (centuryDigit == 2 ? 1900 : 2000) + yearPart;

    // Validate the date using Dart's DateTime constructor.
    // DateTime silently overflows invalid dates (e.g., Feb 31 → Mar 3),
    // so we must verify the constructed date matches the input components.
    DateTime birthDate;
    try {
      birthDate = DateTime(fullYear, monthPart, dayPart);
      if (birthDate.year != fullYear ||
          birthDate.month != monthPart ||
          birthDate.day != dayPart) {
        // Date overflow detected (e.g., Feb 29 on a non-leap year).
        return null;
      }
    } catch (_) {
      return null;
    }

    // Reject impossible future birth dates (e.g., year 2099).
    if (birthDate.isAfter(DateTime.now())) {
      return null;
    }

    // Decode gender from the 13th digit (odd = male, even = female).
    final gender = (genderDigit % 2 != 0) ? Gender.male : Gender.female;

    // Look up the governorate name from the official code map.
    final govName = governorates[govCode];
    if (govName == null) return null;

    final checksumValid = hasValidChecksum(fullMatch);
    if (enforceChecksum && !checksumValid) {
      return null;
    }

    return NationalIdResult(
      nationalId: fullMatch,
      birthDate: birthDate,
      governorate: govName,
      governorateCode: govCode,
      gender: gender,
      isValid: true,
      hasValidChecksum: checksumValid,
    );
  }

  /// Normalizes Eastern Arabic (`٠-٩`) and Extended Arabic-Indic (`۰-۹`) numerals
  /// to standard ASCII digits (`0-9`).
  static String normalizeArabicDigits(String input) {
    if (input.isEmpty) return input;
    final buffer = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      final code = input.codeUnitAt(i);
      if (code >= 0x0660 && code <= 0x0669) {
        // Eastern Arabic numerals ٠-٩
        buffer.writeCharCode(0x30 + (code - 0x0660));
      } else if (code >= 0x06F0 && code <= 0x06F9) {
        // Extended Arabic-Indic / Persian numerals ۰-۹
        buffer.writeCharCode(0x30 + (code - 0x06F0));
      } else {
        buffer.writeCharCode(code);
      }
    }
    return buffer.toString();
  }

  /// Recovers digits frequently misread by Latin OCR engines on embossed Egyptian ID cards
  /// (e.g., `O`/`o` → `0`, `I`/`l`/`|` → `1`, `Z` → `2`, `S` → `5`, `B` → `8`).
  static String recoverOcrDigits(String input) {
    if (input.isEmpty) return input;
    final normalized = normalizeArabicDigits(input);
    final buffer = StringBuffer();
    for (var i = 0; i < normalized.length; i++) {
      final ch = normalized[i];
      switch (ch) {
        case 'O':
        case 'o':
        case 'Q':
          buffer.write('0');
        case 'I':
        case 'l':
        case '|':
        case '!':
          buffer.write('1');
        case 'Z':
        case 'z':
          buffer.write('2');
        case 'S':
        case 's':
          buffer.write('5');
        case 'G':
          buffer.write('6');
        case 'B':
          buffer.write('8');
        default:
          buffer.write(ch);
      }
    }
    return buffer.toString();
  }

  /// Extracts and parses a 14-digit Egyptian National ID from noisy OCR text.
  ///
  /// Resiliently handles:
  ///   - Eastern Arabic-Indic (`٠١٢٣٤٥٦٧٨٩`) and Extended (`۰۱۲۳۴۵۶۷۸۹`) numerals.
  ///   - Spaces, hyphens, dots, and MRZ `<` fillers inserted by OCR engines.
  ///   - Common Latin OCR visual homoglyphs on embossed ID cards (`O`→`0`, `I`→`1`, etc.).
  ///   - Multi-line document scans, prioritizing candidates whose 14th check digit is valid.
  static NationalIdResult? extractAndParse(
    String text, {
    bool enforceChecksum = false,
  }) {
    if (text.trim().isEmpty) return null;

    final candidates = <NationalIdResult>[];
    void addCandidate(NationalIdResult? result) {
      if (result == null) return;
      if (!candidates.any((c) => c.nationalId == result.nationalId)) {
        candidates.add(result);
      }
    }

    // 1. Direct match on raw text & Arabic-digit-normalized text
    final normalized = normalizeArabicDigits(text);
    for (final m in idRegex.allMatches(normalized)) {
      addCandidate(
        parse(m.group(0)!, enforceChecksum: enforceChecksum),
      );
    }

    // 2. Scan for digit clusters that may have spaces, hyphens, dots, or MRZ '<' between digits
    final digitClusters = RegExp(r'(?:[23][\s\-\.<]*[\d\s\-\.<]{13,30})')
        .allMatches(normalized);

    for (final clusterMatch in digitClusters) {
      final cluster = clusterMatch.group(0)!;
      final rawDigits = cluster.replaceAll(RegExp(r'\D'), '');

      if (rawDigits.length >= 14) {
        for (var i = 0; i <= rawDigits.length - 14; i++) {
          final slice = rawDigits.substring(i, i + 14);
          addCandidate(parse(slice, enforceChecksum: enforceChecksum));
        }
      }
    }

    // 3. Sliding 14-digit window across contiguous digits (handles MRZ lines like ID29506152101234<<<)
    final allDigits = normalized.replaceAll(RegExp(r'\D'), '');
    if (allDigits.length >= 14) {
      for (var i = 0; i <= allDigits.length - 14; i++) {
        final slice = allDigits.substring(i, i + 14);
        addCandidate(parse(slice, enforceChecksum: enforceChecksum));
      }
    }

    // 4. OCR Homoglyph recovery pass (only if no candidate found yet, to avoid false positives on prose)
    if (candidates.isEmpty) {
      final recovered = recoverOcrDigits(normalized);
      final recoveredClusters = RegExp(r'(?:[23][\s\-\.<]*[\d\s\-\.<]{13,30})')
          .allMatches(recovered);
      for (final clusterMatch in recoveredClusters) {
        final rawDigits = clusterMatch.group(0)!.replaceAll(RegExp(r'\D'), '');
        if (rawDigits.length >= 14) {
          for (var i = 0; i <= rawDigits.length - 14; i++) {
            final slice = rawDigits.substring(i, i + 14);
            addCandidate(parse(slice, enforceChecksum: enforceChecksum));
          }
        }
      }
    }

    if (candidates.isEmpty) return null;

    // Prefer candidates with a valid Modulo-11 check digit when multiple 14-digit sequences exist
    for (final candidate in candidates) {
      if (candidate.hasValidChecksum) {
        return candidate;
      }
    }

    return enforceChecksum ? null : candidates.first;
  }

  /// Formats a 14-digit National ID into visually grouped clusters for UI display:
  /// `2 95 06 15 21 0123 4`
  static String formatForDisplay(String nationalId) {
    final clean = nationalId.replaceAll(RegExp(r'\D'), '');
    if (clean.length != 14) return nationalId;
    return '${clean[0]} ${clean.substring(1, 3)} ${clean.substring(3, 5)} ${clean.substring(5, 7)} ${clean.substring(7, 9)} ${clean.substring(9, 13)} ${clean[13]}';
  }

  /// Sanitizes National ID to strictly continuous 14 digits for clipboard copying.
  static String sanitizeForClipboard(String nationalId) {
    return nationalId.replaceAll(RegExp(r'\D'), '');
  }
}

/// Gender decoded from the 13th digit of an Egyptian National ID.
enum Gender {
  /// Odd 13th digit indicates male.
  male,

  /// Even 13th digit indicates female.
  female,
}

/// Extension providing display labels for [Gender].
extension GenderExtension on Gender {
  /// Arabic display label.
  String get arabicLabel {
    switch (this) {
      case Gender.male:
        return 'ذكر';
      case Gender.female:
        return 'أنثى';
    }
  }

  /// English display label.
  String get englishLabel {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
    }
  }

  /// Database string key.
  String get dbKey {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
    }
  }
}

/// Immutable result of parsing a valid 14-digit Egyptian National ID.
///
/// Contains all decoded fields: the raw ID string, birth date,
/// governorate name, governorate code, and gender.
class NationalIdResult {
  /// The full 14-digit National ID string as extracted from the source text.
  final String nationalId;

  /// Decoded birth date (year, month, day) from digits 1-7.
  final DateTime birthDate;

  /// Arabic name of the governorate decoded from digits 8-9.
  final String governorate;

  /// Two-digit governorate code from digits 8-9.
  final String governorateCode;

  /// Gender decoded from digit 13 (odd = male, even = female).
  final Gender gender;

  /// Whether the ID passed all structural and calendar validation checks.
  final bool isValid;

  /// Whether the 14th digit matches the official Ministry of Interior Modulo-11 check digit.
  final bool hasValidChecksum;

  const NationalIdResult({
    required this.nationalId,
    required this.birthDate,
    required this.governorate,
    required this.governorateCode,
    required this.gender,
    required this.isValid,
    this.hasValidChecksum = false,
  });
}
