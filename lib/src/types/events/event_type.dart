import 'package:json_annotation/json_annotation.dart';

/// The type of event.
@JsonEnum()
enum EventType {
  /// A festivity the player can take part in.
  @JsonValue("Event")
  event,

  /// The seasonal events in which exclusive item(s) are available via [Nook Shopping](https://nookipedia.com/wiki/Nook_Shopping).
  @JsonValue("Nook Shopping")
  nookShopping,

  /// The start or end of certain recipes being available.
  @JsonValue("Recipes")
  recipes,

  /// The birthday of a villager or special character.
  @JsonValue("Birthday")
  birthday,

  @JsonValue("Season")
  season
}
