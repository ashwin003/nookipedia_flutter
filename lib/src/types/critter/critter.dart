import 'package:nookipedia_flutter/src/types/critter/rarity.dart';

import 'availability.dart';

class Critter {
  /// In-game critter number, marking position in the Critterpedia.
  final int number;

  /// Name of the critter.
  final String name;

  /// Link to the respective Nookipedia article.
  final String url;

  /// Image of the critter. dodo.ac is Nookipedia's CDN server.
  final String imageUrl;

  /// Render of the critter. dodo.ac is Nookipedia's CDN server.
  final String renderUrl;

  /// An array of possible catchphrases the player says after catching the critter. Most critters have just one, but some can have multiple.
  final List<String> catchphrases;

  /// How rare the critter is.
  /// Note that this field is currently empty for most critters as we do not yet know how exactly critter rarities are calculated in the game code.
  final Rarity rarity;

  /// The total number of critter the player has to have caught before this critter will start spawning.
  final int totalCatch;

  /// The number of Bells the critter can be sold to Nook's store for.
  final int sellNook;

  /// The width of the tank when the critter is placed as a furniture item.
  final double tankWidth;

  /// The length of the tank when the critter is placed as a furniture item.
  final double tankLength;

  /// When you can catch the critter in the Northern hemisphere.
  final CritterAvailability north;

  /// When you can catch the critter in the Southern hemisphere.
  final CritterAvailability south;

  Critter({
    required this.number,
    required this.name,
    required this.url,
    required this.imageUrl,
    required this.renderUrl,
    required this.catchphrases,
    required this.rarity,
    required this.totalCatch,
    required this.sellNook,
    required this.tankWidth,
    required this.tankLength,
    required this.north,
    required this.south,
  });

  factory Critter.fromJson(Map<String, dynamic> json, String version) {
    final name = json["name"] as String;
    final url = json["url"] as String;
    final number = int.parse(json["number"].toString());
    final imageUrl = json["image_url"] as String;
    final renderUrl = json["render_url"] as String;
    final rarity = stringToRarityMap[json["rarity"] as String]!;
    final totalCatch = int.parse(json["total_catch"].toString());
    final sellNook = int.parse(json["sell_nook"].toString());
    final tankWidth = double.parse(json["tank_width"].toString());
    final tankLength = double.parse(json["tank_length"].toString());
    final catchphrases = "1.0.0" == version
        ? [
            json["catchphrase"] as String,
            json["catchphrase2"] as String,
            json["catchphrase3"] as String,
          ]
        : List<String>.from(json["catchphrases"]);
    return Critter(
      number: number,
      name: name,
      url: url,
      imageUrl: imageUrl,
      renderUrl: renderUrl,
      catchphrases:
          catchphrases.where((element) => element.isNotEmpty).toList(),
      rarity: rarity,
      totalCatch: totalCatch,
      sellNook: sellNook,
      tankWidth: tankWidth,
      tankLength: tankLength,
      north: CritterAvailability.fromJson(json, version, "north"),
      south: CritterAvailability.fromJson(json, version, "south"),
    );
  }

  @override
  bool operator ==(Object other) => other is Critter && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
