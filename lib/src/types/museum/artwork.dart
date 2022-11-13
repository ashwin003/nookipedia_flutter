import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artwork.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Artwork extends Equatable {
  /// Name of the artwork.
  final String name;

  /// Link to the respective Nookipedia article.
  final String url;

  /// Image of the real artwork. dodo.ac is Nookipedia's CDN server.
  final String imageUrl;

  /// Whether the artwork has a fake or not.
  final bool hasFake;

  /// Image of the fake artwork, if it exists.
  final String fakeImageUrl;

  /// The name of the real-life analog to the artwork.
  final String artName;

  /// The author of the real-life analog to the artwork.
  final String author;

  /// The year that the real-life analog was made.
  final String year;

  /// The art style of the artwork.
  final String artStyle;

  /// The description of the artwork.
  final String description;

  /// The number of Bells the artwork may be purchased for.
  final int buy;

  /// The number of Bells the artwork can be sold to Nook's store for, when it is genuine.
  final int sell;

  /// The availability of the artwork.
  final String availability;

  /// The description of the difference between real and fake, if there is one
  final String authenticity;

  /// The width of the artwork.
  final double width;

  /// The length of the artwork.
  final double length;

  const Artwork(
    this.name,
    this.url,
    this.imageUrl,
    this.hasFake,
    this.fakeImageUrl,
    this.artName,
    this.author,
    this.year,
    this.artStyle,
    this.description,
    this.buy,
    this.sell,
    this.availability,
    this.authenticity,
    this.width,
    this.length,
  );

  factory Artwork.fromJson(Map<String, dynamic> json) =>
      _$ArtworkFromJson(json);

  Map<String, dynamic> toJson() => _$ArtworkToJson(this);

  @override
  bool operator ==(Object other) => other is Artwork && other.url == url;

  @override
  int get hashCode => url.hashCode;

  @override
  List<Object?> get props => [
        name,
        url,
        imageUrl,
        hasFake,
        fakeImageUrl,
        artName,
        author,
        year,
        artStyle,
        description,
        buy,
        sell,
        availability,
        authenticity,
        width,
        length,
      ];
}
