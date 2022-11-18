import 'package:json_annotation/json_annotation.dart';

/// The [Villager]'s hobby.
@JsonEnum()
enum Hobby {
  @JsonValue("")
  unspecified,

  @JsonValue("Education")
  education,
  @JsonValue("Fitness")
  fitness,
  @JsonValue("Fashion")
  fashion,
  @JsonValue("Nature")
  nature,
  @JsonValue("Play")
  play,
  @JsonValue("Music")
  music
}
