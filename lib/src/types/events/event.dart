import 'package:json_annotation/json_annotation.dart';
import 'package:nookipedia_flutter/src/types/events/index.dart';

part 'event.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AnimalCrossingEvent {
  /// The description of the event.
  final String event;

  /// The date of the event in YYYY-MM-DD format.
  final DateTime date;

  /// The type of event.
  final EventType type;

  /// Link to the respective Nookipedia article.
  final String url;

  AnimalCrossingEvent(
    this.event,
    this.date,
    this.type,
    this.url,
  );

  factory AnimalCrossingEvent.fromJson(Map<String, dynamic> json) =>
      _$AnimalCrossingEventFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalCrossingEventToJson(this);

  @override
  bool operator ==(Object other) =>
      other is AnimalCrossingEvent &&
      other.event == event &&
      other.date == date;

  @override
  int get hashCode => event.hashCode + date.hashCode;
}
