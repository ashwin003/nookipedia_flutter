import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PhotoVariation {
  final String variation;
  final String imageUrl;
  final List<String> colors;

  PhotoVariation(
    this.variation,
    this.imageUrl,
    this.colors,
  );

  factory PhotoVariation.fromJson(Map<String, dynamic> json) =>
      _$PhotoVariationFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoVariationToJson(this);
}
