import '../types/critter/critter.dart';
import '../types/critter/fish.dart';

/// Retrieves [Fish] information available in *Animal Crossing: New Horizons*.
abstract class FishService {
  /// Get a list of all [Fish] and their details in *Animal Crossing: New Horizons*.
  Future<List<Fish>> fetchDetails({
    int? thumbSize,
  });

  /// Get a list of all [Fish]s and their details based on their availability in [month] for the different [Hemisphere]s in *Animal Crossing: New Horizons*.
  Future<FishByMonth> fetchDetailsForMonth({
    required String month,
    int? thumbSize,
  });

  /// Get a list of all [Fish] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    int? thumbSize,
  });

  /// Get a list of all [Fish] names based on their availability in [month] for the different [Hemisphere]s in *Animal Crossing: New Horizons*.
  Future<CritterByMonth> fetchNamesForMonth({
    required String month,
    int? thumbSize,
  });

  /// Retrieve information about a specific [Fish] in *Animal Crossing: New Horizons*.
  Future<Fish> get({
    required String name,
    int? thumbSize,
  });
}
