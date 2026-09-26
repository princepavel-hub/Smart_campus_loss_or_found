import 'package:flutter/material.dart';

import '../core/models/campus_item.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge(this.status, {super.key});
  final ItemStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      ItemStatus.lost => const Color(0xFFF59E0B),
      ItemStatus.inVault => const Color(0xFF2563EB),
      ItemStatus.underVerification => const Color(0xFF8B5CF6),
      ItemStatus.returned => const Color(0xFF10B981),
    };
    return Semantics(
      label: 'Status: ${status.label}',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          status.label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
