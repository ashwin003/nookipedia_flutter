import 'critter.dart';

class SeaCreature extends Critter {
  const SeaCreature({
    required super.number,
    required super.name,
    required super.url,
    required super.imageUrl,
    required super.renderUrl,
    required super.catchphrases,
    required super.rarity,
    required super.totalCatch,
    required super.sellNook,
    required super.tankWidth,
    required super.tankLength,
    required super.north,
    required super.south,
  });

  factory SeaCreature.fromJson(Map<String, dynamic> json, String version) {
    final critter = Critter.fromJson(json, version);

    return SeaCreature(
      number: critter.number,
      name: critter.name,
      url: critter.url,
      imageUrl: critter.imageUrl,
      renderUrl: critter.renderUrl,
      catchphrases: critter.catchphrases,
      rarity: critter.rarity,
      totalCatch: critter.totalCatch,
      sellNook: critter.sellNook,
      tankWidth: critter.tankWidth,
      tankLength: critter.tankLength,
      north: critter.north,
      south: critter.south,
    );
  }
}
