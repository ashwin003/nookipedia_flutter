import '../../types/events/event.dart';
import '../events_service.dart';
import 'api_service.dart';

class EventsServiceImpl extends ApiService implements EventsService {
  final String _resourceUri = 'nh/events';
  EventsServiceImpl({
    required super.apiKey,
    required super.version,
    required super.dio,
  });

  @override
  Future<List<AnimalCrossingEvent>> fetchDetails({
    String? date,
    String? year,
    String? month,
    int? day,
  }) async {
    Map<String, dynamic> queryParameters = {
      "date": date,
      "year": year,
      "month": month,
      "day": day,
    };
    var response = await processListRequest(_resourceUri, queryParameters);
    return response.map((e) => AnimalCrossingEvent.fromJson(e)).toList();
  }
}
