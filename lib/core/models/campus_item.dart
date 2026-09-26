enum ItemStatus { lost, inVault, underVerification, returned }

enum ReportKind { lost, found }

class CampusItem {
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
    this.pendingSync = false,
  });

  final String id;
  final String title;
  final String category;
  final String location;
  final String description;
  final ReportKind reportKind;
  final ItemStatus status;
  final DateTime reportedAt;
  final String? dropOffLocation;
  final String? reporterContact;
  final String? photoPath;
  final bool pendingSync;
}

extension ItemStatusLabel on ItemStatus {
  String get label => switch (this) {
    ItemStatus.lost => 'Lost',
    ItemStatus.inVault => 'In security vault',
    ItemStatus.underVerification => 'Under verification',
    ItemStatus.returned => 'Returned',
  };
}
