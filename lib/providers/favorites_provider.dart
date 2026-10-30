import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/meal.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref) {
  return FavoritesNotifier();
});

/// Rebuilds only when the favorite status of [mealId] changes.
final isFavoriteProvider = Provider.family<bool, String>((ref, mealId) {
  return ref.watch(
    favoritesProvider.select((meals) => meals.any((m) => m.id == mealId)),
  );
});

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    if (state.any((m) => m.id == meal.id)) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}
