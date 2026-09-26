import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});
  final Widget child;

  int _index(String location) {
    if (location.startsWith('/radar')) return 1;
    if (location.startsWith('/admin')) return 2;
    if (location.startsWith('/architecture')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _index(location);
    return Scaffold(
      body: child,
      floatingActionButton: index == 0
          ? FloatingActionButton.extended(
              key: const Key('report_fab'),
              onPressed: () => _showReportOptions(context),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Report item'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) =>
            context.go(const ['/', '/radar', '/admin', '/architecture'][value]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.radar_outlined),
            selectedIcon: Icon(Icons.radar_rounded),
            label: 'Radar',
          ),
          NavigationDestination(
            icon: Icon(Icons.security_outlined),
            selectedIcon: Icon(Icons.security_rounded),
            label: 'Review',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_outlined),
            selectedIcon: Icon(Icons.account_tree_rounded),
            label: 'Backend',
          ),
        ],
      ),
    );
  }

  Future<void> _showReportOptions(BuildContext context) =>
      showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (sheetContext) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'What would you like to report?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _ReportChoice(
                  icon: Icons.search_rounded,
                  color: Colors.orange,
                  title: 'I lost something',
                  subtitle: 'Create a private, searchable lost-item report',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    context.push('/report/lost');
                  },
                ),
                const SizedBox(height: 10),
                _ReportChoice(
                  icon: Icons.inventory_2_outlined,
                  color: Colors.blue,
                  title: 'I found something',
                  subtitle: 'Register it and generate a secure QR tag',
                  onTap: () {
                    Navigator.pop(sheetContext);
                    context.push('/report/found');
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

class _ReportChoice extends StatelessWidget {
  const _ReportChoice({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.all(14),
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: .15),
        foregroundColor: color,
        child: Icon(icon),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_rounded),
    ),
  );
}
