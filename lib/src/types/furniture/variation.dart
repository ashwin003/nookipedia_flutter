import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FurnitureVariation {
  final String variation;
  final String pattern;
  final String imageUrl;
  final List<String> colors;

  FurnitureVariation(
    this.variation,
    this.pattern,
    this.imageUrl,
    this.colors,
  );

  factory FurnitureVariation.fromJson(Map<String, dynamic> json) =>
      _$FurnitureVariationFromJson(json);

  Map<String, dynamic> toJson() => _$FurnitureVariationToJson(this);
}
