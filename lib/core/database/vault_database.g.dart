// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_database.dart';

// ignore_for_file: type=lint
class $VaultEntriesTable extends VaultEntries
    with TableInfo<$VaultEntriesTable, VaultEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VaultEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawPayloadMeta = const VerificationMeta(
    'rawPayload',
  );
  @override
  late final GeneratedColumn<String> rawPayload = GeneratedColumn<String>(
    'raw_payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cleanUrlMeta = const VerificationMeta(
    'cleanUrl',
  );
  @override
  late final GeneratedColumn<String> cleanUrl = GeneratedColumn<String>(
    'clean_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _thumbnailPathMeta = const VerificationMeta(
    'thumbnailPath',
  );
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
    'thumbnail_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nationalIdMeta = const VerificationMeta(
    'nationalId',
  );
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
    'national_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _governorateMeta = const VerificationMeta(
    'governorate',
  );
  @override
  late final GeneratedColumn<String> governorate = GeneratedColumn<String>(
    'governorate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ocrExtractedTextMeta = const VerificationMeta(
    'ocrExtractedText',
  );
  @override
  late final GeneratedColumn<String> ocrExtractedText = GeneratedColumn<String>(
    'ocr_extracted_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processingStatusMeta = const VerificationMeta(
    'processingStatus',
  );
  @override
  late final GeneratedColumn<String> processingStatus = GeneratedColumn<String>(
    'processing_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _ttlExpiryMeta = const VerificationMeta(
    'ttlExpiry',
  );
  @override
  late final GeneratedColumn<DateTime> ttlExpiry = GeneratedColumn<DateTime>(
    'ttl_expiry',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    rawPayload,
    cleanUrl,
    filePath,
    title,
    description,
    thumbnailPath,
    nationalId,
    governorate,
    birthDate,
    gender,
    ocrExtractedText,
    processingStatus,
    ttlExpiry,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vault_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<VaultEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('raw_payload')) {
      context.handle(
        _rawPayloadMeta,
        rawPayload.isAcceptableOrUnknown(data['raw_payload']!, _rawPayloadMeta),
      );
    } else if (isInserting) {
      context.missing(_rawPayloadMeta);
    }
    if (data.containsKey('clean_url')) {
      context.handle(
        _cleanUrlMeta,
        cleanUrl.isAcceptableOrUnknown(data['clean_url']!, _cleanUrlMeta),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
        _thumbnailPathMeta,
        thumbnailPath.isAcceptableOrUnknown(
          data['thumbnail_path']!,
          _thumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('national_id')) {
      context.handle(
        _nationalIdMeta,
        nationalId.isAcceptableOrUnknown(data['national_id']!, _nationalIdMeta),
      );
    }
    if (data.containsKey('governorate')) {
      context.handle(
        _governorateMeta,
        governorate.isAcceptableOrUnknown(
          data['governorate']!,
          _governorateMeta,
        ),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('ocr_extracted_text')) {
      context.handle(
        _ocrExtractedTextMeta,
        ocrExtractedText.isAcceptableOrUnknown(
          data['ocr_extracted_text']!,
          _ocrExtractedTextMeta,
        ),
      );
    }
    if (data.containsKey('processing_status')) {
      context.handle(
        _processingStatusMeta,
        processingStatus.isAcceptableOrUnknown(
          data['processing_status']!,
          _processingStatusMeta,
        ),
      );
    }
    if (data.containsKey('ttl_expiry')) {
      context.handle(
        _ttlExpiryMeta,
        ttlExpiry.isAcceptableOrUnknown(data['ttl_expiry']!, _ttlExpiryMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VaultEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VaultEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      rawPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_payload'],
      )!,
      cleanUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clean_url'],
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      ),
      nationalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}national_id'],
      ),
      governorate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}governorate'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      ocrExtractedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ocr_extracted_text'],
      ),
      processingStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_status'],
      )!,
      ttlExpiry: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ttl_expiry'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VaultEntriesTable createAlias(String alias) {
    return $VaultEntriesTable(attachedDatabase, alias);
  }
}

class VaultEntry extends DataClass implements Insertable<VaultEntry> {
  /// Auto-incrementing primary key.
  final int id;

  /// Vault routing category: docs, readLater, quickNotes, or tempVault.
  /// Stored as a string key matching [VaultCategory.dbKey].
  final String category;

  /// Original unsanitized payload exactly as received from the Share Sheet.
  /// Preserved for debugging and fallback display.
  final String rawPayload;

  /// Sanitized clean URL after stripping tracking parameters.
  /// Null for non-URL payloads (plain text, images without URLs).
  final String? cleanUrl;

  /// Local file path for image/document payloads stored in /vault/docs/.
  /// Null for text-only or URL-only payloads.
  final String? filePath;

  /// [Sprint 2] Page title extracted from OpenGraph or OCR document header.
  final String? title;

  /// [Sprint 2] Page description from OpenGraph metadata.
  final String? description;

  /// [Sprint 2] Local cached path for OpenGraph thumbnail image.
  final String? thumbnailPath;

  /// [Sprint 2] Extracted 14-digit Egyptian National ID string.
  final String? nationalId;

  /// [Sprint 2] Governorate name decoded from the National ID.
  final String? governorate;

  /// [Sprint 2] Birth date decoded from the National ID.
  final DateTime? birthDate;

  /// [Sprint 2] Gender decoded from the National ID (male/female).
  final String? gender;

  /// [Sprint 2] Full OCR-extracted text from document images.
  final String? ocrExtractedText;

  /// Processing pipeline status: pending, completed, requiresReview, failed.
  /// Stored as a string key matching [ProcessingStatus.dbKey].
  final String processingStatus;

  /// Auto-purge expiry timestamp for tempVault items.
  /// Null for non-temporary items (docs, readLater, quickNotes).
  final DateTime? ttlExpiry;

  /// Timestamp of when the item was first captured and saved.
  final DateTime createdAt;
  const VaultEntry({
    required this.id,
    required this.category,
    required this.rawPayload,
    this.cleanUrl,
    this.filePath,
    this.title,
    this.description,
    this.thumbnailPath,
    this.nationalId,
    this.governorate,
    this.birthDate,
    this.gender,
    this.ocrExtractedText,
    required this.processingStatus,
    this.ttlExpiry,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['raw_payload'] = Variable<String>(rawPayload);
    if (!nullToAbsent || cleanUrl != null) {
      map['clean_url'] = Variable<String>(cleanUrl);
    }
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    if (!nullToAbsent || nationalId != null) {
      map['national_id'] = Variable<String>(nationalId);
    }
    if (!nullToAbsent || governorate != null) {
      map['governorate'] = Variable<String>(governorate);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || ocrExtractedText != null) {
      map['ocr_extracted_text'] = Variable<String>(ocrExtractedText);
    }
    map['processing_status'] = Variable<String>(processingStatus);
    if (!nullToAbsent || ttlExpiry != null) {
      map['ttl_expiry'] = Variable<DateTime>(ttlExpiry);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VaultEntriesCompanion toCompanion(bool nullToAbsent) {
    return VaultEntriesCompanion(
      id: Value(id),
      category: Value(category),
      rawPayload: Value(rawPayload),
      cleanUrl: cleanUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(cleanUrl),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      thumbnailPath: thumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailPath),
      nationalId: nationalId == null && nullToAbsent
          ? const Value.absent()
          : Value(nationalId),
      governorate: governorate == null && nullToAbsent
          ? const Value.absent()
          : Value(governorate),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      ocrExtractedText: ocrExtractedText == null && nullToAbsent
          ? const Value.absent()
          : Value(ocrExtractedText),
      processingStatus: Value(processingStatus),
      ttlExpiry: ttlExpiry == null && nullToAbsent
          ? const Value.absent()
          : Value(ttlExpiry),
      createdAt: Value(createdAt),
    );
  }

  factory VaultEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VaultEntry(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      rawPayload: serializer.fromJson<String>(json['rawPayload']),
      cleanUrl: serializer.fromJson<String?>(json['cleanUrl']),
      filePath: serializer.fromJson<String?>(json['filePath']),
      title: serializer.fromJson<String?>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnailPath']),
      nationalId: serializer.fromJson<String?>(json['nationalId']),
      governorate: serializer.fromJson<String?>(json['governorate']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      gender: serializer.fromJson<String?>(json['gender']),
      ocrExtractedText: serializer.fromJson<String?>(json['ocrExtractedText']),
      processingStatus: serializer.fromJson<String>(json['processingStatus']),
      ttlExpiry: serializer.fromJson<DateTime?>(json['ttlExpiry']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'rawPayload': serializer.toJson<String>(rawPayload),
      'cleanUrl': serializer.toJson<String?>(cleanUrl),
      'filePath': serializer.toJson<String?>(filePath),
      'title': serializer.toJson<String?>(title),
      'description': serializer.toJson<String?>(description),
      'thumbnailPath': serializer.toJson<String?>(thumbnailPath),
      'nationalId': serializer.toJson<String?>(nationalId),
      'governorate': serializer.toJson<String?>(governorate),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'gender': serializer.toJson<String?>(gender),
      'ocrExtractedText': serializer.toJson<String?>(ocrExtractedText),
      'processingStatus': serializer.toJson<String>(processingStatus),
      'ttlExpiry': serializer.toJson<DateTime?>(ttlExpiry),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VaultEntry copyWith({
    int? id,
    String? category,
    String? rawPayload,
    Value<String?> cleanUrl = const Value.absent(),
    Value<String?> filePath = const Value.absent(),
    Value<String?> title = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> thumbnailPath = const Value.absent(),
    Value<String?> nationalId = const Value.absent(),
    Value<String?> governorate = const Value.absent(),
    Value<DateTime?> birthDate = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<String?> ocrExtractedText = const Value.absent(),
    String? processingStatus,
    Value<DateTime?> ttlExpiry = const Value.absent(),
    DateTime? createdAt,
  }) => VaultEntry(
    id: id ?? this.id,
    category: category ?? this.category,
    rawPayload: rawPayload ?? this.rawPayload,
    cleanUrl: cleanUrl.present ? cleanUrl.value : this.cleanUrl,
    filePath: filePath.present ? filePath.value : this.filePath,
    title: title.present ? title.value : this.title,
    description: description.present ? description.value : this.description,
    thumbnailPath: thumbnailPath.present
        ? thumbnailPath.value
        : this.thumbnailPath,
    nationalId: nationalId.present ? nationalId.value : this.nationalId,
    governorate: governorate.present ? governorate.value : this.governorate,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    gender: gender.present ? gender.value : this.gender,
    ocrExtractedText: ocrExtractedText.present
        ? ocrExtractedText.value
        : this.ocrExtractedText,
    processingStatus: processingStatus ?? this.processingStatus,
    ttlExpiry: ttlExpiry.present ? ttlExpiry.value : this.ttlExpiry,
    createdAt: createdAt ?? this.createdAt,
  );
  VaultEntry copyWithCompanion(VaultEntriesCompanion data) {
    return VaultEntry(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      rawPayload: data.rawPayload.present
          ? data.rawPayload.value
          : this.rawPayload,
      cleanUrl: data.cleanUrl.present ? data.cleanUrl.value : this.cleanUrl,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      nationalId: data.nationalId.present
          ? data.nationalId.value
          : this.nationalId,
      governorate: data.governorate.present
          ? data.governorate.value
          : this.governorate,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      gender: data.gender.present ? data.gender.value : this.gender,
      ocrExtractedText: data.ocrExtractedText.present
          ? data.ocrExtractedText.value
          : this.ocrExtractedText,
      processingStatus: data.processingStatus.present
          ? data.processingStatus.value
          : this.processingStatus,
      ttlExpiry: data.ttlExpiry.present ? data.ttlExpiry.value : this.ttlExpiry,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VaultEntry(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('rawPayload: $rawPayload, ')
          ..write('cleanUrl: $cleanUrl, ')
          ..write('filePath: $filePath, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('nationalId: $nationalId, ')
          ..write('governorate: $governorate, ')
          ..write('birthDate: $birthDate, ')
          ..write('gender: $gender, ')
          ..write('ocrExtractedText: $ocrExtractedText, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('ttlExpiry: $ttlExpiry, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    rawPayload,
    cleanUrl,
    filePath,
    title,
    description,
    thumbnailPath,
    nationalId,
    governorate,
    birthDate,
    gender,
    ocrExtractedText,
    processingStatus,
    ttlExpiry,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VaultEntry &&
          other.id == this.id &&
          other.category == this.category &&
          other.rawPayload == this.rawPayload &&
          other.cleanUrl == this.cleanUrl &&
          other.filePath == this.filePath &&
          other.title == this.title &&
          other.description == this.description &&
          other.thumbnailPath == this.thumbnailPath &&
          other.nationalId == this.nationalId &&
          other.governorate == this.governorate &&
          other.birthDate == this.birthDate &&
          other.gender == this.gender &&
          other.ocrExtractedText == this.ocrExtractedText &&
          other.processingStatus == this.processingStatus &&
          other.ttlExpiry == this.ttlExpiry &&
          other.createdAt == this.createdAt);
}

class VaultEntriesCompanion extends UpdateCompanion<VaultEntry> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> rawPayload;
  final Value<String?> cleanUrl;
  final Value<String?> filePath;
  final Value<String?> title;
  final Value<String?> description;
  final Value<String?> thumbnailPath;
  final Value<String?> nationalId;
  final Value<String?> governorate;
  final Value<DateTime?> birthDate;
  final Value<String?> gender;
  final Value<String?> ocrExtractedText;
  final Value<String> processingStatus;
  final Value<DateTime?> ttlExpiry;
  final Value<DateTime> createdAt;
  const VaultEntriesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.rawPayload = const Value.absent(),
    this.cleanUrl = const Value.absent(),
    this.filePath = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.governorate = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.gender = const Value.absent(),
    this.ocrExtractedText = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.ttlExpiry = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VaultEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String rawPayload,
    this.cleanUrl = const Value.absent(),
    this.filePath = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.governorate = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.gender = const Value.absent(),
    this.ocrExtractedText = const Value.absent(),
    this.processingStatus = const Value.absent(),
    this.ttlExpiry = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : category = Value(category),
       rawPayload = Value(rawPayload);
  static Insertable<VaultEntry> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? rawPayload,
    Expression<String>? cleanUrl,
    Expression<String>? filePath,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? thumbnailPath,
    Expression<String>? nationalId,
    Expression<String>? governorate,
    Expression<DateTime>? birthDate,
    Expression<String>? gender,
    Expression<String>? ocrExtractedText,
    Expression<String>? processingStatus,
    Expression<DateTime>? ttlExpiry,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (rawPayload != null) 'raw_payload': rawPayload,
      if (cleanUrl != null) 'clean_url': cleanUrl,
      if (filePath != null) 'file_path': filePath,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (nationalId != null) 'national_id': nationalId,
      if (governorate != null) 'governorate': governorate,
      if (birthDate != null) 'birth_date': birthDate,
      if (gender != null) 'gender': gender,
      if (ocrExtractedText != null) 'ocr_extracted_text': ocrExtractedText,
      if (processingStatus != null) 'processing_status': processingStatus,
      if (ttlExpiry != null) 'ttl_expiry': ttlExpiry,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VaultEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? category,
    Value<String>? rawPayload,
    Value<String?>? cleanUrl,
    Value<String?>? filePath,
    Value<String?>? title,
    Value<String?>? description,
    Value<String?>? thumbnailPath,
    Value<String?>? nationalId,
    Value<String?>? governorate,
    Value<DateTime?>? birthDate,
    Value<String?>? gender,
    Value<String?>? ocrExtractedText,
    Value<String>? processingStatus,
    Value<DateTime?>? ttlExpiry,
    Value<DateTime>? createdAt,
  }) {
    return VaultEntriesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      rawPayload: rawPayload ?? this.rawPayload,
      cleanUrl: cleanUrl ?? this.cleanUrl,
      filePath: filePath ?? this.filePath,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      nationalId: nationalId ?? this.nationalId,
      governorate: governorate ?? this.governorate,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      ocrExtractedText: ocrExtractedText ?? this.ocrExtractedText,
      processingStatus: processingStatus ?? this.processingStatus,
      ttlExpiry: ttlExpiry ?? this.ttlExpiry,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rawPayload.present) {
      map['raw_payload'] = Variable<String>(rawPayload.value);
    }
    if (cleanUrl.present) {
      map['clean_url'] = Variable<String>(cleanUrl.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (governorate.present) {
      map['governorate'] = Variable<String>(governorate.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (ocrExtractedText.present) {
      map['ocr_extracted_text'] = Variable<String>(ocrExtractedText.value);
    }
    if (processingStatus.present) {
      map['processing_status'] = Variable<String>(processingStatus.value);
    }
    if (ttlExpiry.present) {
      map['ttl_expiry'] = Variable<DateTime>(ttlExpiry.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VaultEntriesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('rawPayload: $rawPayload, ')
          ..write('cleanUrl: $cleanUrl, ')
          ..write('filePath: $filePath, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('nationalId: $nationalId, ')
          ..write('governorate: $governorate, ')
          ..write('birthDate: $birthDate, ')
          ..write('gender: $gender, ')
          ..write('ocrExtractedText: $ocrExtractedText, ')
          ..write('processingStatus: $processingStatus, ')
          ..write('ttlExpiry: $ttlExpiry, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$VaultDatabase extends GeneratedDatabase {
  _$VaultDatabase(QueryExecutor e) : super(e);
  $VaultDatabaseManager get managers => $VaultDatabaseManager(this);
  late final $VaultEntriesTable vaultEntries = $VaultEntriesTable(this);
  late final VaultInsertDao vaultInsertDao = VaultInsertDao(
    this as VaultDatabase,
  );
  late final VaultQueryDao vaultQueryDao = VaultQueryDao(this as VaultDatabase);
  late final VaultDeleteDao vaultDeleteDao = VaultDeleteDao(
    this as VaultDatabase,
  );
  late final VaultUpdateDao vaultUpdateDao = VaultUpdateDao(
    this as VaultDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [vaultEntries];
}

typedef $$VaultEntriesTableCreateCompanionBuilder =
    VaultEntriesCompanion Function({
      Value<int> id,
      required String category,
      required String rawPayload,
      Value<String?> cleanUrl,
      Value<String?> filePath,
      Value<String?> title,
      Value<String?> description,
      Value<String?> thumbnailPath,
      Value<String?> nationalId,
      Value<String?> governorate,
      Value<DateTime?> birthDate,
      Value<String?> gender,
      Value<String?> ocrExtractedText,
      Value<String> processingStatus,
      Value<DateTime?> ttlExpiry,
      Value<DateTime> createdAt,
    });
typedef $$VaultEntriesTableUpdateCompanionBuilder =
    VaultEntriesCompanion Function({
      Value<int> id,
      Value<String> category,
      Value<String> rawPayload,
      Value<String?> cleanUrl,
      Value<String?> filePath,
      Value<String?> title,
      Value<String?> description,
      Value<String?> thumbnailPath,
      Value<String?> nationalId,
      Value<String?> governorate,
      Value<DateTime?> birthDate,
      Value<String?> gender,
      Value<String?> ocrExtractedText,
      Value<String> processingStatus,
      Value<DateTime?> ttlExpiry,
      Value<DateTime> createdAt,
    });

class $$VaultEntriesTableFilterComposer
    extends Composer<_$VaultDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cleanUrl => $composableBuilder(
    column: $table.cleanUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ocrExtractedText => $composableBuilder(
    column: $table.ocrExtractedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get ttlExpiry => $composableBuilder(
    column: $table.ttlExpiry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VaultEntriesTableOrderingComposer
    extends Composer<_$VaultDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cleanUrl => $composableBuilder(
    column: $table.cleanUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ocrExtractedText => $composableBuilder(
    column: $table.ocrExtractedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get ttlExpiry => $composableBuilder(
    column: $table.ttlExpiry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VaultEntriesTableAnnotationComposer
    extends Composer<_$VaultDatabase, $VaultEntriesTable> {
  $$VaultEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cleanUrl =>
      $composableBuilder(column: $table.cleanUrl, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get ocrExtractedText => $composableBuilder(
    column: $table.ocrExtractedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingStatus => $composableBuilder(
    column: $table.processingStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get ttlExpiry =>
      $composableBuilder(column: $table.ttlExpiry, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$VaultEntriesTableTableManager
    extends
        RootTableManager<
          _$VaultDatabase,
          $VaultEntriesTable,
          VaultEntry,
          $$VaultEntriesTableFilterComposer,
          $$VaultEntriesTableOrderingComposer,
          $$VaultEntriesTableAnnotationComposer,
          $$VaultEntriesTableCreateCompanionBuilder,
          $$VaultEntriesTableUpdateCompanionBuilder,
          (
            VaultEntry,
            BaseReferences<_$VaultDatabase, $VaultEntriesTable, VaultEntry>,
          ),
          VaultEntry,
          PrefetchHooks Function()
        > {
  $$VaultEntriesTableTableManager(_$VaultDatabase db, $VaultEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VaultEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VaultEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VaultEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> rawPayload = const Value.absent(),
                Value<String?> cleanUrl = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<String?> nationalId = const Value.absent(),
                Value<String?> governorate = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> ocrExtractedText = const Value.absent(),
                Value<String> processingStatus = const Value.absent(),
                Value<DateTime?> ttlExpiry = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VaultEntriesCompanion(
                id: id,
                category: category,
                rawPayload: rawPayload,
                cleanUrl: cleanUrl,
                filePath: filePath,
                title: title,
                description: description,
                thumbnailPath: thumbnailPath,
                nationalId: nationalId,
                governorate: governorate,
                birthDate: birthDate,
                gender: gender,
                ocrExtractedText: ocrExtractedText,
                processingStatus: processingStatus,
                ttlExpiry: ttlExpiry,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String category,
                required String rawPayload,
                Value<String?> cleanUrl = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<String?> nationalId = const Value.absent(),
                Value<String?> governorate = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> ocrExtractedText = const Value.absent(),
                Value<String> processingStatus = const Value.absent(),
                Value<DateTime?> ttlExpiry = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VaultEntriesCompanion.insert(
                id: id,
                category: category,
                rawPayload: rawPayload,
                cleanUrl: cleanUrl,
                filePath: filePath,
                title: title,
                description: description,
                thumbnailPath: thumbnailPath,
                nationalId: nationalId,
                governorate: governorate,
                birthDate: birthDate,
                gender: gender,
                ocrExtractedText: ocrExtractedText,
                processingStatus: processingStatus,
                ttlExpiry: ttlExpiry,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VaultEntriesTable, VaultEntry>(table),
                  BaseReferences<
                    _$VaultDatabase,
                    $VaultEntriesTable,
                    VaultEntry
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VaultEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$VaultDatabase,
      $VaultEntriesTable,
      VaultEntry,
      $$VaultEntriesTableFilterComposer,
      $$VaultEntriesTableOrderingComposer,
      $$VaultEntriesTableAnnotationComposer,
      $$VaultEntriesTableCreateCompanionBuilder,
      $$VaultEntriesTableUpdateCompanionBuilder,
      (
        VaultEntry,
        BaseReferences<_$VaultDatabase, $VaultEntriesTable, VaultEntry>,
      ),
      VaultEntry,
      PrefetchHooks Function()
    >;

class $VaultDatabaseManager {
  final _$VaultDatabase _db;
  $VaultDatabaseManager(this._db);
  $$VaultEntriesTableTableManager get vaultEntries =>
      $$VaultEntriesTableTableManager(_db, _db.vaultEntries);
}
