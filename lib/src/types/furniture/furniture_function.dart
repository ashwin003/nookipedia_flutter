import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum FurnitureFunction {
  @JsonValue("Trash")
  trash,
  @JsonValue("Toilet")
  toilet,
  @JsonValue("Table")
  table,
  @JsonValue("Storage")
  storage,
  @JsonValue("Stereo")
  stereo,
  @JsonValue("Seating")
  seating,
  @JsonValue("Lighting")
  lighting,
  @JsonValue("Instrument")
  instrument,
  @JsonValue("Dresser")
  dresser,
  @JsonValue("Bed")
  bed,
  @JsonValue("Audio")
  audio
}
