import 'package:json_annotation/json_annotation.dart';

/// The [Villager]'s personality.
@JsonEnum()
enum Personality {
  @JsonValue("Lazy")
  lazy,
  @JsonValue("Jock")
  jock,
  @JsonValue("Cranky")
  cranky,
  @JsonValue("Smug")
  smug,
  @JsonValue("Normal")
  normal,
  @JsonValue("Peppy")
  peppy,
  @JsonValue("Snooty")
  snooty,
  @JsonValue("Sisterly")
  sisterly,
}
