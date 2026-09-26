import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../core/models/campus_item.dart';
import '../core/models/claim_record.dart';
import '../data/local/app_database.dart' show AppDatabase;
import '../data/repositories/item_repository.dart';

const categories = <String>[
  'All',
  'Electronics',
  'IDs & Cards',
  'Keys',
  'Books & Stationery',
  'Clothing & Bags',
];

const campusLocations = <String>[
  'All locations',
  'Amphitheaters',
  'Central Library',
  'Cafeteria',
  'Science Labs',
  'Sports Complex',
  'Student Union',
];

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final repositoryProvider = Provider<ItemRepository>(
  (ref) =>
      ItemRepository(ref.watch(databaseProvider), const FlutterSecureStorage()),
);

final bootstrapProvider = FutureProvider<void>((ref) async {
  await ref.watch(repositoryProvider).ensureSeeded();
});

final itemsProvider = StreamProvider<List<CampusItem>>((ref) {
  ref.watch(bootstrapProvider);
  return ref.watch(repositoryProvider).watchItems();
});

final claimsProvider = StreamProvider<List<ClaimRecord>>((ref) {
  ref.watch(bootstrapProvider);
  return ref.watch(repositoryProvider).watchClaims();
});

final connectivityProvider = StreamProvider<List<ConnectivityResult>>(
  (ref) => Connectivity().onConnectivityChanged,
);

final searchQueryProvider = StateProvider<String>((ref) => '');
final categoryProvider = StateProvider<String>((ref) => 'All');
final locationProvider = StateProvider<String>((ref) => 'All locations');

final filteredItemsProvider = Provider<AsyncValue<List<CampusItem>>>((ref) {
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();
  final category = ref.watch(categoryProvider);
  final location = ref.watch(locationProvider);
  return ref
      .watch(itemsProvider)
      .whenData(
        (items) => items.where((item) {
          final searchable = '${item.title} ${item.description} ${item.id}'
              .toLowerCase();
          return (query.isEmpty || searchable.contains(query)) &&
              (category == 'All' || item.category == category) &&
              (location == 'All locations' || item.location == location);
        }).toList(),
      );
});
