import '../types/recipes/recipe.dart';

abstract class RecipeService {
  /// Get a list of all [Recipe]s and their details in *Animal Crossing: New Horizons*.
  Future<List<Recipe>> fetchDetails({
    String? material,
    int? thumbSize,
  });

  /// Get a list of all [Recipe] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    String? material,
    int? thumbSize,
  });

  /// Retrieve information about a specific [Recipe] in *Animal Crossing: New Horizons*.
  Future<Recipe> get({
    required String name,
    int? thumbSize,
  });
}
