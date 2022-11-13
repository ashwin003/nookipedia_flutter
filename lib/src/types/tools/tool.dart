import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/index.dart';
import 'variation.dart';

part 'tool.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Tool extends Equatable {
  /// Link to the respective Nookipedia article.
  final String url;

  /// The name of the tool.
  final String name;

  /// How many times the tool can be used before breaking.
  @JsonKey(fromJson: _stringToInt)
  final int uses;

  /// The base value that the item provides to a player's Happy Home Academy score when placed in their home.
  @JsonKey(name: "hha_base")
  final int happyHomeAcademyBase;

  /// The number of bells the tool can be sold to the store for.
  final int sell;

  /// Whether or not the item is customizable via a crafting table.
  @JsonKey(name: "customizable")
  final bool isCustomizable;

  /// The number of custom_kit_types (e.g. Customization Kits) that are needed to customize this item. Value is 0 if the item is not customizable.
  final int customKits;

  /// If the item has variations, this is the name of the furniture part that changes.
  /// For example, for many bamboo items, the custom body part is "Bamboo" as the bamboo color is able to be customized.
  final String customBodyPart;

  /// The version of New Horizons that the item was added. Items that were included at the game's launch have version "1.0.0".
  final String versionAdded;

  /// Whether the item is available through legitimate gameplay.
  /// Some items are added to the game files in an update, but aren't actually made available until a subsequent update unlocks them.
  final bool unlocked;

  /// Any additional miscellaneous information about the item, such as a name change from a past update.
  final String notes;

  /// Where the tool may be obtained from (could be multiple sources).
  final List<Availability> availability;

  /// An array of prices, for when the item may be purchased with Bells, Nook Miles, etc..
  final List<Price> buy;

  /// An array of objects, each object representing a variation of the tool.
  /// Tools that has no variations (only one version) will have a single variation object with the image URL and colors, but the variation field will be empty.
  /// Tools with multiple variations will have the variation fields defined with the name of each variation.
  final List<ToolVariation> variations;

  const Tool(
    this.url,
    this.name,
    this.uses,
    this.happyHomeAcademyBase,
    this.sell,
    this.isCustomizable,
    this.customKits,
    this.customBodyPart,
    this.versionAdded,
    this.unlocked,
    this.notes,
    this.availability,
    this.buy,
    this.variations,
  );

  factory Tool.fromJson(Map<String, dynamic> json) => _$ToolFromJson(json);

  Map<String, dynamic> toJson() => _$ToolToJson(this);

  static int _stringToInt(Object obj) => int.parse(obj.toString());

  @override
  List<Object?> get props => [
        url,
        name,
        uses,
        happyHomeAcademyBase,
        sell,
        isCustomizable,
        customKits,
        customBodyPart,
        versionAdded,
        unlocked,
        notes,
        availability,
        buy,
        variations,
      ];
}
