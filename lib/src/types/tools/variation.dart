import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ToolVariation {
  final String variation;
  final String imageUrl;

  ToolVariation(
    this.variation,
    this.imageUrl,
  );

  factory ToolVariation.fromJson(Map<String, dynamic> json) =>
      _$ToolVariationFromJson(json);

  Map<String, dynamic> toJson() => _$ToolVariationToJson(this);
}
