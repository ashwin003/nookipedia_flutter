import '../types/tools/tool.dart';

/// Retrieves information about all [Tool]s available in *Animal Crossing: New Horizons*.
abstract class ToolService {
  /// Get a list of all [Tool]s and their details in *Animal Crossing: New Horizons*.
  Future<List<Tool>> fetchDetails();

  /// Get a list of all [Tool] names in *Animal Crossing: New Horizons*.
  Future<List<String>> fetchNames();

  /// Retrieve information about a specific [Tool] in *Animal Crossing: New Horizons*.
  Future<Tool> get({
    required String name,
    int? thumbSize,
  });
}
