import '../types/critter/critter.dart';
import '../types/critter/insect.dart';

abstract class InsectService {
  /// Get a list of all [Insect] and their details in *Animal Crossing: New Horizons*.
  Future<List<Insect>> fetchDetails({
    int? thumbSize,
  });

  Future<InsectByMonth> fetchDetailsForMonth({
    required String month,
    int? thumbSize,
  });

  /// Get a list of all [Insect] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    int? thumbSize,
  });

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
