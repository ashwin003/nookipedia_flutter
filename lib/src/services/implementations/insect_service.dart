import '../../types/critter/insect.dart';
import '../insect_service.dart';
import 'api_service.dart';

class InsectServiceImpl extends ApiService implements InsectService {
  final String _resourceUri = 'nh/bugs';
  InsectServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<Insect>> fetchDetails({String? month, int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "month": month,
      "thumbsize": thumbSize,
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => Insect.fromJson(e, super.version)).toList();
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
  Future<Insect> get({required String name, int? thumbSize}) async {
    Map<String, dynamic> queryParameters = {
      "thumbsize": thumbSize,
    };
    var resourceUri = "$_resourceUri/${Uri.encodeComponent(name)}";
    var response = await processObjectRequest(resourceUri, queryParameters);
    return Insect.fromJson(response, super.version);
  }
}
