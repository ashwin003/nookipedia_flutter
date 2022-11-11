class NookipediaException implements Exception {
  final String title;
  final String details;

  NookipediaException({
    required this.title,
    required this.details,
  });
}
