import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

QueryExecutor openConnection() => DatabaseConnection.delayed(() async {
  final database = await WasmDatabase.open(
    databaseName: 'campus_lost',
    sqlite3Uri: Uri.base.resolve('sqlite3.wasm'),
    driftWorkerUri: Uri.base.resolve('drift_worker.js'),
  );
  return database.resolvedExecutor;
}());
