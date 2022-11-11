import '../../types/museum/artwork.dart';
import '../artwork_service.dart';
import 'api_service.dart';

class ArtworkServiceImpl extends ApiService implements ArtworkService {
  final String _resourceUri = 'nh/art';
  ArtworkServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Artwork>> fetchDetails({
    bool? hasFake,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "hasfake": hasFake,
      "thumbsize": thumbSize,
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Artwork.fromJson(e)).toList();
  }

  @override
  Future<List<String>> fetchNames({
    bool? hasFake,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "hasfake": hasFake,
      "thumbsize": thumbSize,
      "excludedetails": true
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<Artwork> get({
    required String name,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Artwork.fromJson(response);
  }
}
