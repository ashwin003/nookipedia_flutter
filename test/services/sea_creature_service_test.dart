import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/exceptions/index.dart';
import 'package:nookipedia_flutter/src/extensions/string_extensions.dart';
import 'package:nookipedia_flutter/src/services/implementations/sea_creature_service.dart';
import 'package:nookipedia_flutter/src/services/sea_creature_service.dart';
import 'package:nookipedia_flutter/src/types/critter/availability.dart';
import 'package:nookipedia_flutter/src/types/critter/month.dart';
import 'package:nookipedia_flutter/src/types/critter/rarity.dart';
import 'package:nookipedia_flutter/src/types/critter/sea.dart';

import 'sea_creature_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "1.5.0",
      resourceUrl = 'nh/sea',
      name = 'Abalone',
      encodedName = 'Abalone';

  late SeaCreatureService seaCreatureService;

  final errorJson = {
    "title": "Some title.",
    "details": "Some Message",
  };

  final seaCreatureJson = {
    "name": "Abalone",
    "url": "https://nookipedia.com/wiki/Abalone",
    "number": 17,
    "image_url": "https://dodo.ac/np/images/0/04/Abalone_NH_Icon.png",
    "render_url": "https://dodo.ac/np/images/f/fd/Abalone_NH.png",
    "shadow_size": "Medium",
    "shadow_movement": "Medium",
    "rarity": "",
    "total_catch": 20,
    "sell_nook": 2000,
    "tank_width": 1.0,
    "tank_length": 1.0,
    "catchphrases": ["I got an abalone! Why do I want a sandwich now?"],
    "north": {
      "availability_array": [
        {"months": "Jun – Jan", "time": "4 PM – 9 AM"}
      ],
      "times_by_month": {
        "1": "4 PM – 9 AM",
        "2": "NA",
        "3": "NA",
        "4": "NA",
        "5": "NA",
        "6": "4 PM – 9 AM",
        "7": "4 PM – 9 AM",
        "8": "4 PM – 9 AM",
        "9": "4 PM – 9 AM",
        "10": "4 PM – 9 AM",
        "11": "4 PM – 9 AM",
        "12": "4 PM – 9 AM"
      },
      "months": "Jun – Jan",
      "months_array": [1, 6, 7, 8, 9, 10, 11, 12]
    },
    "south": {
      "availability_array": [
        {"months": "Dec – Jul", "time": "4 PM – 9 AM"}
      ],
      "times_by_month": {
        "1": "4 PM – 9 AM",
        "2": "4 PM – 9 AM",
        "3": "4 PM – 9 AM",
        "4": "4 PM – 9 AM",
        "5": "4 PM – 9 AM",
        "6": "4 PM – 9 AM",
        "7": "4 PM – 9 AM",
        "8": "NA",
        "9": "NA",
        "10": "NA",
        "11": "NA",
        "12": "4 PM – 9 AM"
      },
      "months": "Dec – Jul",
      "months_array": [1, 2, 3, 4, 5, 6, 7, 12]
    }
  };

  CritterMonthlyAvailability getCritterMonthlyAvailability(int month) {
    return CritterMonthlyAvailability(
        monthNumber: month,
        monthName: Month.values[month - 1].name.toCapitalized(),
        hours: const [
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8
        ],
        hourString: "4 PM – 9 AM");
  }

  final north = CritterAvailability(
        availableAllYear: false,
        availability: [1, 6, 7, 8, 9, 10, 11, 12]
            .map((index) => getCritterMonthlyAvailability(index))
            .toList(),
      ),
      south = CritterAvailability(
        availableAllYear: false,
        availability: [1, 2, 3, 4, 5, 6, 7, 12]
            .map((index) => getCritterMonthlyAvailability(index))
            .toList(),
      );

  final seaCreature = SeaCreature(
    number: 17,
    name: "Abalone",
    url: "https://nookipedia.com/wiki/Abalone",
    imageUrl: "https://dodo.ac/np/images/0/04/Abalone_NH_Icon.png",
    renderUrl: "https://dodo.ac/np/images/f/fd/Abalone_NH.png",
    catchphrases: const [
      "I got an abalone! Why do I want a sandwich now?",
    ],
    rarity: Rarity.unspecified,
    totalCatch: 20,
    sellNook: 2000,
    tankWidth: 1.0,
    tankLength: 1.0,
    north: north,
    south: south,
  );

  setUpAll(() {
    seaCreatureService = SeaCreatureServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetch Sea Creature data with details', () {
    test('without filter criteria', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            seaCreatureJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await seaCreatureService.fetchDetails(), [seaCreature]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with filter criteria', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {
            "month": "january",
          },
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            seaCreatureJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await seaCreatureService.fetchDetails(
            month: "january",
          ),
          [seaCreature]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {
            "month": "january",
          },
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('Should throw the expected exception when the network call fails',
        () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {
            "month": "january",
          },
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
        () async => await seaCreatureService.fetchDetails(
          month: "january",
        ),
        throwsA(
          isA<NookipediaException>(),
        ),
      );

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {
            "month": "january",
          },
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch Sea Creature names', () {
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

      expect(await seaCreatureService.fetchNames(), [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with filter criteria', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {
            "month": "january",
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
          await seaCreatureService.fetchNames(
            month: "january",
          ),
          [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {
            "month": "january",
            "excludedetails": true,
          },
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single Sea Creature', () {
    test('without filter criteria', () async {
      when(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: seaCreatureJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await seaCreatureService.get(name: name),
        seaCreature,
      );

      verify(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });
}
