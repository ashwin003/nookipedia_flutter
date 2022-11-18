/// Thrown when the call to nookipedia api fails for whatever reason.
///
/// Potential failure http status codes:
/// 400: One of the input parameters has an invalid value.
/// 401: Failed to authenticate user using `X-API-KEY` header.
/// 500: There was an error in fetching the requested data.
class NookipediaException implements Exception {
  /// HTTP status code of the response.
  final int? statusCode;

  /// A brief title describing the error.
  final String title;

  /// A more in-depth description of the issue, including parameters and/or error text when available.
  final String details;

  NookipediaException({
    required this.statusCode,
    required this.title,
    required this.details,
  });
}
