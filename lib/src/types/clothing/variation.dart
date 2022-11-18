import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

/// Variations of the [Clothing] available.
@JsonSerializable(fieldRename: FieldRename.snake)
class ClothingVariation extends Equatable {
  final String variation;
  final String imageUrl;
  final List<String> colors;

  const ClothingVariation(
    this.variation,
    this.imageUrl,
    this.colors,
  );

  factory ClothingVariation.fromJson(Map<String, dynamic> json) =>
      _$ClothingVariationFromJson(json);

  Map<String, dynamic> toJson() => _$ClothingVariationToJson(this);

  @override
  List<Object?> get props => [
        variation,
        imageUrl,
        colors,
      ];
}
