import '../types/critter/sea.dart';

abstract class SeaCreatureService {
  /// Get a list of all [SeaCreature] and their details in *Animal Crossing: New Horizons*.
  Future<List<SeaCreature>> fetchDetails({
    String? month,
    int? thumbSize,
  });

  /// Get a list of all [SeaCreature] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    String? month,
    int? thumbSize,
  });

  /// Retrieve information about a specific [SeaCreature] in *Animal Crossing: New Horizons*.
  Future<SeaCreature> get({
    required String name,
    int? thumbSize,
  });
}
