import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClothingVariation {
  final String variation;
  final String imageUrl;
  final List<String> colors;

  ClothingVariation(
    this.variation,
    this.imageUrl,
    this.colors,
  );

  factory ClothingVariation.fromJson(Map<String, dynamic> json) =>
      _$ClothingVariationFromJson(json);

  Map<String, dynamic> toJson() => _$ClothingVariationToJson(this);
}
