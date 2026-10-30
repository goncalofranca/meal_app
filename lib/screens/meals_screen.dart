import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import 'meal_details_screen.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.categoryTitle,
    required this.meals,
    this.emptyTitle = 'No meals available',
    this.emptyMessage = 'Try selecting a different category or filter.',
    this.emptyIcon = Icons.no_meals,
  });

  final String? categoryTitle;
  final List<Meal> meals;
  final String emptyTitle;
  final String emptyMessage;
  final IconData emptyIcon;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => MealScreen(meal: meal)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final Widget content = meals.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(emptyIcon, size: 72, color: scheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    emptyTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    emptyMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: meals.length,
            itemBuilder: (ctx, index) => MealItem(
              key: ValueKey(meals[index].id),
              meal: meals[index],
              onSelectMeal: (meal) => _selectMeal(context, meal),
            ),
          );

    if (categoryTitle == null) return content;

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle!)),
      body: content,
    );
  }
}
