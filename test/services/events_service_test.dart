import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/exceptions/index.dart';
import 'package:nookipedia_flutter/src/services/events_service.dart';
import 'package:nookipedia_flutter/src/services/implementations/index.dart';
import 'package:nookipedia_flutter/src/types/events/index.dart';

import 'events_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'nh/events';

  late EventsService eventsService;

  final errorJson = {
    "title": "Some title.",
    "details": "Some Message",
  };

  final eventsJson = [
    {
      "event": "Bob's birthday",
      "date": "2022-01-01",
      "type": "Birthday",
      "url": "https://nookipedia.com/wiki/Bob"
    },
    {
      "event": "New Year's Day",
      "date": "2022-01-01",
      "type": "Event",
      "url": "https://nookipedia.com/wiki/New_Year's_Day"
    },
    {
      "event": "Bug-Off (Southern Hemisphere)",
      "date": "2022-02-19",
      "type": "Event",
      "url": "https://nookipedia.com/wiki/Bug-Off"
    },
    {
      "event": "Last day of winter (Northern Hemisphere)",
      "date": "2022-02-24",
      "type": "Season",
      "url": "https://nookipedia.com/wiki/Winter"
    }
  ];

  final events = [
    AnimalCrossingEvent(
      "Bob's birthday",
      DateTime.parse("2022-01-01"),
      EventType.birthday,
      "https://nookipedia.com/wiki/Bob",
    ),
    AnimalCrossingEvent(
      "New Year's Day",
      DateTime.parse("2022-01-01"),
      EventType.event,
      "https://nookipedia.com/wiki/New_Year's_Day",
    ),
    AnimalCrossingEvent(
      "Bug-Off (Southern Hemisphere)",
      DateTime.parse("2022-02-19"),
      EventType.event,
      "https://nookipedia.com/wiki/Bug-Off",
    ),
    AnimalCrossingEvent(
      "Last day of winter (Northern Hemisphere)",
      DateTime.parse("2022-02-24"),
      EventType.season,
      "https://nookipedia.com/wiki/New_Year's_Day",
    )
  ];

  setUpAll(() {
    eventsService = EventsServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Should fetch the events as expected', () {
    test('without filter criteria', () async {
      when(dio.get(resourceUrl,
              queryParameters: {}, options: anyNamed('options')))
          .thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: eventsJson,
          requestOptions: RequestOptions(path: resourceUrl),
        ),
      );

      var actualEvents = await eventsService.fetchDetails();
      expect(actualEvents, events);
      expect(actualEvents.map((e) => e.hemisphere), [
        Hemisphere.both,
        Hemisphere.both,
        Hemisphere.southern,
        Hemisphere.northern,
      ]);

      verify(dio.get(resourceUrl,
              queryParameters: {}, options: anyNamed('options')))
          .called(1);
    });

    test('with filter criteria', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"month": "October"},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: eventsJson,
          requestOptions: RequestOptions(path: resourceUrl),
        ),
      );

      expect(await eventsService.fetchDetails(month: "October"), events);

      verify(dio.get(resourceUrl,
              queryParameters: {"month": "October"},
              options: anyNamed('options')))
          .called(1);
    });

    test('Should throw the expected exception when the network call fails',
        () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"month": "October"},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 400,
          data: errorJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
        () async => await eventsService.fetchDetails(month: "October"),
        throwsA(
          isA<NookipediaException>(),
        ),
      );

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"month": "October"},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });
}
