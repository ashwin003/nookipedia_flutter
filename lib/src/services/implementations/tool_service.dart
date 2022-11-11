import 'package:nookipedia_flutter/src/types/tools/tool.dart';

import '../tool_service.dart';
import 'api_service.dart';

class ToolServiceImpl extends ApiService implements ToolService {
  final String _resourceUri = 'nh/tools';
  ToolServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Tool>> fetchDetails() async {
    Map<String, dynamic> queryParameters = {"excludedetails": false};
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Tool.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchNames() async {
    Map<String, dynamic> queryParameters = {"excludedetails": true};
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<Tool> get({
    required String name,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Tool.fromJson(response);
  }
}
