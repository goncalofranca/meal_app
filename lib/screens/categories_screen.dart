import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/category_grid_item.dart';
import 'meals_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  void _selectCategory(
      BuildContext context, Category category, List<Meal> meals) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        categoryTitle: category.title,
        meals: meals,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final mealsByCategory = <String, List<Meal>>{
      for (final c in categories) c.id: [],
    };
    for (final meal in availableMeals) {
      for (final id in meal.categories) {
        mealsByCategory[id]?.add(meal);
      }
    }

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What are you craving?',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  '${availableMeals.length} recipes in ${categories.length} categories',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 260,
              childAspectRatio: 1.15,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final meals = mealsByCategory[category.id]!;
              return CategoryGridItem(
                category: category,
                mealCount: meals.length,
                onSelectCategory: () =>
                    _selectCategory(context, category, meals),
              );
            },
          ),
        ),
      ],
    );
  }
}
