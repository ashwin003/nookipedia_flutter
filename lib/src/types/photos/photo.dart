import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/index.dart';
import 'category.dart';
import 'variation.dart';

part 'photo.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Photo extends Equatable {
  /// Link to the respective Nookipedia article.
  final String url;

  /// The name of the photo.
  final String name;

  /// The category of item as shown in the player's inventory.
  final PhotoCategory category;
  @JsonKey(name: "hha_base")
  final int happyHomeAcademyBase;

  /// The number of Bells the photo can be sold to the store for.
  final int sell;

  /// Whether or not the item is customizable via a crafting table.
  @JsonKey(name: "customizable")
  final bool isCustomizable;

  /// The number of custom_kit_types (e.g. Customization Kits) that are needed to customize this item. Value is 0 if the item is not customizable.
  final int customKits;

  /// If the item has variations, this is the name of the furniture part that changes.
  /// For example, for many bamboo items, the custom body part is "Bamboo" as the bamboo color is able to be customized.
  final String customBodyPart;

  /// Whether or not the item can be interacted with. This field is true for all photos and false for all posters.
  @JsonKey(name: "interactable")
  final bool isInteractive;

  /// The version of New Horizons that the item was added. Items that were included at the game's launch have version "1.0.0".
  final String versionAdded;

  /// Whether the item is available through legitimate gameplay.
  /// Some items are added to the game files in an update, but aren't actually made available until a subsequent update unlocks them.
  final bool unlocked;

  /// The number of widthwise grid spaces this item takes up.
  final double gridWidth;

  /// The number of lengthwise grid spaces this item takes up.
  final double gridLength;

  /// Where the photo may be obtained from (could be multiple sources).
  final List<Availability> availability;

  /// An array of prices, for when the item may be purchased with Bells, Nook Miles, etc..
  final List<Price> buy;

  /// An array of objects, each object representing a variation of the photo or poster.
  /// Items that has no variations (only one version) will have a single variation object with the image URL and colors, but the variation field will be empty.
  /// Items with multiple variations will have the variation fields defined with the name of each variation.
  final List<PhotoVariation> variations;

  const Photo(
    this.url,
    this.name,
    this.category,
    this.happyHomeAcademyBase,
    this.sell,
    this.isCustomizable,
    this.customKits,
    this.customBodyPart,
    this.isInteractive,
    this.versionAdded,
    this.unlocked,
    this.gridWidth,
    this.gridLength,
    this.availability,
    this.buy,
    this.variations,
  );

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  List<Object?> get props => [
        url,
        name,
        category,
        happyHomeAcademyBase,
        sell,
        isCustomizable,
        customKits,
        customBodyPart,
        isInteractive,
        versionAdded,
        unlocked,
        gridWidth,
        gridLength,
        availability,
        buy,
        variations,
      ];
}
