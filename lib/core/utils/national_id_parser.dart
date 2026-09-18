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

  /// Parses a 14-digit Egyptian National ID from [rawText].
  ///
  /// Scans [rawText] for the first valid 14-digit sequence matching the
  /// National ID format. Performs full mathematical validation:
  ///   - Century and year decoding.
  ///   - Calendar sanity (e.g., Feb 29 only on leap years).
  ///   - Governorate code existence.
  ///   - Gender parity extraction.
  ///
  /// Returns a [NationalIdResult] with all decoded fields if valid,
  /// or `null` if no valid National ID is found in the input text.
  static NationalIdResult? parse(String rawText) {
    final match = idRegex.firstMatch(rawText);
    if (match == null) return null;

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

    // Decode gender from the 13th digit (odd = male, even = female).
    final gender = (genderDigit % 2 != 0) ? Gender.male : Gender.female;

    // Look up the governorate name from the official code map.
    final govName = governorates[govCode];
    if (govName == null) return null;

    return NationalIdResult(
      nationalId: match.group(0)!,
      birthDate: birthDate,
      governorate: govName,
      governorateCode: govCode,
      gender: gender,
      isValid: true,
    );
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

  /// Whether the ID passed all validation checks.
  final bool isValid;

  const NationalIdResult({
    required this.nationalId,
    required this.birthDate,
    required this.governorate,
    required this.governorateCode,
    required this.gender,
    required this.isValid,
  });
}
