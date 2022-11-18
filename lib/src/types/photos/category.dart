import 'package:json_annotation/json_annotation.dart';

/// Category of [Photo] items.
@JsonEnum()
enum PhotoCategory {
  @JsonValue("Photos")
  photo,
  @JsonValue("Posters")
  poster
}
