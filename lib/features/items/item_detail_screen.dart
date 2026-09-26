import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/models/campus_item.dart';
import '../../core/models/claim_record.dart';
import '../../providers/app_providers.dart';
import '../../widgets/status_badge.dart';

class ItemDetailScreen extends ConsumerWidget {
  const ItemDetailScreen({required this.itemId, super.key});
  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Item record')),
      body: items.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (data) {
          final matches = data.where((item) => item.id == itemId);
          if (matches.isEmpty) {
            return const Center(child: Text('Item not found'));
          }
          return _Detail(item: matches.first);
        },
      ),
    );
  }
}

class _Detail extends ConsumerWidget {
  const _Detail({required this.item});
  final CampusItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 36),
    children: [
      if (item.photoPath != null)
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: kIsWeb
              ? Image.network(item.photoPath!, height: 220, fit: BoxFit.cover)
              : Image.file(
                  File(item.photoPath!),
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
        )
      else
        Container(
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.secondaryContainer,
              ],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.inventory_2_outlined, size: 72),
        ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: Text(
              item.title,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          StatusBadge(item.status),
        ],
      ),
      const SizedBox(height: 6),
      Text(
        '${item.id} · ${item.category}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      const SizedBox(height: 20),
      _InfoRow(
        icon: Icons.location_on_outlined,
        label: 'Campus location',
        value: item.location,
      ),
      _InfoRow(
        icon: Icons.schedule_rounded,
        label: 'Reported',
        value: DateFormat.yMMMd().add_jm().format(item.reportedAt),
      ),
      if (item.dropOffLocation != null)
        _InfoRow(
          icon: Icons.security_rounded,
          label: 'Held at',
          value: item.dropOffLocation!,
        ),
      const SizedBox(height: 12),
      Text(
        'Public description',
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 7),
      Text(item.description),
      const SizedBox(height: 22),
      if (item.reportKind == ReportKind.found &&
          item.status != ItemStatus.returned)
        FilledButton.icon(
          key: const Key('claim_item'),
          onPressed: () => _showClaimDialog(context, ref),
          icon: const Icon(Icons.verified_user_outlined),
          label: const Text('This belongs to me'),
        ),
      const SizedBox(height: 10),
      OutlinedButton.icon(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Vault tag · ${item.id}'),
            content: QrImageView(
              data: 'campuslost://item/${item.id}',
              size: 220,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
        icon: const Icon(Icons.qr_code_2_rounded),
        label: const Text('View QR tag'),
      ),
      const SizedBox(height: 18),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.shield_outlined),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'For your protection, Campus Security verifies private details before releasing an item. Secret answers are never displayed here.',
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Future<void> _showClaimDialog(BuildContext context, WidgetRef ref) async {
    final formKey = GlobalKey<FormState>();
    final matricule = TextEditingController();
    final phone = TextEditingController();
    final answer = TextEditingController();
    final submitted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ownership verification'),
        content: SizedBox(
          width: 420,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Answer without seeing the stored secret. Security staff will compare both responses.',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: matricule,
                    decoration: const InputDecoration(
                      labelText: 'Student ID / matricule',
                    ),
                    validator: _required,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone number',
                    ),
                    validator: _required,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: answer,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Describe a hidden detail only you know',
                      alignLabelWithHint: true,
                    ),
                    validator: _required,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Submit securely'),
          ),
        ],
      ),
    );
    if (submitted != true) return;
    await ref
        .read(repositoryProvider)
        .submitClaim(
          ClaimRecord(
            id: 'CLAIM-${DateTime.now().millisecondsSinceEpoch}',
            itemId: item.id,
            studentId: matricule.text.trim(),
            phone: phone.text.trim(),
            answer: answer.text.trim(),
            createdAt: DateTime.now(),
            status: ClaimStatus.pending,
          ),
        );
    await ref
        .read(repositoryProvider)
        .updateStatus(item.id, ItemStatus.underVerification);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Claim submitted. Security will review it shortly.'),
        ),
      );
    }
  }

  static String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Required' : null;
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, size: 21, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.labelSmall),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    ),
  );
}
