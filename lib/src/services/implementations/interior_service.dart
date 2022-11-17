import '../../types/interior/index.dart';
import '../interior_service.dart';
import 'api_service.dart';

class InteriorServiceImpl extends ApiService implements InteriorService {
  final String _resourceUri = 'nh/interior';
  InteriorServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Interior>> fetchDetails({
    List<String>? colors,
  }) async {
    Map<String, dynamic> queryParameters = {"color": colors};
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Interior.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchNames({
    List<String>? colors,
  }) async {
    Map<String, dynamic> queryParameters = {
      "color": colors,
      "excludedetails": true
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<Interior> get({
    required String name,
    List<String>? colors,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "color": colors,
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Interior.fromJson(response);
  }
}
