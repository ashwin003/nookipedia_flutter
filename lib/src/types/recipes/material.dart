import 'package:json_annotation/json_annotation.dart';

part 'material.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Material {
  final String name;
  final int count;

  Material(
    this.name,
    this.count,
  );

  factory Material.fromJson(Map<String, dynamic> json) =>
      _$MaterialFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialToJson(this);
}
