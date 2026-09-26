import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/models/campus_item.dart';
import '../../providers/app_providers.dart';

class RadarScreen extends ConsumerStatefulWidget {
  const RadarScreen({super.key});

  @override
  ConsumerState<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends ConsumerState<RadarScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _query = TextEditingController();
  List<CampusItem>? _matches;
  bool _scanning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemsProvider).valueOrNull ?? const <CampusItem>[];
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Find My Phone',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    const Text('Cross-reference the campus recovery network'),
                  ],
                ),
              ),
              const Icon(Icons.radar_rounded, size: 34),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: .13),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.science_outlined, color: Color(0xFFF59E0B)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Simulated demonstration: this does not remotely track a lost phone. It searches found-item records and visualizes potential campus matches.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Center(
            child: SizedBox(
              width: 290,
              height: 290,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => CustomPaint(
                  painter: _RadarPainter(
                    progress: _controller.value,
                    hasMatch: _matches?.isNotEmpty == true,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _scanning
                              ? Icons.sensors_rounded
                              : Icons.phone_iphone_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          _scanning ? 'SCANNING' : 'READY',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            key: const Key('radar_query'),
            controller: _query,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _scan(items),
            decoration: const InputDecoration(
              labelText: 'IMEI, phone model, or matricule',
              prefixIcon: Icon(Icons.numbers_rounded),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _scanning ? null : () => _scan(items),
            icon: const Icon(Icons.radar_rounded),
            label: Text(
              _scanning ? 'Scanning campus zones…' : 'Search recovery network',
            ),
          ),
          if (_matches != null) ...[
            const SizedBox(height: 24),
            Text(
              _matches!.isEmpty
                  ? 'No records matched yet'
                  : 'Potential matches',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            if (_matches!.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Try the model name or identifying words from the report. Your query stays on this device.',
                  ),
                ),
              )
            else
              ..._matches!.map(
                (item) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.phone_iphone_rounded),
                    ),
                    title: Text(item.title),
                    subtitle: Text('${item.location} · ${item.status.label}'),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                    onTap: () => context.push('/item/${item.id}'),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Future<void> _scan(List<CampusItem> items) async {
    final query = _query.text.trim().toLowerCase();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a phone model, IMEI, or matricule.'),
        ),
      );
      return;
    }
    setState(() {
      _scanning = true;
      _matches = null;
    });
    await HapticFeedback.mediumImpact();
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    final matches = items.where((item) {
      if (item.category != 'Electronics') return false;
      final text =
          '${item.title} ${item.description} ${item.reporterContact ?? ''}'
              .toLowerCase();
      return text.contains(query) || query.contains(item.title.toLowerCase());
    }).toList();
    await SystemSound.play(SystemSoundType.click);
    await HapticFeedback.heavyImpact();
    if (mounted) {
      setState(() {
        _scanning = false;
        _matches = matches;
      });
    }
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({required this.progress, required this.hasMatch});
  final double progress;
  final bool hasMatch;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final base = Paint()..color = const Color(0xFF052E2B);
    canvas.drawCircle(center, radius, base);
    final grid = Paint()
      ..color = const Color(0xFF10B981).withValues(alpha: .35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(center, radius * i / 4, grid);
    }
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), grid);
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), grid);
    final angle = progress * math.pi * 2;
    final sweep = Paint()
      ..shader = SweepGradient(
        startAngle: angle - .8,
        endAngle: angle,
        colors: [
          Colors.transparent,
          const Color(0xFF10B981).withValues(alpha: .55),
        ],
        transform: GradientRotation(angle - .8),
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, sweep);
    final line = Paint()
      ..color = const Color(0xFF34D399)
      ..strokeWidth = 2;
    canvas.drawLine(
      center,
      center + Offset(math.cos(angle), math.sin(angle)) * radius,
      line,
    );
    if (hasMatch) {
      final dot =
          center + Offset(math.cos(1.15), math.sin(1.15)) * radius * .65;
      canvas.drawCircle(dot, 8, Paint()..color = const Color(0xFFFBBF24));
      canvas.drawCircle(
        dot,
        14,
        Paint()..color = const Color(0xFFFBBF24).withValues(alpha: .3),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RadarPainter old) =>
      old.progress != progress || old.hasMatch != hasMatch;
}
