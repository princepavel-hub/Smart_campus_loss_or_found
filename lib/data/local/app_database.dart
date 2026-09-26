import 'package:drift/drift.dart';

import 'database_connection_native.dart'
    if (dart.library.js_interop) 'database_connection_web.dart';

part 'app_database.g.dart';

class CampusItems extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  TextColumn get location => text()();
  TextColumn get description => text()();
  TextColumn get reportKind => text()();
  TextColumn get status => text()();
  DateTimeColumn get reportedAt => dateTime()();
  TextColumn get dropOffLocation => text().nullable()();
  TextColumn get reporterContact => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Claims extends Table {
  TextColumn get id => text()();
  TextColumn get itemId => text()();
  TextColumn get studentId => text()();
  TextColumn get phone => text()();
  TextColumn get answer => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get status => text().withDefault(const Constant('pending'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [CampusItems, Claims])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}
