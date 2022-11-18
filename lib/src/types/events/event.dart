import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'hemisphere.dart';

import 'event_type.dart';

part 'event.g.dart';

/// Any festivity, season, or event that occurs within Animal Crossing New Horizons.
@JsonSerializable(fieldRename: FieldRename.snake)
class AnimalCrossingEvent extends Equatable {
  /// The description of the event.
  final String event;

  /// The date of the event in YYYY-MM-DD format.
  final DateTime date;

  /// The type of event.
  final EventType type;

  /// Link to the respective Nookipedia article.
  final String url;

  String get parsedEvent => _removeHemisphere(event);

  Hemisphere get hemisphere {
    if (!_regex.hasMatch(event)) return Hemisphere.both;
    var match = _regex
        .firstMatch(event)![0]!
        .replaceFirst("(", "")
        .replaceFirst(")", "")
        .replaceFirst(" Hemisphere", "");
    switch (match) {
      case "Northern":
        return Hemisphere.northern;
      case "Southern":
        return Hemisphere.southern;
      default:
        throw Exception("Invalid event caught $event");
    }
  }

  const AnimalCrossingEvent(
    this.event,
    this.date,
    this.type,
    this.url,
  );

  factory AnimalCrossingEvent.fromJson(Map<String, dynamic> json) =>
      _$AnimalCrossingEventFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalCrossingEventToJson(this);

  static final RegExp _regex = RegExp(r'\((\w{3}thern Hemisphere\))');

  static String _removeHemisphere(Object obj) =>
      obj.toString().replaceFirst(_regex, '').trim();

  @override
  List<Object?> get props => [
        event,
        date,
        type,
        url,
      ];
}
