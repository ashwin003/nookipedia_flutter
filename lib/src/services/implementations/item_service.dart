import 'package:nookipedia_flutter/src/types/items/index.dart';

import '../item_service.dart';
import 'api_service.dart';

class ItemServiceImpl extends ApiService implements ItemService {
  final String _resourceUri = 'nh/items';
  ItemServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Item>> fetchDetails() async {
    Map<String, dynamic> queryParameters = {"excludedetails": false};
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Item.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchNames() async {
    Map<String, dynamic> queryParameters = {"excludedetails": true};
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<Item> get({
    required String name,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Item.fromJson(response);
  }
}
