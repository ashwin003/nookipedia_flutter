import 'package:equatable/equatable.dart';

import 'critter.dart';

class SeaCreature extends Critter {
  /// The size of the sea creature's shadow.
  final String shadowSize;
  final String shadowMovement;
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
    required this.shadowSize,
    required this.shadowMovement,
  });

  factory SeaCreature.fromJson(Map<String, dynamic> json, String version) {
    final critter = Critter.fromJson(json, version);
    final shadowSize = json["shadow_size"] as String;
    final shadowMovement = json["shadow_movement"] as String;

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
        shadowSize: shadowSize,
        shadowMovement: shadowMovement);
  }
}

class SeaCreatureByMonth extends Equatable {
  final String month;
  final List<SeaCreature> north;
  final List<SeaCreature> south;

  const SeaCreatureByMonth(
    this.month,
    this.north,
    this.south,
  );

  @override
  List<Object?> get props => [
        month,
        north,
        south,
      ];

  factory SeaCreatureByMonth.fromJson(
      Map<String, dynamic> json, String version) {
    return SeaCreatureByMonth(
      json["month"].toString(),
      List<Map<String, dynamic>>.from(json["north"])
          .map((e) => SeaCreature.fromJson(e, version))
          .toList(),
      List<Map<String, dynamic>>.from(json["south"])
          .map((e) => SeaCreature.fromJson(e, version))
          .toList(),
    );
  }
}
