enum ClaimStatus { pending, approved, rejected }

class ClaimRecord {
  const ClaimRecord({
    required this.id,
    required this.itemId,
    required this.studentId,
    required this.phone,
    required this.answer,
    required this.createdAt,
    required this.status,
  });

  final String id;
  final String itemId;
  final String studentId;
  final String phone;
  final String answer;
  final DateTime createdAt;
  final ClaimStatus status;
}
