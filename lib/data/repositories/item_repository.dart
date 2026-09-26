import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/models/campus_item.dart' as model;
import '../../core/models/claim_record.dart' as model;
import '../local/app_database.dart';

class ItemRepository {
  ItemRepository(this._db, this._secureStorage);

  final AppDatabase _db;
  final FlutterSecureStorage _secureStorage;

  Stream<List<model.CampusItem>> watchItems() =>
      (_db.select(_db.campusItems)
            ..orderBy([(row) => OrderingTerm.desc(row.reportedAt)]))
          .watch()
          .map((rows) => rows.map(_itemFromRow).toList());

  Stream<List<model.ClaimRecord>> watchClaims() =>
      (_db.select(_db.claims)
            ..orderBy([(row) => OrderingTerm.desc(row.createdAt)]))
          .watch()
          .map((rows) => rows.map(_claimFromRow).toList());

  Future<void> ensureSeeded() async {
    final count = await _db.campusItems.count().getSingle();
    if (count > 0) return;
    final now = DateTime.now();
    final seeds = [
      model.CampusItem(
        id: 'CL-1042',
        title: 'MacBook Air 13-inch',
        category: 'Electronics',
        location: 'Central Library',
        description: 'Space gray laptop in a navy sleeve.',
        reportKind: model.ReportKind.found,
        status: model.ItemStatus.inVault,
        reportedAt: now.subtract(const Duration(hours: 3)),
        dropOffLocation: 'Central Security Desk',
        reporterContact: 'STU-22148',
      ),
      model.CampusItem(
        id: 'CL-1041',
        title: 'Blue student ID card',
        category: 'IDs & Cards',
        location: 'Science Labs',
        description: 'Student card reported near the chemistry block.',
        reportKind: model.ReportKind.lost,
        status: model.ItemStatus.lost,
        reportedAt: now.subtract(const Duration(days: 1)),
      ),
      model.CampusItem(
        id: 'CL-1039',
        title: 'Three keys on red ring',
        category: 'Keys',
        location: 'Student Union',
        description: 'Two silver keys and one small brass key.',
        reportKind: model.ReportKind.found,
        status: model.ItemStatus.underVerification,
        reportedAt: now.subtract(const Duration(days: 2)),
        dropOffLocation: 'Student Union Front Desk',
      ),
      model.CampusItem(
        id: 'CL-1032',
        title: 'Black scientific calculator',
        category: 'Books & Stationery',
        location: 'Amphitheaters',
        description: 'Recovered after a lecture and returned to owner.',
        reportKind: model.ReportKind.found,
        status: model.ItemStatus.returned,
        reportedAt: now.subtract(const Duration(days: 5)),
      ),
    ];
    for (final item in seeds) {
      await saveItem(
        item,
        verificationAnswer: item.id == 'CL-1042'
            ? 'Small star sticker underneath'
            : null,
      );
    }
    await submitClaim(
      model.ClaimRecord(
        id: 'CLAIM-901',
        itemId: 'CL-1039',
        studentId: 'UB24CS018',
        phone: '+237 6•• •• 91 04',
        answer: 'Red carabiner with a tiny football charm',
        createdAt: now.subtract(const Duration(minutes: 42)),
        status: model.ClaimStatus.pending,
      ),
    );
  }

  Future<void> saveItem(
    model.CampusItem item, {
    String? verificationAnswer,
  }) async {
    await _db
        .into(_db.campusItems)
        .insertOnConflictUpdate(
          CampusItemsCompanion.insert(
            id: item.id,
            title: item.title,
            category: item.category,
            location: item.location,
            description: item.description,
            reportKind: item.reportKind.name,
            status: item.status.name,
            reportedAt: item.reportedAt,
            dropOffLocation: Value(item.dropOffLocation),
            reporterContact: Value(item.reporterContact),
            photoPath: Value(item.photoPath),
            pendingSync: Value(item.pendingSync),
          ),
        );
    if (verificationAnswer?.trim().isNotEmpty == true) {
      await _secureStorage.write(
        key: 'verification_${item.id}',
        value: verificationAnswer,
      );
    }
  }

  Future<void> submitClaim(model.ClaimRecord claim) => _db
      .into(_db.claims)
      .insertOnConflictUpdate(
        ClaimsCompanion.insert(
          id: claim.id,
          itemId: claim.itemId,
          studentId: claim.studentId,
          phone: claim.phone,
          answer: claim.answer,
          createdAt: claim.createdAt,
          status: Value(claim.status.name),
        ),
      );

  Future<void> resolveClaim(model.ClaimRecord claim, bool approved) async {
    await (_db.update(
      _db.claims,
    )..where((row) => row.id.equals(claim.id))).write(
      ClaimsCompanion(status: Value(approved ? 'approved' : 'rejected')),
    );
    if (approved) await updateStatus(claim.itemId, model.ItemStatus.returned);
  }

  Future<void> updateStatus(String itemId, model.ItemStatus status) =>
      (_db.update(
        _db.campusItems,
      )..where((row) => row.id.equals(itemId))).write(
        CampusItemsCompanion(
          status: Value(status.name),
          pendingSync: const Value(true),
        ),
      );

  Future<int> markSynced() => _db
      .update(_db.campusItems)
      .write(const CampusItemsCompanion(pendingSync: Value(false)));

  model.CampusItem _itemFromRow(CampusItem row) => model.CampusItem(
    id: row.id,
    title: row.title,
    category: row.category,
    location: row.location,
    description: row.description,
    reportKind: model.ReportKind.values.byName(row.reportKind),
    status: model.ItemStatus.values.byName(row.status),
    reportedAt: row.reportedAt,
    dropOffLocation: row.dropOffLocation,
    reporterContact: row.reporterContact,
    photoPath: row.photoPath,
    pendingSync: row.pendingSync,
  );

  model.ClaimRecord _claimFromRow(Claim row) => model.ClaimRecord(
    id: row.id,
    itemId: row.itemId,
    studentId: row.studentId,
    phone: row.phone,
    answer: row.answer,
    createdAt: row.createdAt,
    status: model.ClaimStatus.values.byName(row.status),
  );
}
