import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/models/campus_item.dart';
import '../features/admin/admin_screen.dart';
import '../features/architecture/architecture_screen.dart';
import '../features/home/home_screen.dart';
import '../features/items/item_detail_screen.dart';
import '../features/radar/radar_screen.dart';
import '../features/report/report_screen.dart';
import '../features/scanner/scanner_screen.dart';
import '../features/shell/app_shell.dart';

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/radar',
            builder: (context, state) => const RadarScreen(),
          ),
          GoRoute(
            path: '/admin',
            builder: (context, state) => const AdminScreen(),
          ),
          GoRoute(
            path: '/architecture',
            builder: (context, state) => const ArchitectureScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/report/:kind',
        builder: (_, state) => ReportScreen(
          kind: state.pathParameters['kind'] == 'found'
              ? ReportKind.found
              : ReportKind.lost,
        ),
      ),
      GoRoute(
        path: '/item/:id',
        builder: (_, state) =>
            ItemDetailScreen(itemId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/scan',
        builder: (context, state) => const ScannerScreen(),
      ),
    ],
  ),
);
