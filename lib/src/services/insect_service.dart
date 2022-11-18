import '../types/critter/critter.dart';
import '../types/critter/insect.dart';

/// Get a list of all [Insect]s and their details in *Animal Crossing: New Horizons*.
abstract class InsectService {
  /// Get a list of all [Insect] and their details in *Animal Crossing: New Horizons*.
  Future<List<Insect>> fetchDetails({
    int? thumbSize,
  });

  /// Get a list of all [Insect]s and their details based on their availability in [month] for the different [Hemisphere]s in *Animal Crossing: New Horizons*.
  Future<InsectByMonth> fetchDetailsForMonth({
    required String month,
    int? thumbSize,
  });

  /// Get a list of all [Insect] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    int? thumbSize,
  });

  /// Get a list of all [Insect] names based on their availability in [month] for the different [Hemisphere]s in *Animal Crossing: New Horizons*.
  Future<CritterByMonth> fetchNamesForMonth({
    required String month,
    int? thumbSize,
  });

  /// Retrieve information about a specific [Insect] in *Animal Crossing: New Horizons*.
  Future<Insect> get({
    required String name,
    int? thumbSize,
  });
}
