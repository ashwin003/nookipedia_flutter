import '../types/museum/fossil.dart';

/// Retrieves [Fossil] information available in *Animal Crossing: New Horizons*.
abstract class FossilService {
  /// Get a list of all the individual [Fossil]s in Animal Crossing: New Horizons.
  Future<List<Fossil>> fetch({int? thumbSize});

  /// Retrieve information about a specific individual [Fossil] in Animal Crossing: New Horizons.
  /// [includeFossils] determines whether or not the individual fossils within the fossil group are included in the response.
  Future<Fossil> get({required String name, int? thumbSize});

  /// Get a list of all the fossil groups in Animal Crossing: New Horizons.
  Future<List<FossilGroup>> fetchGroups({
    bool? includeFossils,
    int? thumbSize,
  });

  /// Retrieve information about a specific fossil group in Animal Crossing: New Horizons.
  /// [includeFossils] determines whether or not the individual fossils within the fossil group are included in the response.
  Future<FossilGroup> getGroup({
    required String name,
    bool? includeFossils,
    int? thumbSize,
  });
}
