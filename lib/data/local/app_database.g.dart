// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CampusItemsTable extends CampusItems
    with TableInfo<$CampusItemsTable, CampusItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampusItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportKindMeta = const VerificationMeta(
    'reportKind',
  );
  @override
  late final GeneratedColumn<String> reportKind = GeneratedColumn<String>(
    'report_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportedAtMeta = const VerificationMeta(
    'reportedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reportedAt = GeneratedColumn<DateTime>(
    'reported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dropOffLocationMeta = const VerificationMeta(
    'dropOffLocation',
  );
  @override
  late final GeneratedColumn<String> dropOffLocation = GeneratedColumn<String>(
    'drop_off_location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reporterContactMeta = const VerificationMeta(
    'reporterContact',
  );
  @override
  late final GeneratedColumn<String> reporterContact = GeneratedColumn<String>(
    'reporter_contact',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    category,
    location,
    description,
    reportKind,
    status,
    reportedAt,
    dropOffLocation,
    reporterContact,
    photoPath,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campus_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CampusItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('report_kind')) {
      context.handle(
        _reportKindMeta,
        reportKind.isAcceptableOrUnknown(data['report_kind']!, _reportKindMeta),
      );
    } else if (isInserting) {
      context.missing(_reportKindMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('reported_at')) {
      context.handle(
        _reportedAtMeta,
        reportedAt.isAcceptableOrUnknown(data['reported_at']!, _reportedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reportedAtMeta);
    }
    if (data.containsKey('drop_off_location')) {
      context.handle(
        _dropOffLocationMeta,
        dropOffLocation.isAcceptableOrUnknown(
          data['drop_off_location']!,
          _dropOffLocationMeta,
        ),
      );
    }
    if (data.containsKey('reporter_contact')) {
      context.handle(
        _reporterContactMeta,
        reporterContact.isAcceptableOrUnknown(
          data['reporter_contact']!,
          _reporterContactMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CampusItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CampusItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      reportKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_kind'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      reportedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reported_at'],
      )!,
      dropOffLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}drop_off_location'],
      ),
      reporterContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reporter_contact'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $CampusItemsTable createAlias(String alias) {
    return $CampusItemsTable(attachedDatabase, alias);
  }
}

class CampusItem extends DataClass implements Insertable<CampusItem> {
  final String id;
  final String title;
  final String category;
  final String location;
  final String description;
  final String reportKind;
  final String status;
  final DateTime reportedAt;
  final String? dropOffLocation;
  final String? reporterContact;
  final String? photoPath;
  final bool pendingSync;
  const CampusItem({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.description,
    required this.reportKind,
    required this.status,
    required this.reportedAt,
    this.dropOffLocation,
    this.reporterContact,
    this.photoPath,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['location'] = Variable<String>(location);
    map['description'] = Variable<String>(description);
    map['report_kind'] = Variable<String>(reportKind);
    map['status'] = Variable<String>(status);
    map['reported_at'] = Variable<DateTime>(reportedAt);
    if (!nullToAbsent || dropOffLocation != null) {
      map['drop_off_location'] = Variable<String>(dropOffLocation);
    }
    if (!nullToAbsent || reporterContact != null) {
      map['reporter_contact'] = Variable<String>(reporterContact);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  CampusItemsCompanion toCompanion(bool nullToAbsent) {
    return CampusItemsCompanion(
      id: Value(id),
      title: Value(title),
      category: Value(category),
      location: Value(location),
      description: Value(description),
      reportKind: Value(reportKind),
      status: Value(status),
      reportedAt: Value(reportedAt),
      dropOffLocation: dropOffLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(dropOffLocation),
      reporterContact: reporterContact == null && nullToAbsent
          ? const Value.absent()
          : Value(reporterContact),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      pendingSync: Value(pendingSync),
    );
  }

  factory CampusItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CampusItem(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      location: serializer.fromJson<String>(json['location']),
      description: serializer.fromJson<String>(json['description']),
      reportKind: serializer.fromJson<String>(json['reportKind']),
      status: serializer.fromJson<String>(json['status']),
      reportedAt: serializer.fromJson<DateTime>(json['reportedAt']),
      dropOffLocation: serializer.fromJson<String?>(json['dropOffLocation']),
      reporterContact: serializer.fromJson<String?>(json['reporterContact']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'location': serializer.toJson<String>(location),
      'description': serializer.toJson<String>(description),
      'reportKind': serializer.toJson<String>(reportKind),
      'status': serializer.toJson<String>(status),
      'reportedAt': serializer.toJson<DateTime>(reportedAt),
      'dropOffLocation': serializer.toJson<String?>(dropOffLocation),
      'reporterContact': serializer.toJson<String?>(reporterContact),
      'photoPath': serializer.toJson<String?>(photoPath),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  CampusItem copyWith({
    String? id,
    String? title,
    String? category,
    String? location,
    String? description,
    String? reportKind,
    String? status,
    DateTime? reportedAt,
    Value<String?> dropOffLocation = const Value.absent(),
    Value<String?> reporterContact = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    bool? pendingSync,
  }) => CampusItem(
    id: id ?? this.id,
    title: title ?? this.title,
    category: category ?? this.category,
    location: location ?? this.location,
    description: description ?? this.description,
    reportKind: reportKind ?? this.reportKind,
    status: status ?? this.status,
    reportedAt: reportedAt ?? this.reportedAt,
    dropOffLocation: dropOffLocation.present
        ? dropOffLocation.value
        : this.dropOffLocation,
    reporterContact: reporterContact.present
        ? reporterContact.value
        : this.reporterContact,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  CampusItem copyWithCompanion(CampusItemsCompanion data) {
    return CampusItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      location: data.location.present ? data.location.value : this.location,
      description: data.description.present
          ? data.description.value
          : this.description,
      reportKind: data.reportKind.present
          ? data.reportKind.value
          : this.reportKind,
      status: data.status.present ? data.status.value : this.status,
      reportedAt: data.reportedAt.present
          ? data.reportedAt.value
          : this.reportedAt,
      dropOffLocation: data.dropOffLocation.present
          ? data.dropOffLocation.value
          : this.dropOffLocation,
      reporterContact: data.reporterContact.present
          ? data.reporterContact.value
          : this.reporterContact,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CampusItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('location: $location, ')
          ..write('description: $description, ')
          ..write('reportKind: $reportKind, ')
          ..write('status: $status, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('dropOffLocation: $dropOffLocation, ')
          ..write('reporterContact: $reporterContact, ')
          ..write('photoPath: $photoPath, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    category,
    location,
    description,
    reportKind,
    status,
    reportedAt,
    dropOffLocation,
    reporterContact,
    photoPath,
    pendingSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CampusItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.category == this.category &&
          other.location == this.location &&
          other.description == this.description &&
          other.reportKind == this.reportKind &&
          other.status == this.status &&
          other.reportedAt == this.reportedAt &&
          other.dropOffLocation == this.dropOffLocation &&
          other.reporterContact == this.reporterContact &&
          other.photoPath == this.photoPath &&
          other.pendingSync == this.pendingSync);
}

class CampusItemsCompanion extends UpdateCompanion<CampusItem> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> category;
  final Value<String> location;
  final Value<String> description;
  final Value<String> reportKind;
  final Value<String> status;
  final Value<DateTime> reportedAt;
  final Value<String?> dropOffLocation;
  final Value<String?> reporterContact;
  final Value<String?> photoPath;
  final Value<bool> pendingSync;
  final Value<int> rowid;
  const CampusItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.location = const Value.absent(),
    this.description = const Value.absent(),
    this.reportKind = const Value.absent(),
    this.status = const Value.absent(),
    this.reportedAt = const Value.absent(),
    this.dropOffLocation = const Value.absent(),
    this.reporterContact = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CampusItemsCompanion.insert({
    required String id,
    required String title,
    required String category,
    required String location,
    required String description,
    required String reportKind,
    required String status,
    required DateTime reportedAt,
    this.dropOffLocation = const Value.absent(),
    this.reporterContact = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       category = Value(category),
       location = Value(location),
       description = Value(description),
       reportKind = Value(reportKind),
       status = Value(status),
       reportedAt = Value(reportedAt);
  static Insertable<CampusItem> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? category,
    Expression<String>? location,
    Expression<String>? description,
    Expression<String>? reportKind,
    Expression<String>? status,
    Expression<DateTime>? reportedAt,
    Expression<String>? dropOffLocation,
    Expression<String>? reporterContact,
    Expression<String>? photoPath,
    Expression<bool>? pendingSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (location != null) 'location': location,
      if (description != null) 'description': description,
      if (reportKind != null) 'report_kind': reportKind,
      if (status != null) 'status': status,
      if (reportedAt != null) 'reported_at': reportedAt,
      if (dropOffLocation != null) 'drop_off_location': dropOffLocation,
      if (reporterContact != null) 'reporter_contact': reporterContact,
      if (photoPath != null) 'photo_path': photoPath,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CampusItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? category,
    Value<String>? location,
    Value<String>? description,
    Value<String>? reportKind,
    Value<String>? status,
    Value<DateTime>? reportedAt,
    Value<String?>? dropOffLocation,
    Value<String?>? reporterContact,
    Value<String?>? photoPath,
    Value<bool>? pendingSync,
    Value<int>? rowid,
  }) {
    return CampusItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      location: location ?? this.location,
      description: description ?? this.description,
      reportKind: reportKind ?? this.reportKind,
      status: status ?? this.status,
      reportedAt: reportedAt ?? this.reportedAt,
      dropOffLocation: dropOffLocation ?? this.dropOffLocation,
      reporterContact: reporterContact ?? this.reporterContact,
      photoPath: photoPath ?? this.photoPath,
      pendingSync: pendingSync ?? this.pendingSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (reportKind.present) {
      map['report_kind'] = Variable<String>(reportKind.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (reportedAt.present) {
      map['reported_at'] = Variable<DateTime>(reportedAt.value);
    }
    if (dropOffLocation.present) {
      map['drop_off_location'] = Variable<String>(dropOffLocation.value);
    }
    if (reporterContact.present) {
      map['reporter_contact'] = Variable<String>(reporterContact.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampusItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('location: $location, ')
          ..write('description: $description, ')
          ..write('reportKind: $reportKind, ')
          ..write('status: $status, ')
          ..write('reportedAt: $reportedAt, ')
          ..write('dropOffLocation: $dropOffLocation, ')
          ..write('reporterContact: $reporterContact, ')
          ..write('photoPath: $photoPath, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClaimsTable extends Claims with TableInfo<$ClaimsTable, Claim> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClaimsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _studentIdMeta = const VerificationMeta(
    'studentId',
  );
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
    'student_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerMeta = const VerificationMeta('answer');
  @override
  late final GeneratedColumn<String> answer = GeneratedColumn<String>(
    'answer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    studentId,
    phone,
    answer,
    createdAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'claims';
  @override
  VerificationContext validateIntegrity(
    Insertable<Claim> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(
        _studentIdMeta,
        studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('answer')) {
      context.handle(
        _answerMeta,
        answer.isAcceptableOrUnknown(data['answer']!, _answerMeta),
      );
    } else if (isInserting) {
      context.missing(_answerMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Claim map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Claim(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      studentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}student_id'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      answer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answer'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ClaimsTable createAlias(String alias) {
    return $ClaimsTable(attachedDatabase, alias);
  }
}

class Claim extends DataClass implements Insertable<Claim> {
  final String id;
  final String itemId;
  final String studentId;
  final String phone;
  final String answer;
  final DateTime createdAt;
  final String status;
  const Claim({
    required this.id,
    required this.itemId,
    required this.studentId,
    required this.phone,
    required this.answer,
    required this.createdAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_id'] = Variable<String>(itemId);
    map['student_id'] = Variable<String>(studentId);
    map['phone'] = Variable<String>(phone);
    map['answer'] = Variable<String>(answer);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  ClaimsCompanion toCompanion(bool nullToAbsent) {
    return ClaimsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      studentId: Value(studentId),
      phone: Value(phone),
      answer: Value(answer),
      createdAt: Value(createdAt),
      status: Value(status),
    );
  }

  factory Claim.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Claim(
      id: serializer.fromJson<String>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      studentId: serializer.fromJson<String>(json['studentId']),
      phone: serializer.fromJson<String>(json['phone']),
      answer: serializer.fromJson<String>(json['answer']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemId': serializer.toJson<String>(itemId),
      'studentId': serializer.toJson<String>(studentId),
      'phone': serializer.toJson<String>(phone),
      'answer': serializer.toJson<String>(answer),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
    };
  }

  Claim copyWith({
    String? id,
    String? itemId,
    String? studentId,
    String? phone,
    String? answer,
    DateTime? createdAt,
    String? status,
  }) => Claim(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    studentId: studentId ?? this.studentId,
    phone: phone ?? this.phone,
    answer: answer ?? this.answer,
    createdAt: createdAt ?? this.createdAt,
    status: status ?? this.status,
  );
  Claim copyWithCompanion(ClaimsCompanion data) {
    return Claim(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      phone: data.phone.present ? data.phone.value : this.phone,
      answer: data.answer.present ? data.answer.value : this.answer,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Claim(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('studentId: $studentId, ')
          ..write('phone: $phone, ')
          ..write('answer: $answer, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, itemId, studentId, phone, answer, createdAt, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Claim &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.studentId == this.studentId &&
          other.phone == this.phone &&
          other.answer == this.answer &&
          other.createdAt == this.createdAt &&
          other.status == this.status);
}

class ClaimsCompanion extends UpdateCompanion<Claim> {
  final Value<String> id;
  final Value<String> itemId;
  final Value<String> studentId;
  final Value<String> phone;
  final Value<String> answer;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<int> rowid;
  const ClaimsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.phone = const Value.absent(),
    this.answer = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClaimsCompanion.insert({
    required String id,
    required String itemId,
    required String studentId,
    required String phone,
    required String answer,
    required DateTime createdAt,
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemId = Value(itemId),
       studentId = Value(studentId),
       phone = Value(phone),
       answer = Value(answer),
       createdAt = Value(createdAt);
  static Insertable<Claim> custom({
    Expression<String>? id,
    Expression<String>? itemId,
    Expression<String>? studentId,
    Expression<String>? phone,
    Expression<String>? answer,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (studentId != null) 'student_id': studentId,
      if (phone != null) 'phone': phone,
      if (answer != null) 'answer': answer,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClaimsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemId,
    Value<String>? studentId,
    Value<String>? phone,
    Value<String>? answer,
    Value<DateTime>? createdAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return ClaimsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      studentId: studentId ?? this.studentId,
      phone: phone ?? this.phone,
      answer: answer ?? this.answer,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (answer.present) {
      map['answer'] = Variable<String>(answer.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClaimsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('studentId: $studentId, ')
          ..write('phone: $phone, ')
          ..write('answer: $answer, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CampusItemsTable campusItems = $CampusItemsTable(this);
  late final $ClaimsTable claims = $ClaimsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [campusItems, claims];
}

typedef $$CampusItemsTableCreateCompanionBuilder =
    CampusItemsCompanion Function({
      required String id,
      required String title,
      required String category,
      required String location,
      required String description,
      required String reportKind,
      required String status,
      required DateTime reportedAt,
      Value<String?> dropOffLocation,
      Value<String?> reporterContact,
      Value<String?> photoPath,
      Value<bool> pendingSync,
      Value<int> rowid,
    });
typedef $$CampusItemsTableUpdateCompanionBuilder =
    CampusItemsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> category,
      Value<String> location,
      Value<String> description,
      Value<String> reportKind,
      Value<String> status,
      Value<DateTime> reportedAt,
      Value<String?> dropOffLocation,
      Value<String?> reporterContact,
      Value<String?> photoPath,
      Value<bool> pendingSync,
      Value<int> rowid,
    });

class $$CampusItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CampusItemsTable> {
  $$CampusItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportKind => $composableBuilder(
    column: $table.reportKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dropOffLocation => $composableBuilder(
    column: $table.dropOffLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reporterContact => $composableBuilder(
    column: $table.reporterContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CampusItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CampusItemsTable> {
  $$CampusItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportKind => $composableBuilder(
    column: $table.reportKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dropOffLocation => $composableBuilder(
    column: $table.dropOffLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reporterContact => $composableBuilder(
    column: $table.reporterContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CampusItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CampusItemsTable> {
  $$CampusItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reportKind => $composableBuilder(
    column: $table.reportKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get reportedAt => $composableBuilder(
    column: $table.reportedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dropOffLocation => $composableBuilder(
    column: $table.dropOffLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reporterContact => $composableBuilder(
    column: $table.reporterContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$CampusItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CampusItemsTable,
          CampusItem,
          $$CampusItemsTableFilterComposer,
          $$CampusItemsTableOrderingComposer,
          $$CampusItemsTableAnnotationComposer,
          $$CampusItemsTableCreateCompanionBuilder,
          $$CampusItemsTableUpdateCompanionBuilder,
          (
            CampusItem,
            BaseReferences<_$AppDatabase, $CampusItemsTable, CampusItem>,
          ),
          CampusItem,
          PrefetchHooks Function()
        > {
  $$CampusItemsTableTableManager(_$AppDatabase db, $CampusItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CampusItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CampusItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CampusItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> reportKind = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> reportedAt = const Value.absent(),
                Value<String?> dropOffLocation = const Value.absent(),
                Value<String?> reporterContact = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CampusItemsCompanion(
                id: id,
                title: title,
                category: category,
                location: location,
                description: description,
                reportKind: reportKind,
                status: status,
                reportedAt: reportedAt,
                dropOffLocation: dropOffLocation,
                reporterContact: reporterContact,
                photoPath: photoPath,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String category,
                required String location,
                required String description,
                required String reportKind,
                required String status,
                required DateTime reportedAt,
                Value<String?> dropOffLocation = const Value.absent(),
                Value<String?> reporterContact = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CampusItemsCompanion.insert(
                id: id,
                title: title,
                category: category,
                location: location,
                description: description,
                reportKind: reportKind,
                status: status,
                reportedAt: reportedAt,
                dropOffLocation: dropOffLocation,
                reporterContact: reporterContact,
                photoPath: photoPath,
                pendingSync: pendingSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CampusItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CampusItemsTable,
      CampusItem,
      $$CampusItemsTableFilterComposer,
      $$CampusItemsTableOrderingComposer,
      $$CampusItemsTableAnnotationComposer,
      $$CampusItemsTableCreateCompanionBuilder,
      $$CampusItemsTableUpdateCompanionBuilder,
      (
        CampusItem,
        BaseReferences<_$AppDatabase, $CampusItemsTable, CampusItem>,
      ),
      CampusItem,
      PrefetchHooks Function()
    >;
typedef $$ClaimsTableCreateCompanionBuilder =
    ClaimsCompanion Function({
      required String id,
      required String itemId,
      required String studentId,
      required String phone,
      required String answer,
      required DateTime createdAt,
      Value<String> status,
      Value<int> rowid,
    });
typedef $$ClaimsTableUpdateCompanionBuilder =
    ClaimsCompanion Function({
      Value<String> id,
      Value<String> itemId,
      Value<String> studentId,
      Value<String> phone,
      Value<String> answer,
      Value<DateTime> createdAt,
      Value<String> status,
      Value<int> rowid,
    });

class $$ClaimsTableFilterComposer
    extends Composer<_$AppDatabase, $ClaimsTable> {
  $$ClaimsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClaimsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClaimsTable> {
  $$ClaimsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get studentId => $composableBuilder(
    column: $table.studentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answer => $composableBuilder(
    column: $table.answer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClaimsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClaimsTable> {
  $$ClaimsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get answer =>
      $composableBuilder(column: $table.answer, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$ClaimsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClaimsTable,
          Claim,
          $$ClaimsTableFilterComposer,
          $$ClaimsTableOrderingComposer,
          $$ClaimsTableAnnotationComposer,
          $$ClaimsTableCreateCompanionBuilder,
          $$ClaimsTableUpdateCompanionBuilder,
          (Claim, BaseReferences<_$AppDatabase, $ClaimsTable, Claim>),
          Claim,
          PrefetchHooks Function()
        > {
  $$ClaimsTableTableManager(_$AppDatabase db, $ClaimsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClaimsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClaimsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClaimsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> studentId = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> answer = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClaimsCompanion(
                id: id,
                itemId: itemId,
                studentId: studentId,
                phone: phone,
                answer: answer,
                createdAt: createdAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemId,
                required String studentId,
                required String phone,
                required String answer,
                required DateTime createdAt,
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClaimsCompanion.insert(
                id: id,
                itemId: itemId,
                studentId: studentId,
                phone: phone,
                answer: answer,
                createdAt: createdAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClaimsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClaimsTable,
      Claim,
      $$ClaimsTableFilterComposer,
      $$ClaimsTableOrderingComposer,
      $$ClaimsTableAnnotationComposer,
      $$ClaimsTableCreateCompanionBuilder,
      $$ClaimsTableUpdateCompanionBuilder,
      (Claim, BaseReferences<_$AppDatabase, $ClaimsTable, Claim>),
      Claim,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CampusItemsTableTableManager get campusItems =>
      $$CampusItemsTableTableManager(_db, _db.campusItems);
  $$ClaimsTableTableManager get claims =>
      $$ClaimsTableTableManager(_db, _db.claims);
}
