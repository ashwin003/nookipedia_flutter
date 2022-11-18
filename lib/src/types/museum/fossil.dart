import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fossil.g.dart';

/// Individual fossils found within Animal Crossing New Horizons.
@JsonSerializable(fieldRename: FieldRename.snake)
class Fossil extends Equatable {
  /// The name of the fossil.
  final String name;

  /// Link to the respective Nookipedia article.
  final String url;

  /// Image of the fossil's icon. dodo.ac is Nookipedia's CDN server.
  final String imageUrl;

  /// The name of the group that the fossil belongs to.
  @JsonKey(defaultValue: "")
  final String fossilGroup;

  /// Whether or not the item can be interacted with.
  @JsonKey(name: "interactable")
  final bool isInteractive;

  /// The number of bells the item can be sold to Nook's store for.
  final int sell;

  /// The base value that the item provides to a player's Happy Home Academy score when placed in their home.
  @JsonKey(name: "hha_base")
  final int happyHomeAcademyBase;

  /// The width of the fossil.
  final double width;

  /// The length of the fossil.
  final double length;
  final List<String> colors;

  const Fossil(
    this.name,
    this.url,
    this.imageUrl,
    this.fossilGroup,
    this.isInteractive,
    this.sell,
    this.happyHomeAcademyBase,
    this.width,
    this.length,
    this.colors,
  );

  factory Fossil.fromJson(Map<String, dynamic> json) => _$FossilFromJson(json);

  Map<String, dynamic> toJson() => _$FossilToJson(this);

  @override
  List<Object?> get props => [
        name,
        url,
        imageUrl,
        fossilGroup,
        isInteractive,
        sell,
        happyHomeAcademyBase,
        width,
        length,
        colors,
      ];
}

/// Fossil Groups found in Animal Crossing New Horizons.
@JsonSerializable(fieldRename: FieldRename.snake)
class FossilGroup extends Equatable {
  final String name;
  final String url;
  final int room;
  final String description;
  final List<Fossil>? fossils;

  const FossilGroup(
    this.name,
    this.url,
    this.room,
    this.description,
    this.fossils,
  );

  factory FossilGroup.fromJson(Map<String, dynamic> json) =>
      _$FossilGroupFromJson(json);

  Map<String, dynamic> toJson() => _$FossilGroupToJson(this);

  @override
  List<Object?> get props => [
        name,
        url,
        room,
        description,
        fossils,
      ];
}
