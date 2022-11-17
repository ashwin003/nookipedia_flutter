import 'package:nookipedia_flutter/src/types/critter/critter.dart';

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
  Future<List<SeaCreature>> fetchDetails({int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => SeaCreature.fromJson(e, super.version)).toList();
  }

  @override
  Future<List<String>> fetchNames({int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
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

  @override
  Future<SeaCreatureByMonth> fetchDetailsForMonth(
      {required String month, int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "month": month,
      "thumbsize": thumbSize,
    };
    var response = await processObjectRequest(_resourceUri, queryParameters);
    return SeaCreatureByMonth.fromJson(response, version);
  }

  @override
  Future<CritterByMonth> fetchNamesForMonth(
      {required String month, int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "month": month,
      "thumbsize": thumbSize,
      "excludedetails": true
    };
    var response = await processObjectRequest(_resourceUri, queryParameters);
    return CritterByMonth.fromJson(response);
  }
}
