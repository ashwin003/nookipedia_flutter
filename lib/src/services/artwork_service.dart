import '../types/museum/artwork.dart';

abstract class ArtworkService {
  /// Get a list of all [Artwork] and their details in *Animal Crossing: New Horizons*.
  Future<List<Artwork>> fetchDetails({
    bool? hasFake,
    int? thumbSize,
  });

  /// Get a list of all [Artwork] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames({
    bool? hasFake,
    int? thumbSize,
  });

  /// Retrieve information about a specific artwork in *Animal Crossing: New Horizons*.
  Future<Artwork> get({
    required String name,
    int? thumbSize,
  });
}
