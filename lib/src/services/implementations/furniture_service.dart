import '../../types/furniture/index.dart';
import '../furniture_service.dart';
import 'api_service.dart';

class FurnitureServiceImpl extends ApiService implements FurnitureService {
  final String _resourceUri = 'nh/furniture';
  FurnitureServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Furniture>> fetchDetails({
    FurnitureCategory? category,
    List<String>? colors,
  }) async {
    Map<String, dynamic> queryParameters = {
      "category": category?.toValue(),
      "color": colors
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Furniture.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchNames({
    FurnitureCategory? category,
    List<String>? colors,
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
  Future<Furniture> get({
    required String name,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Furniture.fromJson(response);
  }
}
