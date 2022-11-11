import 'package:nookipedia_flutter/src/types/clothing/clothing.dart';

import 'package:nookipedia_flutter/src/types/clothing/index.dart';

import '../clothing_service.dart';
import 'api_service.dart';

class ClothingServiceImpl extends ApiService implements ClothingService {
  final String _resourceUri = 'nh/clothing';
  ClothingServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Clothing>> fetchDetails({
    ClothingCategory? category,
    List<String>? colors,
    List<String>? styles,
    String? labelTheme,
  }) async {
    Map<String, dynamic> queryParameters = {
      "category": category?.toValue(),
      "color": colors
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Clothing.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchNames({
    ClothingCategory? category,
    List<String>? colors,
    List<String>? styles,
    String? labelTheme,
  }) async {
    Map<String, dynamic> queryParameters = {
      "category": category?.toValue(),
      "color": colors,
      "excludedetails": true
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<Clothing> get({
    required String name,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Clothing.fromJson(response);
  }
}
