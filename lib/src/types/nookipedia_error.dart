import 'package:json_annotation/json_annotation.dart';
part 'nookipedia_error.g.dart';

/// @nodoc
@JsonSerializable()
class NookipediaError {
  /// A brief title describing the error.
  final String title;

  /// A more in-depth description of the issue, including parameters and/or error text when available.
  final String details;

  NookipediaError(
    this.title,
    this.details,
  );

  factory NookipediaError.fromJson(Map<String, String> json) =>
      _$NookipediaErrorFromJson(json);

  Map<String, dynamic> toJson() => _$NookipediaErrorToJson(this);
}
