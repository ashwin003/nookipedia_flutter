import 'package:json_annotation/json_annotation.dart';

/// Star sign of the [Villager]s.
@JsonEnum()
enum Zodiac {
  @JsonValue("Aries")
  aries,
  @JsonValue("Taurus")
  taurus,
  @JsonValue("Gemini")
  gemini,
  @JsonValue("Cancer")
  cancer,
  @JsonValue("Leo")
  leo,
  @JsonValue("Virgo")
  virgo,
  @JsonValue("Libra")
  libra,
  @JsonValue("Scorpio")
  scorpio,
  @JsonValue("Sagittarius")
  sagittarius,
  @JsonValue("Capricorn")
  capricorn,
  @JsonValue("Aquarius")
  aquarius,
  @JsonValue("Pisces")
  pisces
}
