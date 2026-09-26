import 'package:campus_lost/core/models/campus_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('item status exposes accessible labels', () {
    expect(ItemStatus.lost.label, 'Lost');
    expect(ItemStatus.inVault.label, 'In security vault');
    expect(ItemStatus.underVerification.label, 'Under verification');
    expect(ItemStatus.returned.label, 'Returned');
  });

  test('campus item preserves offline sync state', () {
    final item = CampusItem(
      id: 'CL-1',
      title: 'Phone',
      category: 'Electronics',
      location: 'Library',
      description: 'Black phone',
      reportKind: ReportKind.lost,
      status: ItemStatus.lost,
      reportedAt: DateTime(2026),
      pendingSync: true,
    );
    expect(item.pendingSync, isTrue);
    expect(item.reportKind, ReportKind.lost);
  });
}
