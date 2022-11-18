import '../types/clothing/index.dart';

/// Retrieves [Clothing] information available in *Animal Crossing: New Horizons*.
abstract class ClothingService {
  /// Get a list of all [Clothing] items and their details in *Animal Crossing: New Horizons*.
  Future<List<Clothing>> fetchDetails({
    ClothingCategory? category,
    List<String>? colors,
    List<String>? styles,
    String? labelTheme,
  });

  /// Get a list of all [Clothing] item names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    ClothingCategory? category,
    List<String>? colors,
    List<String>? styles,
    String? labelTheme,
  });

  /// Retrieve information about a specific [Clothing] item in *Animal Crossing: New Horizons*.
  Future<Clothing> get({
    required String name,
    int? thumbSize,
  });
}
