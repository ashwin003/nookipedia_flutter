import 'package:json_annotation/json_annotation.dart';
part 'nookipedia_error.g.dart';

@JsonSerializable()
class NookipediaError {
  final String title;
  final String details;

  NookipediaError(
    this.title,
    this.details,
  );

  factory NookipediaError.fromJson(Map<String, String> json) =>
      _$NookipediaErrorFromJson(json);

  Map<String, dynamic> toJson() => _$NookipediaErrorToJson(this);
}
