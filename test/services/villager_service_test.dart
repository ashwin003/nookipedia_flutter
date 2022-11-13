import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/services/implementations/index.dart';
import 'package:nookipedia_flutter/src/services/index.dart';
import 'package:nookipedia_flutter/src/types/villagers/index.dart';

import 'villager_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'villagers',
      name = "Ace";

  late VillagerService villagerService;

  final villagerJson = [
    {
      "name": "Ace",
      "url": "https://nookipedia.com/wiki/Ace",
      "alt_name": "",
      "title_color": "0961f6",
      "text_color": "fffce9",
      "id": "brd09",
      "image_url": "https://dodo.ac/np/images/9/91/Ace_amiibo.png",
      "species": "Bird",
      "personality": "Jock",
      "gender": "Male",
      "birthday_month": "August",
      "birthday_day": "11",
      "sign": "Leo",
      "quote":
          "If you love something, let it go. Then chase it down. What were you thinking?",
      "phrase": "ace",
      "clothing": "Kung-Fu Tee",
      "islander": false,
      "debut": "DNM",
      "prev_phrases": [],
      "nh_details": null,
      "appearances": ["DNM", "AC", "E_PLUS", "NH", "PC"]
    }
  ];

  const villager = Villager(
    "Ace",
    "https://nookipedia.com/wiki/Ace",
    "",
    "0961f6",
    "fffce9",
    "brd09",
    "https://dodo.ac/np/images/9/91/Ace_amiibo.png",
    Species.bird,
    Personality.jock,
    Gender.male,
    "August",
    "11",
    Zodiac.leo,
    "If you love something, let it go. Then chase it down. What were you thinking?",
    "ace",
    "Kung-Fu Tee",
    false,
    "DNM",
    [],
    null,
    ["DNM", "AC", "E_PLUS", "NH", "PC"],
  );

  setUpAll(() {
    villagerService = VillagerServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Villager data with details', (() {
    test('without NH Details', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: villagerJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await villagerService.fetchDetails(), [villager]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with NH Details', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"nhdetails": true},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: villagerJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      var villagers = await villagerService.fetchDetails(nhDetails: true);
      expect(villagers, [villager]);
      expect(villagers[0].newHorizonDetails, villager.newHorizonDetails);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"nhdetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('for a specific species', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"species": "ostrich"},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: villagerJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await villagerService.fetchDetails(species: Species.ostrich),
          [villager]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"species": "ostrich"},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  }));

  group('Fetchinng Villager names', () {
    test('without filter criteria', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": true},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [name],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await villagerService.fetchNames(), [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with filter criteria - species', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {
            "species": "ostrich",
            "excludedetails": true,
          },
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [name],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await villagerService.fetchNames(
            species: Species.ostrich,
          ),
          [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {
            "species": "ostrich",
            "excludedetails": true,
          },
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });
}
