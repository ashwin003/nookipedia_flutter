import 'package:equatable/equatable.dart';

import '../../extensions/string_extensions.dart';

import 'month.dart';

class CritterMonthlyAvailability extends Equatable {
  final int monthNumber;
  final String monthName;
  final List<int> hours;
  final String hourString;

  const CritterMonthlyAvailability({
    required this.monthNumber,
    required this.monthName,
    required this.hours,
    required this.hourString,
  });

  factory CritterMonthlyAvailability.create(int month, String hourString) {
    return CritterMonthlyAvailability(
      monthNumber: month,
      monthName: Month.values[month - 1].name.toCapitalized(),
      hours: hourString.toHours(),
      hourString: hourString,
    );
  }

  @override
  List<Object?> get props => [
        monthNumber,
        monthName,
        hours,
        hourString,
      ];
}

class CritterAvailability extends Equatable {
  final bool availableAllYear;
  final List<CritterMonthlyAvailability> availability;

  const CritterAvailability({
    required this.availableAllYear,
    required this.availability,
  });

  factory CritterAvailability.fromJson(
    Map<String, dynamic> json,
    String version,
    String hemisphere,
  ) {
    List<CritterMonthlyAvailability> availabilityArray;
    bool availableAllYear = false;
    if ("1.0.0" == version) {
      final hemisphereShort = hemisphere[0].toString();
      availableAllYear = json["${hemisphereShort}_availability"] == "All year";
      availabilityArray =
          List<String>.from(json["${hemisphereShort}_availability_array"])
              .map((e) => int.parse(e))
              .map((e) {
        final hourString =
            json["times_by_month_$hemisphere"][e.toString()] as String;
        return CritterMonthlyAvailability.create(e, hourString);
      }).toList();
    } else {
      availableAllYear =
          json[hemisphere]["availability_array"][0]["months"] == "All year";
      availabilityArray =
          List<dynamic>.from(json[hemisphere]["months_array"]).map((e) {
        final hourString =
            json[hemisphere]["times_by_month"][e.toString()].toString();
        return CritterMonthlyAvailability.create(
            int.parse(e.toString()), hourString);
      }).toList();
    }
    return CritterAvailability(
      availableAllYear: availableAllYear,
      availability: availabilityArray,
    );
  }

  @override
  List<Object?> get props => [
        availableAllYear,
        availability,
      ];
}
