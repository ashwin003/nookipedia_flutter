import '../types/furniture/index.dart';

/// Retrieves [Furniture] information available in *Animal Crossing: New Horizons*.
abstract class FurnitureService {
  /// Get a list of all [Furniture] and their details in *Animal Crossing: New Horizons*.
  Future<List<Furniture>> fetchDetails({
    FurnitureCategory? category,
    List<String>? colors,
  });

  /// Get a list of all [Furniture] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    FurnitureCategory? category,
    List<String>? colors,
  });

  /// Retrieve information about a specific [Furniture] in *Animal Crossing: New Horizons*.
  Future<Furniture> get({
    required String name,
    int? thumbSize,
  });
}
