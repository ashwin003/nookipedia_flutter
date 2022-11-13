import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'availability.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Availability extends Equatable {
  /// A brief description of the source.
  final String from;

  /// When provided, provides additional details.
  final String note;

  const Availability(
    this.from,
    this.note,
  );

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);

  @override
  List<Object?> get props => [
        from,
        note,
      ];
}
