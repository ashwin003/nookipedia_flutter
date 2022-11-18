import 'package:json_annotation/json_annotation.dart';

/// Gender of the [Villager].
@JsonEnum()
enum Gender {
  @JsonValue("Female")
  female,
  @JsonValue("Male")
  male
}
