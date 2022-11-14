import '../../types/museum/fossil.dart';

import '../fossil_service.dart';
import 'api_service.dart';

class FossilServiceImpl extends ApiService implements FossilService {
  FossilServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Fossil>> fetch({int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var response =
        await processListRequest('nh/fossils/individuals', queryParameters);
    return response.map((e) => Fossil.fromJson(e)).toList();
  }

  @override
  Future<List<FossilGroup>> fetchGroups(
      {bool? includeFossils, int? thumbSize}) async {
    includeFossils = includeFossils ?? false;
    final resourceUri = includeFossils ? 'nh/fossils/all' : 'nh/fossils/groups';
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var response = await processListRequest(resourceUri, queryParameters);
    return response.map((e) => FossilGroup.fromJson(e)).toList();
  }

  @override
  Future<Fossil> get({
    required String name,
    int? thumbSize,
  }) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "nh/fossils/individuals/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Fossil.fromJson(response);
  }

  @override
  Future<FossilGroup> getGroup(
      {required String name, bool? includeFossils, int? thumbSize}) async {
    includeFossils = includeFossils ?? false;
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var baseResourceUri =
        includeFossils ? 'nh/fossils/all' : 'nh/fossils/groups';
    var resourceUri = "$baseResourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return FossilGroup.fromJson(response);
  }
}
