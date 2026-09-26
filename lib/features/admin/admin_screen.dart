import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';

import '../../core/models/campus_item.dart';
import '../../core/models/claim_record.dart';
import '../../providers/app_providers.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});
  @override
  ConsumerState<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  bool _unlocked = false;
  bool _authenticating = false;

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: _unlocked
        ? _ReviewDesk(onLock: () => setState(() => _unlocked = false))
        : _LockedDesk(authenticating: _authenticating, onUnlock: _authenticate),
  );

  Future<void> _authenticate() async {
    setState(() => _authenticating = true);
    var authenticated = false;
    try {
      final auth = LocalAuthentication();
      if (await auth.isDeviceSupported()) {
        authenticated = await auth.authenticate(
          localizedReason: 'Unlock the Campus Security review desk',
          options: const AuthenticationOptions(
            biometricOnly: false,
            stickyAuth: true,
          ),
        );
      }
    } catch (_) {
      authenticated = false;
    }
    if (!authenticated && mounted) {
      authenticated = await _requestPin();
    }
    if (mounted) {
      setState(() {
        _authenticating = false;
        _unlocked = authenticated;
      });
    }
  }

  Future<bool> _requestPin() async {
    final pin = TextEditingController();
    String? error;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Staff PIN'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Biometrics are unavailable. Use the academic demo PIN 2468.',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: pin,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'PIN', errorText: error),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (pin.text == '2468') {
                  Navigator.pop(context, true);
                } else {
                  setDialogState(() => error = 'Incorrect PIN');
                }
              },
              child: const Text('Unlock'),
            ),
          ],
        ),
      ),
    );
    pin.dispose();
    return result ?? false;
  }
}

class _LockedDesk extends StatelessWidget {
  const _LockedDesk({required this.authenticating, required this.onUnlock});
  final bool authenticating;
  final VoidCallback onUnlock;
  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.admin_panel_settings_rounded, size: 58),
          ),
          const SizedBox(height: 24),
          Text(
            'Admin Review Desk',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 8),
          const Text(
            'Restricted to Campus Security personnel. Authentication protects claimant details and custody actions.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            key: const Key('unlock_admin'),
            onPressed: authenticating ? null : onUnlock,
            icon: const Icon(Icons.fingerprint_rounded),
            label: Text(authenticating ? 'Authenticating…' : 'Unlock securely'),
          ),
        ],
      ),
    ),
  );
}

class _ReviewDesk extends ConsumerWidget {
  const _ReviewDesk({required this.onLock});
  final VoidCallback onLock;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final claims = ref.watch(claimsProvider);
    final items = ref.watch(itemsProvider).valueOrNull ?? const <CampusItem>[];
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('Security Review Desk'),
          actions: [
            IconButton(
              tooltip: 'Scan vault tag',
              icon: const Icon(Icons.qr_code_scanner_rounded),
              onPressed: () => context.push('/scan'),
            ),
            IconButton(
              tooltip: 'Lock desk',
              icon: const Icon(Icons.lock_outline_rounded),
              onPressed: onLock,
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          sliver: claims.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => SliverToBoxAdapter(child: Text('$error')),
            data: (data) {
              final pending = data
                  .where((claim) => claim.status == ClaimStatus.pending)
                  .toList();
              return SliverList.list(
                children: [
                  Row(
                    children: [
                      _MiniStat(
                        label: 'Pending',
                        value: pending.length,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 10),
                      _MiniStat(
                        label: 'In vault',
                        value: items
                            .where((item) => item.status == ItemStatus.inVault)
                            .length,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'Ownership claims',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (pending.isEmpty)
                    const Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(child: Text('All claims are reviewed.')),
                      ),
                    )
                  else
                    ...pending.map((claim) {
                      final item = items
                          .where((item) => item.id == claim.itemId)
                          .firstOrNull;
                      return _ClaimCard(claim: claim, item: item);
                    }),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final int value;
  final Color color;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: .15),
              child: Text(
                '$value',
                style: TextStyle(color: color, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    ),
  );
}

class _ClaimCard extends ConsumerWidget {
  const _ClaimCard({required this.claim, required this.item});
  final ClaimRecord claim;
  final CampusItem? item;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item?.title ?? claim.itemId,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Chip(label: const Text('PENDING')),
            ],
          ),
          Text('${claim.studentId} · ${claim.phone}'),
          Text(
            DateFormat.yMMMd().add_jm().format(claim.createdAt),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Divider(height: 26),
          Text(
            'Claimant answer',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 5),
          Text(claim.answer),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _resolve(context, ref, false),
                  icon: const Icon(Icons.close_rounded),
                  label: const Text('Reject'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _resolve(context, ref, true),
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Approve'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  Future<void> _resolve(
    BuildContext context,
    WidgetRef ref,
    bool approve,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          approve ? 'Approve and return item?' : 'Reject this claim?',
        ),
        content: Text(
          approve
              ? 'This action marks the item officially returned and records the hand-off.'
              : 'The claimant will need to submit a new inquiry with better evidence.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(approve ? 'Confirm approval' : 'Confirm rejection'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(repositoryProvider).resolveClaim(claim, approve);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              approve
                  ? 'Claim approved and hand-off logged.'
                  : 'Claim rejected.',
            ),
          ),
        );
      }
    }
  }
}
