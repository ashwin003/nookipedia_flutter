import '../types/critter/critter.dart';
import '../types/critter/sea.dart';

abstract class SeaCreatureService {
  /// Get a list of all [SeaCreature] and their details in *Animal Crossing: New Horizons*.
  Future<List<SeaCreature>> fetchDetails({
    int? thumbSize,
  });

  Future<SeaCreatureByMonth> fetchDetailsForMonth({
    required String month,
    int? thumbSize,
  });

  /// Get a list of all [SeaCreature] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    int? thumbSize,
  });

  Future<CritterByMonth> fetchNamesForMonth({
    required String month,
    int? thumbSize,
  });

  /// Retrieve information about a specific [SeaCreature] in *Animal Crossing: New Horizons*.
  Future<SeaCreature> get({
    required String name,
    int? thumbSize,
  });
}
