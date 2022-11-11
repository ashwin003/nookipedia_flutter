import '../types/photos/photo.dart';

abstract class PhotoService {
  /// Get a list of all character photos+posters and their details in *Animal Crossing: New Horizons*.
  Future<List<Photo>> fetchDetails();

  /// Retrieve information about a character photo or poster in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames();

  Future<Photo> get({
    required String name,
    int? thumbSize,
  });
}
