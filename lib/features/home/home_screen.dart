import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/models/campus_item.dart';
import '../../providers/app_providers.dart';
import '../../widgets/status_badge.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(filteredItemsProvider);
    final allItems =
        ref.watch(itemsProvider).valueOrNull ?? const <CampusItem>[];
    final online =
        ref
            .watch(connectivityProvider)
            .valueOrNull
            ?.any((result) => result.name != 'none') ??
        true;
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () async {
          await ref.read(repositoryProvider).markSynced();
          ref.invalidate(itemsProvider);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              sliver: SliverList.list(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2563EB), Color(0xFF10B981)],
                          ),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: const Icon(
                          Icons.location_searching_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CampusLost',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            Text(
                              'Smart campus recovery network',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Tooltip(
                        message: online
                            ? 'Online'
                            : 'Offline — changes are saved locally',
                        child: Chip(
                          avatar: Icon(
                            online
                                ? Icons.cloud_done_outlined
                                : Icons.cloud_off_outlined,
                            size: 17,
                          ),
                          label: Text(online ? 'Online' : 'Offline'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Good morning 👋',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'Let’s reunite people\nwith their belongings.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _Stats(items: allItems),
                  const SizedBox(height: 20),
                  SearchBar(
                    hintText: 'Search items, tags, or descriptions',
                    leading: const Icon(Icons.search_rounded),
                    trailing: const [Icon(Icons.tune_rounded)],
                    onChanged: (value) {
                      _debounce?.cancel();
                      _debounce = Timer(const Duration(milliseconds: 250), () {
                        ref.read(searchQueryProvider.notifier).state = value;
                      });
                    },
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (_, index) {
                        final category = categories[index];
                        return FilterChip(
                          label: Text(category),
                          selected: ref.watch(categoryProvider) == category,
                          onSelected: (_) =>
                              ref.read(categoryProvider.notifier).state =
                                  category,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: ref.watch(locationProvider),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.apartment_rounded),
                      labelText: 'Campus location',
                    ),
                    items: campusLocations
                        .map(
                          (location) => DropdownMenuItem(
                            value: location,
                            child: Text(location),
                          ),
                        )
                        .toList(),
                    onChanged: (value) =>
                        ref.read(locationProvider.notifier).state = value!,
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent reports',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text('${items.valueOrNull?.length ?? 0} items'),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            items.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, _) => SliverFillRemaining(
                child: Center(child: Text('Could not load items: $error')),
              ),
              data: (data) => data.isEmpty
                  ? const SliverFillRemaining(child: _EmptyState())
                  : SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                      sliver: SliverList.separated(
                        itemCount: data.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (_, index) => _ItemCard(item: data[index]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  const _Stats({required this.items});
  final List<CampusItem> items;

  @override
  Widget build(BuildContext context) {
    final stats = [
      (
        'Lost',
        items.where((i) => i.status == ItemStatus.lost).length,
        Icons.search_rounded,
        const Color(0xFFF59E0B),
      ),
      (
        'In vault',
        items.where((i) => i.status == ItemStatus.inVault).length,
        Icons.inventory_2_rounded,
        const Color(0xFF2563EB),
      ),
      (
        'Returned',
        items.where((i) => i.status == ItemStatus.returned).length,
        Icons.task_alt_rounded,
        const Color(0xFF10B981),
      ),
    ];
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        children: stats
            .map(
              (stat) => Expanded(
                child: Card(
                  margin: EdgeInsets.only(right: stat == stats.last ? 0 : 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(stat.$3, color: stat.$4, size: 21),
                        const SizedBox(height: 10),
                        Text(
                          '${stat.$2}',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        Text(
                          stat.$1,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({required this.item});
  final CampusItem item;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: '${item.title}, ${item.status.label}, ${item.location}',
    child: Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/item/${item.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _categoryIcon(item.category),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                        if (item.pendingSync)
                          const Tooltip(
                            message: 'Pending sync',
                            child: Icon(Icons.sync_rounded, size: 16),
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 15),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            item.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        StatusBadge(item.status),
                        const Spacer(),
                        Text(
                          DateFormat.MMMd().format(item.reportedAt),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  IconData _categoryIcon(String category) => switch (category) {
    'Electronics' => Icons.devices_rounded,
    'IDs & Cards' => Icons.badge_outlined,
    'Keys' => Icons.key_rounded,
    'Books & Stationery' => Icons.menu_book_rounded,
    'Clothing & Bags' => Icons.backpack_rounded,
    _ => Icons.inventory_2_outlined,
  };
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 12),
          Text(
            'No matching items',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Text('Try a different keyword, category, or campus location.'),
        ],
      ),
    ),
  );
}
