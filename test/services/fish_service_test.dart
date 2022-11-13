import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/exceptions/index.dart';
import 'package:nookipedia_flutter/src/extensions/string_extensions.dart';
import 'package:nookipedia_flutter/src/services/fish_service.dart';
import 'package:nookipedia_flutter/src/services/implementations/fish_service.dart';
import 'package:nookipedia_flutter/src/types/critter/availability.dart';
import 'package:nookipedia_flutter/src/types/critter/fish.dart';
import 'package:nookipedia_flutter/src/types/critter/month.dart';
import 'package:nookipedia_flutter/src/types/critter/rarity.dart';

import 'fish_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "1.5.0",
      resourceUrl = 'nh/fish',
      name = 'Anchovy',
      encodedName = 'Anchovy';

  late FishService fishService;

  final errorJson = {
    "title": "Some title.",
    "details": "Some Message",
  };

  final fishJson = {
    "name": "Anchovy",
    "url": "https://nookipedia.com/wiki/Anchovy_(fish)",
    "number": 56,
    "image_url":
        "https://dodo.ac/np/images/7/7f/Anchovy_%28Fish%29_NH_Icon.png",
    "render_url": "https://dodo.ac/np/images/1/19/Anchovy_%28Fish%29_NH.png",
    "location": "Sea",
    "shadow_size": "Small",
    "rarity": "",
    "total_catch": 0,
    "sell_nook": 200,
    "sell_cj": 300,
    "tank_width": 1.0,
    "tank_length": 1.0,
    "catchphrases": ["I caught an anchovy! Stay away from my pizza!"],
    "north": {
      "availability_array": [
        {"months": "All year", "time": "4 AM – 9 PM"}
      ],
      "times_by_month": {
        "1": "4 AM – 9 PM",
        "2": "4 AM – 9 PM",
        "3": "4 AM – 9 PM",
        "4": "4 AM – 9 PM",
        "5": "4 AM – 9 PM",
        "6": "4 AM – 9 PM",
        "7": "4 AM – 9 PM",
        "8": "4 AM – 9 PM",
        "9": "4 AM – 9 PM",
        "10": "4 AM – 9 PM",
        "11": "4 AM – 9 PM",
        "12": "4 AM – 9 PM"
      },
      "months": "All year",
      "months_array": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    },
    "south": {
      "availability_array": [
        {"months": "All year", "time": "4 AM – 9 PM"}
      ],
      "times_by_month": {
        "1": "4 AM – 9 PM",
        "2": "4 AM – 9 PM",
        "3": "4 AM – 9 PM",
        "4": "4 AM – 9 PM",
        "5": "4 AM – 9 PM",
        "6": "4 AM – 9 PM",
        "7": "4 AM – 9 PM",
        "8": "4 AM – 9 PM",
        "9": "4 AM – 9 PM",
        "10": "4 AM – 9 PM",
        "11": "4 AM – 9 PM",
        "12": "4 AM – 9 PM"
      },
      "months": "All year",
      "months_array": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    }
  };

  CritterMonthlyAvailability getCritterMonthlyAvailability(int month) {
    return CritterMonthlyAvailability(
        monthNumber: month + 1,
        monthName: Month.values[month].name.toCapitalized(),
        hours: const [
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20
        ],
        hourString: "4 AM – 9 PM");
  }

  final north = CritterAvailability(
        availableAllYear: true,
        availability:
            List.generate(12, (index) => getCritterMonthlyAvailability(index)),
      ),
      south = CritterAvailability(
        availableAllYear: true,
        availability:
            List.generate(12, (index) => getCritterMonthlyAvailability(index)),
      );

  final fish = Fish(
    number: 56,
    name: "Anchovy",
    url: "https://nookipedia.com/wiki/Anchovy_(fish)",
    imageUrl: "https://dodo.ac/np/images/7/7f/Anchovy_%28Fish%29_NH_Icon.png",
    renderUrl: "https://dodo.ac/np/images/1/19/Anchovy_%28Fish%29_NH.png",
    catchphrases: const ["I caught an anchovy! Stay away from my pizza!"],
    location: "Sea",
    rarity: Rarity.unspecified,
    totalCatch: 0,
    sellNook: 200,
    tankWidth: 1.0,
    tankLength: 1.0,
    north: north,
    south: south,
    sellCJ: 300,
  );

  setUpAll(() {
    fishService = FishServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetch Fish data with details', () {
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
            fishJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fishService.fetchDetails(), [fish]);

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
            fishJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await fishService.fetchDetails(
            month: "january",
          ),
          [fish]);

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

    test('should throw the expected exception when the network call fails',
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
        () async => await fishService.fetchDetails(
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

  group('Fetch Fish names', () {
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

      expect(await fishService.fetchNames(), [name]);

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
          await fishService.fetchNames(
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

  group('Fetch single Fish', () {
    test('without specifying a thumb size', () async {
      when(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: fishJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await fishService.get(name: name),
        fish,
      );

      verify(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with a specific thumb size', () async {
      when(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: fishJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await fishService.get(
          name: name,
          thumbSize: 100,
        ),
        fish,
      );

      verify(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });
}
