import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'material.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Material extends Equatable {
  final String name;
  final int count;

  const Material(
    this.name,
    this.count,
  );

  factory Material.fromJson(Map<String, dynamic> json) =>
      _$MaterialFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialToJson(this);

  @override
  List<Object?> get props => [
        name,
        count,
      ];
}
