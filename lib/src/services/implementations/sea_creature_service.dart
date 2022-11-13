import '../../types/critter/sea.dart';
import '../sea_creature_service.dart';
import 'api_service.dart';

class SeaCreatureServiceImpl extends ApiService implements SeaCreatureService {
  final String _resourceUri = 'nh/sea';
  SeaCreatureServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<SeaCreature>> fetchDetails(
      {String? month, int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "month": month,
      "thumbsize": thumbSize,
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => SeaCreature.fromJson(e, super.version)).toList();
  }

  @override
  Future<List<String>> fetchNames({String? month, int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "month": month,
      "thumbsize": thumbSize,
      "excludedetails": true
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<SeaCreature> get({required String name, int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return SeaCreature.fromJson(response, super.version);
  }
}
