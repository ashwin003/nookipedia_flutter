import '../../types/photos/index.dart';
import '../photo_service.dart';
import 'api_service.dart';

class PhotoServiceImpl extends ApiService implements PhotoService {
  final String _resourceUri = 'nh/photos';
  PhotoServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Photo>> fetchDetails() async {
    Map<String, dynamic> queryParameters = {
      "excludedetails": false,
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Photo.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchNames() async {
    Map<String, dynamic> queryParameters = {
      "excludedetails": true,
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<Photo> get({
    required String name,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Photo.fromJson(response);
  }
}
