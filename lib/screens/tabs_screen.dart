import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/categories_screen.dart';
import '../screens/filters_screen.dart';
import '../screens/meals_screen.dart';
import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCategories = _selectedPageIndex == 0;

    return Scaffold(
      appBar: AppBar(title: Text(isCategories ? 'Categories' : 'Favorites')),
      drawer: MainDrawer(onSelectScreen: _selectScreen),
      body: IndexedStack(
        index: _selectedPageIndex,
        children: const [_CategoriesTab(), _FavoritesTab()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedPageIndex,
        onDestinationSelected: (i) => setState(() => _selectedPageIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class _CategoriesTab extends ConsumerWidget {
  const _CategoriesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CategoriesScreen(availableMeals: ref.watch(filteredMealsProvider));
  }
}

class _FavoritesTab extends ConsumerWidget {
  const _FavoritesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MealsScreen(
      meals: ref.watch(favoritesProvider),
      emptyIcon: Icons.favorite_border,
      emptyTitle: 'No favorites yet',
      emptyMessage: 'Open a meal and tap the heart to save it here.',
    );
  }
}
