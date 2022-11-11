import '../../types/villagers/index.dart';
import '../villager_service.dart';
import 'api_service.dart';

class VillagerServiceImpl extends ApiService implements VillagerService {
  final String _resourceUri = 'villagers';
  VillagerServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<String>> fetchNames({
    String? name,
    Species? species,
    Personality? personality,
    List<String>? game,
    String? birthMonth,
    String? birthDay,
    bool? nhDetails,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "name": name,
      "species": species?.name,
      "personality": personality,
      "game": game,
      "birthmonth": birthMonth,
      "birthday": birthDay,
      "nhdetails": nhDetails,
      "thumbsize": thumbSize,
      "excludedetails": true
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return List<String>.from(response);
  }

  @override
  Future<List<Villager>> fetchDetails({
    String? name,
    Species? species,
    Personality? personality,
    List<String>? game,
    String? birthMonth,
    String? birthDay,
    bool? nhDetails,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "name": name,
      "species": species?.name,
      "personality": personality,
      "game": game,
      "birthmonth": birthMonth,
      "birthday": birthDay,
      "nhdetails": nhDetails,
      "thumbsize": thumbSize
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Villager.fromJson(e)).toList();
  }
}
