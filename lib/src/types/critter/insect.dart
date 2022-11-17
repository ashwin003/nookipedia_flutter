import 'package:equatable/equatable.dart';

import 'critter.dart';

class Insect extends Critter {
  /// The number of Bells the bug can be sold to Flick for. This value is always `1.5`x that of `sellNook`.
  final int sellFlick;

  /// Short descriptor of where the insect can be found.
  final String location;
  const Insect({
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
    required this.sellFlick,
  });

  factory Insect.fromJson(Map<String, dynamic> json, String version) {
    final critter = Critter.fromJson(json, version);
    final location = json["location"] as String;
    final sellFlick = int.parse(json["sell_flick"].toString());
    return Insect(
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
      sellFlick: sellFlick,
    );
  }
}

class InsectByMonth extends Equatable {
  final String month;
  final List<Insect> north;
  final List<Insect> south;

  const InsectByMonth(
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

  factory InsectByMonth.fromJson(Map<String, dynamic> json, String version) {
    return InsectByMonth(
      json["month"].toString(),
      List<Map<String, dynamic>>.from(json["north"])
          .map((e) => Insect.fromJson(e, version))
          .toList(),
      List<Map<String, dynamic>>.from(json["south"])
          .map((e) => Insect.fromJson(e, version))
          .toList(),
    );
  }
}
