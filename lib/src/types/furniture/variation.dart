import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FurnitureVariation extends Equatable {
  final String variation;
  final String pattern;
  final String imageUrl;
  final List<String> colors;

  const FurnitureVariation(
    this.variation,
    this.pattern,
    this.imageUrl,
    this.colors,
  );

  factory FurnitureVariation.fromJson(Map<String, dynamic> json) =>
      _$FurnitureVariationFromJson(json);

  Map<String, dynamic> toJson() => _$FurnitureVariationToJson(this);

  @override
  List<Object?> get props => [
        variation,
        pattern,
        imageUrl,
        colors,
      ];
}
