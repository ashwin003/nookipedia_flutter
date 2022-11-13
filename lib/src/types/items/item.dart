import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../common/index.dart';

part 'item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Item extends Equatable {
  /// Link to the respective Nookipedia article.
  final String url;

  /// The name of the item.
  final String name;

  /// Image of the interior. dodo.ac is Nookipedia's CDN server.
  final String imageUrl;

  /// How much the item can stack up to in a single inventory slot.
  final int stack;

  /// The base value that the item provides to a player's Happy Home Academy score when placed in their home.
  @JsonKey(name: "hha_base")
  final int happyHomeAcademyBase;

  /// The number of Bells the interior can be sold to Nook's store for.
  final int sell;

  /// Whether or not the item is a fence or not.
  final bool isFence;
  final String materialType;
  final String materialSeasonality;
  final int materialSort;
  final int materialNameSort;
  final int materialSeasonalitySort;

  /// Whether the item is edible or not.
  @JsonKey(name: "edible")
  final bool isEdible;
  final String plantType;

  /// The version of New Horizons that the item was added. Items that were included at the game's launch have version "1.0.0".
  final String versionAdded;

  /// Whether the item is available through legitimate gameplay.
  /// Some items are added to the game files in an update, but aren't actually made available until a subsequent update unlocks them.
  final bool unlocked;

  /// Any additional miscellaneous information about the item, such as a name change from a past update.
  final String notes;

  /// Where the clothing may be obtained from (could be multiple sources).
  final List<Availability> availability;

  /// An array of prices, for when the interior may be purchased with Bells, Nook Miles, etc..
  final List<Price> buy;

  const Item(
    this.url,
    this.name,
    this.imageUrl,
    this.stack,
    this.happyHomeAcademyBase,
    this.sell,
    this.isFence,
    this.materialType,
    this.materialSeasonality,
    this.materialSort,
    this.materialNameSort,
    this.materialSeasonalitySort,
    this.isEdible,
    this.plantType,
    this.versionAdded,
    this.unlocked,
    this.notes,
    this.availability,
    this.buy,
  );

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  List<Object?> get props => [
        url,
        name,
        imageUrl,
        stack,
        happyHomeAcademyBase,
        sell,
        isFence,
        materialType,
        materialSeasonality,
        materialSort,
        materialNameSort,
        materialSeasonalitySort,
        isEdible,
        plantType,
        versionAdded,
        unlocked,
        notes,
        availability,
        buy,
      ];
}
