import '../types/critter/critter.dart';
import '../types/critter/sea.dart';

/// Get a list of all [SeaCreature]s and their details in *Animal Crossing: New Horizons*.
abstract class SeaCreatureService {
  /// Get a list of all [SeaCreature] and their details in *Animal Crossing: New Horizons*.
  Future<List<SeaCreature>> fetchDetails({
    int? thumbSize,
  });

  /// Get a list of all [SeaCreature]s and their details based on their availability in [month] for the different [Hemisphere]s in *Animal Crossing: New Horizons*.
  Future<SeaCreatureByMonth> fetchDetailsForMonth({
    required String month,
    int? thumbSize,
  });

  /// Get a list of all [SeaCreature] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    int? thumbSize,
  });

  /// Get a list of all [SeaCreature] names based on their availability in [month] for the different [Hemisphere]s in *Animal Crossing: New Horizons*.
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
