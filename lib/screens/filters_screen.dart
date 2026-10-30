import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  static const _options = [
    _FilterOption(Filter.glutenFree, 'Gluten-free',
        'Only include gluten-free meals', Icons.grain),
    _FilterOption(Filter.lactoseFree, 'Lactose-free',
        'Only include lactose-free meals', Icons.water_drop_outlined),
    _FilterOption(Filter.vegetarian, 'Vegetarian',
        'Only include vegetarian meals', Icons.egg_alt_outlined),
    _FilterOption(
        Filter.vegan, 'Vegan', 'Only include vegan meals', Icons.eco_outlined),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    final scheme = Theme.of(context).colorScheme;
    final matching = ref.watch(filteredMealsProvider).length;

    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: scheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.restaurant_menu,
                      color: scheme.onPrimaryContainer),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '$matching ${matching == 1 ? 'meal matches' : 'meals match'} your filters',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: scheme.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          for (final option in _options)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: SwitchListTile(
                secondary: Icon(option.icon, color: scheme.primary),
                value: activeFilters[option.filter]!,
                onChanged: (value) => ref
                    .read(filtersProvider.notifier)
                    .setFilter(option.filter, value),
                title: Text(option.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w700)),
                subtitle: Text(option.subtitle),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterOption {
  const _FilterOption(this.filter, this.title, this.subtitle, this.icon);

  final Filter filter;
  final String title;
  final String subtitle;
  final IconData icon;
}
