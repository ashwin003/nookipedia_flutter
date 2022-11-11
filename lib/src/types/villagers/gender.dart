import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum Gender {
  @JsonValue("Female")
  female,
  @JsonValue("Male")
  male
}
