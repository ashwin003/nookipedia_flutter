import '../types/items/index.dart';

/// Get a list of all miscellaneous [Item]s (such as materials, star fragments, fruits, fences, and plants) and their details in *Animal Crossing: New Horizons*.
abstract class ItemService {
  /// Get a list of all miscellaneous [Item]s (such as materials, star fragments, fruits, fences, and plants) and their details in *Animal Crossing: New Horizons*.
  Future<List<Item>> fetchDetails();

  /// Get a list of all miscellaneous [Item] namess (such as materials, star fragments, fruits, fences, and plants) in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames();

  /// Retrieve information about a miscellaneous [Item] (such as materials, star fragments, fruits, fences, and plants) in *Animal Crossing: New Horizons*.
  Future<Item> get({
    required String name,
    int? thumbSize,
  });
}
