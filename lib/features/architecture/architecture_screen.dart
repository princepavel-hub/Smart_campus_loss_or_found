import 'package:flutter/material.dart';

class ArchitectureScreen extends StatelessWidget {
  const ArchitectureScreen({super.key});

  static const _fastApi = '''@router.post("/items", status_code=201)
async def report_item(payload: ItemCreate, user=Depends(current_user)):
    return await items.create(payload, reporter_id=user.id)

@router.post("/items/{item_id}/claims", status_code=202)
async def claim_item(item_id: UUID, payload: ClaimCreate,
                     user=Depends(current_user)):
    return await claims.submit(item_id, payload, claimant=user)

@router.patch("/claims/{claim_id}/decision")
async def decide_claim(claim_id: UUID, decision: ClaimDecision,
                       staff=Depends(require_security_staff)):
    return await claims.decide(claim_id, decision, staff)''';

  static const _schema = '''users
  id UUID PK · matricule UNIQUE · phone · role
          │ 1
          │ reports
          ▼ *
items
  id UUID PK · title · category · status · location
          │ 1
          │ receives
          ▼ *
claims
  id UUID PK · item_id FK · claimant_id FK
  answer_ciphertext · decision · created_at''';

  static const _sequence = '''STUDENT        API        DATABASE      SECURITY
   │ report ───▶│             │              │
   │            │── insert ──▶│              │
   │◀── item ───│             │              │
   │ claim ────▶│── store ───▶│── alert ────▶│
   │            │             │◀── decision ──│
   │◀── notify ─│◀── update ──│              │
   │       verified hand-off / return         │''';

  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: false,
    child: ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
      children: [
        Text(
          'Backend Architecture',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 6),
        const Text(
          'A production reference for demos, technical reviews, and backend implementation.',
        ),
        const SizedBox(height: 20),
        const _LayerCard(
          icon: Icons.phone_android_rounded,
          title: 'Flutter client',
          body:
              'Riverpod + Repository · Drift/SQLite local source · Dio sync queue · encrypted verification answers',
        ),
        const _Arrow(),
        const _LayerCard(
          icon: Icons.api_rounded,
          title: 'FastAPI service',
          body:
              'JWT authentication · role-based authorization · paginated REST endpoints · idempotent sync',
        ),
        const _Arrow(),
        const _LayerCard(
          icon: Icons.storage_rounded,
          title: 'PostgreSQL',
          body:
              'Relational integrity · encrypted secrets · append-only custody audit log · indexed search',
        ),
        const SizedBox(height: 24),
        _Expandable(
          title: 'FastAPI route definitions',
          icon: Icons.code_rounded,
          content: _fastApi,
        ),
        _Expandable(
          title: 'Relational schema / ER diagram',
          icon: Icons.hub_outlined,
          content: _schema,
        ),
        _Expandable(
          title: 'Claim sequence diagram',
          icon: Icons.swap_horiz_rounded,
          content: _sequence,
        ),
        const SizedBox(height: 16),
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.sync_rounded),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Offline reconciliation uses client-generated UUIDs and idempotency keys. Server timestamps win for status transitions; unsynced drafts remain editable locally.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _LayerCard extends StatelessWidget {
  const _LayerCard({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(radius: 25, child: Icon(icon)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(body),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Arrow extends StatelessWidget {
  const _Arrow();
  @override
  Widget build(BuildContext context) => const Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Icon(Icons.south_rounded),
    ),
  );
}

class _Expandable extends StatelessWidget {
  const _Expandable({
    required this.title,
    required this.icon,
    required this.content,
  });
  final String title;
  final IconData icon;
  final String content;
  @override
  Widget build(BuildContext context) => Card(
    child: ExpansionTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SelectableText(
            content,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Color(0xFFE2E8F0),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}
