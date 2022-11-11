import 'package:json_annotation/json_annotation.dart';

import '../common/availability.dart';
import '../common/price.dart';
import 'category.dart';

part 'interior.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Interior {
  /// Link to the respective Nookipedia article.
  final String url;

  /// The name of the interior.
  final String name;

  /// Image of the interior. dodo.ac is Nookipedia's CDN server.
  final String imageUrl;

  /// The category of item as shown in the player's inventory.
  final InteriorCategory category;

  /// The furniture series the item is a part of, if any.
  /// A series is a collection of furniture and interior items, all with the same theme. If the item is not part of a series, this will be an empty string.
  final String itemSeries;

  /// The furniture set the item is a part of, if any. A set is a smaller collection of related furniture items. If the item is not part of a set, this will be an empty string.
  final String itemSet;

  /// The HHA category the item is a part of, if any. If the item does not have an HHA category, this will be an empty string.
  @JsonKey(name: "hha_category")
  final String happyHomeAcademyCategory;

  /// The tag of an item, if any, which denotes a specific use or relation to an event.
  /// Tags are determined by Nintendo. Examples include "Chair", "Musical Instrument", and "Mario". If the item does not have a tag, this will be an empty string.
  final String tag;

  /// The base value that the item provides to a player's Happy Home Academy score when placed in their home.
  @JsonKey(name: "hha_base")
  final int happyHomeAcademyBase;

  /// The number of Bells the interior can be sold to Nook's store for.
  final int sell;

  /// The version of New Horizons that the item was added. Items that were included at the game's launch have version "1.0.0".
  final String versionAdded;

  /// Whether the item is available through legitimate gameplay.
  /// Some items are added to the game files in an update, but aren't actually made available until a subsequent update unlocks them.
  final bool unlocked;

  /// Any additional miscellaneous information about the item, such as a name change from a past update.
  final String notes;

  /// The number of widthwise grid spaces this item takes up.
  final String gridWidth;

  /// The number of lengthwise grid spaces this item takes up.
  final String gridLength;

  /// A list of themes (if any) that the item belongs to.
  final List<String> themes;
  final List<String> colors;

  /// Where the clothing may be obtained from (could be multiple sources).
  final List<Availability> availability;

  /// An array of prices, for when the interior may be purchased with Bells, Nook Miles, etc
  final List<Price> buy;

  Interior(
    this.url,
    this.name,
    this.imageUrl,
    this.category,
    this.itemSeries,
    this.itemSet,
    this.happyHomeAcademyCategory,
    this.tag,
    this.happyHomeAcademyBase,
    this.sell,
    this.versionAdded,
    this.unlocked,
    this.notes,
    this.gridWidth,
    this.gridLength,
    this.themes,
    this.colors,
    this.availability,
    this.buy,
  );

  factory Interior.fromJson(Map<String, dynamic> json) =>
      _$InteriorFromJson(json);

  Map<String, dynamic> toJson() => _$InteriorToJson(this);

  @override
  bool operator ==(Object other) => other is Interior && other.url == url;

  @override
  int get hashCode => url.hashCode;
}
