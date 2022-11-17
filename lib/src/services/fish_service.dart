import '../types/critter/critter.dart';
import '../types/critter/fish.dart';

abstract class FishService {
  /// Get a list of all [Fish] and their details in *Animal Crossing: New Horizons*.
  Future<List<Fish>> fetchDetails({
    int? thumbSize,
  });

  Future<FishByMonth> fetchDetailsForMonth({
    required String month,
    int? thumbSize,
  });

  /// Get a list of all [Fish] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    int? thumbSize,
  });

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
