import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../common/index.dart';
import 'furniture_function.dart';
import 'variation.dart';

part 'furniture.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Furniture extends Equatable {
  /// Link to the respective Nookipedia article.
  final String url;

  /// The name of the furniture.
  final String name;

  /// The category of item as shown in the player's inventory.
  final FurnitureCategory category;

  /// The furniture series the item is a part of, if any.
  /// A series is a collection of furniture and interior items, all with the same theme.
  /// If the item is not part of a series, this will be an empty string.
  final String itemSeries;

  /// The furniture set the item is a part of, if any. A set is a smaller collection of related furniture items.
  /// If the item is not part of a set, this will be an empty string.
  final String itemSet;

  /// The HHA category the item is a part of, if any. If the item does not have an HHA category, this will be an empty string.
  @JsonKey(name: "hha_category")
  final String happyHomeAcademyCategory;

  /// The tag of an item, if any, which denotes a specific use or relation to an event.
  /// Tags are determined by Nintendo. Examples include "Chair", "Musical Instrument", and "Mario".
  /// If the item does not have a tag, this will be an empty string.
  final String tag;

  /// The base value that the item provides to a player's Happy Home Academy score when placed in their home.
  @JsonKey(name: "hha_base")
  final int happyHomeAcademyBase;

  /// Whether or not the item is lucky. Lucky items give a 777-point HHA bonus.
  /// Some items are only counted as lucky in certain seasons, as indicated by the lucky_season field.
  final bool lucky;

  /// The season in which the item is lucky (or "All year" if lucky throughout the entire year). Items that are not lucky will have this field as an empty string.
  final String luckySeason;

  /// The number of Bells the item can be sold to Nook's store for.
  final int sell;

  /// The number of variations, between 0 and 8.
  final int variationTotal;

  /// The number of default patterns available to customize the item with, between 0 and 8.
  /// For items with customizable patterns, the player may also customize with patterns of their own.
  final int patternTotal;

  /// Whether or not the item is customizable via a crafting table.
  @JsonKey(name: "customizable")
  final bool isCustomizable;

  /// The number of custom_kit_types (e.g. Customization Kits) that are needed to customize this item. Value is 0 if the item is not customizable.
  final int customKits;

  /// The item that needs to be consumed to customize this item.
  /// The vast majority are "Customization Kit", but a small selection of items will require a different item, such as items in the Spooky Series requireing pumpkins.
  final String customKitType;

  /// If the item has variations, this is the name of the furniture part that changes.
  /// For example, for many bamboo items, the custom body part is "Bamboo" as the bamboo color is able to be customized.
  final String customBodyPart;

  /// If the item's pattern can be customized, this is the name of the furniture part that can have a pattern applied to it.
  /// For example, for the Baby Chair, the custom pattern part is "Cushion" as the cushion on the chair may have a pattern applied.
  final String customPatternPart;

  /// The height of the object. One in-game block is 10 units tall, while the player is 15.1324 units tall.
  @JsonKey(fromJson: _stringToDouble)
  final double height;

  /// Whether this item may be placed on the exterior door of the player's house.
  final bool doorDecor;

  /// The version of New Horizons that the item was added. Items that were included at the game's launch have version "1.0.0".
  final String versionAdded;

  /// Whether the item is available through legitimate gameplay.
  /// Some items are added to the game files in an update, but aren't actually made available until a subsequent update unlocks them.
  final bool unlocked;

  /// Any additional miscellaneous information about the item, such as a name change from a past update.
  final String notes;

  /// The number of widthwise grid spaces this item takes up.
  final double gridWidth;

  /// The number of lengthwise grid spaces this item takes up.
  final double gridLength;

  /// A list of themes (if any) that the item belongs to.
  final List<String> themes;

  /// A list of functionalities (if any) that the item has. For example, furniture that items can be placed on topof will have "Table" as a function..
  final List<FurnitureFunction> functions;

  /// Where the furniture may be obtained from (could be multiple sources).
  final List<Availability> availability;

  /// An array of prices, for when the item may be purchased with Bells, Nook Miles, etc..
  final List<Price> buy;

  /// An array of objects, each object representing a variation of the furniture.
  /// Furniture that has no variations (only one version) will have a single variation object with the image URL and colors,
  /// but the variation or pattern fields will be empty strings.
  /// Furniture with multiple variations will have the variation and/or pattern fields defined depending on whether the furniture varies by
  /// body variety, pattern, or both.
  final List<FurnitureVariation> variations;

  const Furniture(
    this.url,
    this.name,
    this.category,
    this.itemSeries,
    this.itemSet,
    this.happyHomeAcademyCategory,
    this.tag,
    this.happyHomeAcademyBase,
    this.lucky,
    this.luckySeason,
    this.sell,
    this.variationTotal,
    this.patternTotal,
    this.isCustomizable,
    this.customKits,
    this.customKitType,
    this.customBodyPart,
    this.customPatternPart,
    this.height,
    this.doorDecor,
    this.versionAdded,
    this.unlocked,
    this.notes,
    this.gridWidth,
    this.gridLength,
    this.themes,
    this.functions,
    this.availability,
    this.buy,
    this.variations,
  );

  factory Furniture.fromJson(Map<String, dynamic> json) =>
      _$FurnitureFromJson(json);

  Map<String, dynamic> toJson() => _$FurnitureToJson(this);

  static double _stringToDouble(Object obj) => double.parse(obj.toString());

  @override
  List<Object?> get props => [
        url,
        name,
        category,
        itemSeries,
        itemSet,
        happyHomeAcademyCategory,
        tag,
        happyHomeAcademyBase,
        lucky,
        luckySeason,
        sell,
        variationTotal,
        patternTotal,
        isCustomizable,
        customKits,
        customKitType,
        customBodyPart,
        customPatternPart,
        height,
        doorDecor,
        versionAdded,
        unlocked,
        notes,
        gridWidth,
        gridLength,
        themes,
        functions,
        availability,
        buy,
        variations,
      ];
}

@JsonEnum()
enum FurnitureCategory {
  @JsonValue("Housewares")
  housewares,
  @JsonValue("Miscellaneous")
  miscellaneous,
  @JsonValue("Wall-mounted")
  wallMounted;

  String toValue() => _$FurnitureCategoryEnumMap[this]!;
}
