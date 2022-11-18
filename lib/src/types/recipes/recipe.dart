import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/index.dart';
import 'material.dart';

part 'recipe.g.dart';

/// The DIY recipes that can be learnt.
@JsonSerializable(fieldRename: FieldRename.snake)
class Recipe extends Equatable {
  /// Link to the respective Nookipedia article.
  final String url;

  /// The name of the recipe.
  final String name;

  /// Image of the item the recipe crafts. dodo.ac is Nookipedia's CDN server.
  final String imageUrl;

  /// The unique in-game ID of the recipe.
  final int serialId;

  /// The number of Bells the sea creature can be sold to Nook's store for.
  final int sell;

  /// How many recipes the player has to have learned to unlock this one.
  final int recipesToUnlock;

  /// The list of materials required to craft the item.
  final List<Material> materials;

  /// Where the recipe may be obtained from.
  final List<Availability> availability;

  /// An array of prices, for when the recipe may be purchased with Bells, Nook Miles, etc.
  /// The majority of recipes cannot be bought (in which case this array will be empty).
  final List<Price> buy;

  const Recipe(
    this.url,
    this.name,
    this.imageUrl,
    this.serialId,
    this.sell,
    this.recipesToUnlock,
    this.materials,
    this.availability,
    this.buy,
  );

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  @override
  List<Object?> get props => [
        url,
        name,
        imageUrl,
        serialId,
        sell,
        recipesToUnlock,
        materials,
        availability,
        buy,
      ];
}
