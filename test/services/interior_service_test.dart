import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/services/implementations/interior_service.dart';
import 'package:nookipedia_flutter/src/services/index.dart';
import 'package:nookipedia_flutter/src/types/common/index.dart';
import 'package:nookipedia_flutter/src/types/interior/index.dart';

import 'interior_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'nh/interior',
      name = "Abstract Wall",
      encodedName = "Abstract%20Wall";

  late InteriorService interiorService;

  final interiorJson = {
    "url": "https://nookipedia.com/wiki/Item:Abstract_Wall_(New_Horizons)",
    "name": "Abstract Wall",
    "image_url": "https://dodo.ac/np/images/2/2d/Abstract_Wall_NH_Icon.png",
    "category": "Wallpaper",
    "item_series": "",
    "item_set": "",
    "hha_category": "",
    "tag": "",
    "hha_base": 151,
    "sell": 390,
    "version_added": "1.0.0",
    "unlocked": true,
    "notes": "",
    "grid_width": "",
    "grid_length": "",
    "themes": ["Restaurant", "Facility"],
    "colors": ["White", "Colorful"],
    "availability": [
      {"from": "Nook's Cranny", "note": ""}
    ],
    "buy": [
      {"price": 1560, "currency": "Bells"},
      {"price": 1400, "currency": "Poki"}
    ]
  };

  const interior = Interior(
    "https://nookipedia.com/wiki/Item:Abstract_Wall_(New_Horizons)",
    "Abstract Wall",
    "https://dodo.ac/np/images/2/2d/Abstract_Wall_NH_Icon.png",
    InteriorCategory.wallpaper,
    "",
    "",
    "",
    "",
    151,
    390,
    "1.0.0",
    true,
    "",
    "",
    "",
    ["Restaurant", "Facility"],
    ["White", "Colorful"],
    [
      Availability(
        "Nook's Cranny",
        "",
      ),
    ],
    [
      Price(1560, "Bells"),
      Price(
        1400,
        "Poki",
      ),
    ],
  );

  setUpAll(() {
    interiorService = InteriorServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Interior item data with details', () {
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
            interiorJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await interiorService.fetchDetails(), [interior]);

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
            "color": [
              "Aqua",
              "Beige",
            ],
          },
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            interiorJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await interiorService.fetchDetails(
            colors: [
              "Aqua",
              "Beige",
            ],
          ),
          [interior]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {
            "color": [
              "Aqua",
              "Beige",
            ],
          },
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetching Interior item names', () {
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

      expect(await interiorService.fetchNames(), [name]);

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
            "color": [
              "Aqua",
              "Beige",
            ],
            "excludedetails": true
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
          await interiorService.fetchNames(
            colors: [
              "Aqua",
              "Beige",
            ],
          ),
          [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {
            "color": [
              "Aqua",
              "Beige",
            ],
            "excludedetails": true
          },
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single furniture', () {
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
          data: interiorJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await interiorService.get(
          name: name,
        ),
        interior,
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
          data: interiorJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await interiorService.get(
          name: name,
          thumbSize: 100,
        ),
        interior,
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
