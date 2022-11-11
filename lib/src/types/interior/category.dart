import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum InteriorCategory {
  @JsonValue("Floors")
  floors,
  @JsonValue("Wallpaper")
  wallpaper,
  @JsonValue("Rugs")
  rugs,
}
