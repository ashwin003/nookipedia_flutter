import 'package:json_annotation/json_annotation.dart';

/// Category of the [Interior] items available.
@JsonEnum()
enum InteriorCategory {
  @JsonValue("Floors")
  floors,
  @JsonValue("Wallpaper")
  wallpaper,
  @JsonValue("Rugs")
  rugs,
}
