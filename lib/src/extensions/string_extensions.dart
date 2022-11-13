extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  List<int> toHours() {
    if ("All day" == this) return _generate(0, 24);
    final times =
        split('–').map((e) => e.trim()).map((e) => e.toHour()).toList();
    final from = times[0], to = times[1];
    if (from < to) {
      return _generate(from, to);
    }
    return List.from(_generate(from, 24))..addAll(_generate(0, to));
  }

  int toHour() {
    if ("12 AM" == this) return 0; // Midnight
    var splitted = split(" ");
    return int.parse(splitted[0]) + (splitted[1] == "PM" ? 12 : 0);
  }

  List<int> _generate(int start, int end) =>
      [for (var i = start; i < end; i += 1) i];
}
