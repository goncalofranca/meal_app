import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';
import '../providers/favorites_provider.dart';
import '../widgets/meal_image.dart';
import '../widgets/meal_item_trait.dart';

class MealScreen extends ConsumerWidget {
  const MealScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider(meal.id));
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final tags = [
      if (meal.isGlutenFree) 'Gluten-free',
      if (meal.isLactoseFree) 'Lactose-free',
      if (meal.isVegetarian) 'Vegetarian',
      if (meal.isVegan) 'Vegan',
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: scheme.surface,
            actions: [
              IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(isFavorite),
                    color: isFavorite ? scheme.primary : null,
                  ),
                ),
                onPressed: () {
                  final added = ref
                      .read(favoritesProvider.notifier)
                      .toggleFavorite(meal);
                  final messenger = ScaffoldMessenger.of(context);
                  messenger.clearSnackBars();
                  messenger.showSnackBar(SnackBar(
                    content: Text(
                        added ? 'Added to favorites' : 'Removed from favorites'),
                  ));
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: meal.id,
                    child: MealImage(
                        url: meal.imageUrl, height: 300, cacheWidth: 1200),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black45, Colors.transparent],
                        stops: [0, 0.4],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  meal.title,
                  style: textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 18,
                  runSpacing: 6,
                  children: [
                    MealItemTrait(
                        icon: Icons.schedule, label: '${meal.duration} min'),
                    MealItemTrait(icon: Icons.bolt, label: meal.complexityText),
                    MealItemTrait(
                        icon: Icons.payments_outlined,
                        label: meal.affordabilityText),
                  ],
                ),
                if (tags.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in tags)
                        Chip(
                          label: Text(tag),
                          visualDensity: VisualDensity.compact,
                          side: BorderSide.none,
                          backgroundColor: scheme.secondaryContainer,
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                const _SectionTitle('Ingredients'),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        for (final ingredient in meal.ingredients)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle_outline,
                                    size: 18, color: scheme.primary),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(ingredient,
                                      style: textTheme.bodyLarge),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const _SectionTitle('Steps'),
                const SizedBox(height: 8),
                for (var i = 0; i < meal.steps.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: scheme.primaryContainer,
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: scheme.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(meal.steps[i], style: textTheme.bodyLarge),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(fontWeight: FontWeight.w800),
    );
  }
}
