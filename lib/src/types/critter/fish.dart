import 'package:equatable/equatable.dart';

import 'critter.dart';

class Fish extends Critter {
  /// The number of Bells the fish can be sold to C.J. for. This value is always `1.5`x that of `sellNook`.
  final int sellCJ;

  /// Short descriptor of where the fish can be found.
  final String location;

  /// The size of the fish's shadow.
  final String shadowSize;
  const Fish({
    required super.number,
    required super.name,
    required super.url,
    required super.imageUrl,
    required super.renderUrl,
    required super.catchphrases,
    required this.location,
    required super.rarity,
    required super.totalCatch,
    required super.sellNook,
    required super.tankWidth,
    required super.tankLength,
    required super.north,
    required super.south,
    required this.sellCJ,
    required this.shadowSize,
  });

  factory Fish.fromJson(Map<String, dynamic> json, String version) {
    final critter = Critter.fromJson(json, version);
    final location = json["location"] as String;
    final sellCJ = int.parse(json["sell_cj"].toString());
    final shadowSize = json["shadow_size"] as String;

    return Fish(
        number: critter.number,
        name: critter.name,
        url: critter.url,
        imageUrl: critter.imageUrl,
        renderUrl: critter.renderUrl,
        catchphrases: critter.catchphrases,
        location: location,
        rarity: critter.rarity,
        totalCatch: critter.totalCatch,
        sellNook: critter.sellNook,
        tankWidth: critter.tankWidth,
        tankLength: critter.tankLength,
        north: critter.north,
        south: critter.south,
        sellCJ: sellCJ,
        shadowSize: shadowSize);
  }
}

class FishByMonth extends Equatable {
  final String month;
  final List<Fish> north;
  final List<Fish> south;

  const FishByMonth(
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

  factory FishByMonth.fromJson(Map<String, dynamic> json, String version) {
    return FishByMonth(
      json["month"].toString(),
      List<Map<String, dynamic>>.from(json["north"])
          .map((e) => Fish.fromJson(e, version))
          .toList(),
      List<Map<String, dynamic>>.from(json["south"])
          .map((e) => Fish.fromJson(e, version))
          .toList(),
    );
  }
}
