import 'package:dio/dio.dart';

import '../../exceptions/nookipedia_exception.dart';
import '../../types/nookipedia_error.dart';

abstract class ApiService {
  final String apiKey;
  final String version;
  final Dio dio;

  ApiService({
    required this.apiKey,
    required this.version,
    required this.dio,
  });

  bool _isEmpty(dynamic value) {
    if (value == null) {
      return true;
    }
    if (value is String) {
      return value.isEmpty;
    }
    return false;
  }

  Future<Response> _processRequestAsync(
      String requestUri, Map<String, dynamic> queryParameters) async {
    queryParameters.removeWhere((key, value) => _isEmpty(value));
    final headers = {
      "X-API-KEY": apiKey,
      "Accept-Version": version,
    };
    return await dio.get(
      requestUri,
      queryParameters: queryParameters,
      options: Options(
        headers: headers,
      ),
    );
  }

  Future<Iterable> processListRequest(
      String resourceUri, Map<String, dynamic> queryParameters) async {
    final response = await _processRequestAsync(resourceUri, queryParameters);
    if (response.statusCode != 200) {
      final error = NookipediaError.fromJson(response.data);
      throw NookipediaException(
        statusCode: response.statusCode,
        title: error.title,
        details: error.details,
      );
    }
    return response.data;
  }

  Future<dynamic> processObjectRequest(
      String resourceUri, Map<String, dynamic> queryParameters) async {
    final response = await _processRequestAsync(resourceUri, queryParameters);
    if (response.statusCode != 200) {
      final error = NookipediaError.fromJson(response.data);
      throw NookipediaException(
        statusCode: response.statusCode,
        title: error.title,
        details: error.details,
      );
    }
    return response.data;
  }
}
