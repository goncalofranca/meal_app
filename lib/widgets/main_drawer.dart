import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              24,
              MediaQuery.of(context).padding.top + 32,
              24,
              28,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [scheme.primary, scheme.primaryContainer],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.restaurant_menu, size: 48, color: scheme.onPrimary),
                const SizedBox(height: 12),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: scheme.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Text(
                  'Find your next favorite meal',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: scheme.onPrimary.withValues(alpha: 0.8)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                ListTile(
                  shape: shape,
                  leading: const Icon(Icons.restaurant),
                  title: const Text('Meals'),
                  onTap: () => onSelectScreen('meals'),
                ),
                ListTile(
                  shape: shape,
                  leading: const Icon(Icons.tune),
                  title: const Text('Filters'),
                  onTap: () => onSelectScreen('filters'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
