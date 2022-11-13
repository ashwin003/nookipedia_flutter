import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'variation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PhotoVariation extends Equatable {
  final String variation;
  final String imageUrl;
  final List<String> colors;

  const PhotoVariation(
    this.variation,
    this.imageUrl,
    this.colors,
  );

  factory PhotoVariation.fromJson(Map<String, dynamic> json) =>
      _$PhotoVariationFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoVariationToJson(this);

  @override
  List<Object?> get props => [
        variation,
        imageUrl,
        colors,
      ];
}
