import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/index.dart';
import 'variation.dart';

part 'clothing.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Clothing extends Equatable {
  /// The name of the clothing.
  final String name;

  /// Link to the respective Nookipedia article.
  final String url;

  /// The category of item as shown in the player's inventory.
  final ClothingCategory category;

  /// The number of Bells the clothing can be sold to the store for.
  final int sell;

  /// The total number of variations the clothing has, between 0 and 8.
  final int variationTotal;

  /// Whether villagers may equip this item.
  @JsonKey(name: "vill_equip")
  final bool canVillagersEquip;

  /// The time of the year that the clothing is available.
  final String seasonality;

  /// The version of New Horizons that the item was added. Items that were included at the game's launch have version "1.0.0".
  final String versionAdded;

  /// Whether the item is available through legitimate gameplay.
  /// Some items are added to the game files in an update, but aren't actually made available until a subsequent update unlocks them.
  final bool unlocked;

  /// Any additional miscellaneous information about the clothing, such as a name change from a past update.
  final String notes;

  /// The clothing's Label theme(s). This is used for completing the requested outfit theme for Label when she visits the player's island.
  final List<String> labelThemes;

  /// The clothing's style(s). Styles are used for gifting villagers.
  final List<String> styles;

  /// Where the clothing may be obtained from (could be multiple sources).
  final List<Availability> availability;

  /// An array of prices, for when the item may be purchased with Bells, Nook Miles, etc..
  final List<Price> buy;

  /// An array of objects, each object representing a variation of the clothing.
  /// Clothing that has no variations (only one version) will have a single variation object with the image URL and colors, but the variation field will be empty.
  /// Clothing with multiple variations will have the variation fields defined with the name of each variation.
  final List<ClothingVariation> variations;

  const Clothing(
    this.name,
    this.url,
    this.category,
    this.sell,
    this.variationTotal,
    this.canVillagersEquip,
    this.seasonality,
    this.versionAdded,
    this.unlocked,
    this.notes,
    this.labelThemes,
    this.styles,
    this.availability,
    this.buy,
    this.variations,
  );

  factory Clothing.fromJson(Map<String, dynamic> json) =>
      _$ClothingFromJson(json);

  Map<String, dynamic> toJson() => _$ClothingToJson(this);

  @override
  List<Object?> get props => [
        name,
        url,
        category,
        sell,
        variationTotal,
        canVillagersEquip,
        seasonality,
        versionAdded,
        unlocked,
        notes,
        labelThemes,
        styles,
        availability,
        buy,
        variations,
      ];
}

@JsonEnum()
enum ClothingCategory {
  @JsonValue("Other")
  other,
  @JsonValue("Tops")
  tops,
  @JsonValue("Bottoms")
  bottoms,
  @JsonValue("Dress-Up")
  dressUp,
  @JsonValue("Headwear")
  headwear,
  @JsonValue("Accessories")
  accessories,
  @JsonValue("Socks")
  socks,
  @JsonValue("Shoes")
  shoes,
  @JsonValue("Bags")
  bags,
  @JsonValue("Umbrellas")
  umbrellas;

  String toValue() => _$ClothingCategoryEnumMap[this]!;
}
