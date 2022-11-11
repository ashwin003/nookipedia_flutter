import '../types/events/event.dart';

/// Get a list of events and dates in *Animal Crossing: New Horizons*, filterable to specific years, months, or days.
/// Data is available for the current and next year.
abstract class EventsService {
  /// Get a list of [AnimalCrossingEvent] and dates in *Animal Crossing: New Horizons*, filterable to specific years, months, or days.
  /// Data is available for the current and next year.
  Future<List<AnimalCrossingEvent>> fetchDetails({
    String? date,
    String? year,
    String? month,
    int? day,
  });
}
