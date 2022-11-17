import '../types/villagers/personality.dart';
import '../types/villagers/villager.dart';

/// This service retrieves villager information from the entire *Animal Crossing* series, with the option to filter by species, personality, and/or birthday.
/// Filters use the AND operator (e.g. asking for villagers who have species `frog` and personality `smug` will return all smug frogs).
/// Note that villagers only include the animals that act as residents.
/// Special characters, such as `Tom Nook` and `Isabelle`, are not accessed through this service.
abstract class VillagerService {
  /// Fetches a list of [Villager] names based on the specified filters.
  Future<List<String>> fetchNames({
    String? name,
    Species? species,
    Personality? personality,
    List<String> game,
    String? birthMonth,
    String? birthDay,
    bool? nhDetails,
    int? thumbSize,
  });

  /// Fetches a list of [Vilager]s based on the specified filters.
  Future<List<Villager>> fetchDetails({
    String? name,
    Species? species,
    Personality? personality,
    List<String> game,
    String? birthMonth,
    String? birthDay,
    bool? nhDetails,
    int? thumbSize,
  });
}
