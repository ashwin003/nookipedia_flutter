import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ToolVariation extends Equatable {
  final String variation;
  final String imageUrl;

  const ToolVariation(
    this.variation,
    this.imageUrl,
  );

  factory ToolVariation.fromJson(Map<String, dynamic> json) =>
      _$ToolVariationFromJson(json);

  Map<String, dynamic> toJson() => _$ToolVariationToJson(this);

  @override
  List<Object?> get props => [
        variation,
        imageUrl,
      ];
}
