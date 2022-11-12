import '../types/interior/index.dart';

abstract class InteriorService {
  /// Get a list of all [Interior] items (flooring, wallpaper, and rugs) and their details in *Animal Crossing: New Horizons*.
  Future<List<Interior>> fetchDetails({
    List<String>? colors,
  });

  /// Get a list of all [Interior] item names (flooring, wallpaper, and rugs) and their details in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    List<String>? colors,
  });

  /// Retrieve information about a specific [Interior] item in *Animal Crossing: New Horizons*.
  Future<Interior> get({
    required String name,
    int? thumbSize,
  });
}