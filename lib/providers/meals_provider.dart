import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  // Return your meals data here
  return dummyMeals;
});
