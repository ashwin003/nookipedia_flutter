import 'package:nookipedia_flutter/src/types/recipes/recipe.dart';

import '../recipe_service.dart';
import 'api_service.dart';

class RecipeServiceImpl extends ApiService implements RecipeService {
  final String _resourceUri = 'nh/recipes';
  RecipeServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Recipe>> fetchDetails({
    String? material,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "material": material,
      "thumbSize": thumbSize
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Recipe.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchNames({
    String? material,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "material": material,
      "thumbSize": thumbSize,
      "excludedetails": true
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<Recipe> get({
    required String name,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Recipe.fromJson(response);
  }
}
