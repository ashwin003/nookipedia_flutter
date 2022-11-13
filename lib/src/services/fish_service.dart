import '../types/critter/fish.dart';

abstract class FishService {
  /// Get a list of all [Fish] and their details in *Animal Crossing: New Horizons*.
  Future<List<Fish>> fetchDetails({
    String? month,
    int? thumbSize,
  });

  /// Get a list of all [Fish] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    String? month,
    int? thumbSize,
  });

  /// Retrieve information about a specific [Fish] in *Animal Crossing: New Horizons*.
  Future<Fish> get({
    required String name,
    int? thumbSize,
  });
}
