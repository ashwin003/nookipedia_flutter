import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum PhotoCategory {
  @JsonValue("Photos")
  photo,
  @JsonValue("Posters")
  poster
}
