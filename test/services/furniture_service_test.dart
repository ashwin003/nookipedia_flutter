import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/exceptions/index.dart';
import 'package:nookipedia_flutter/src/services/furniture_service.dart';
import 'package:nookipedia_flutter/src/services/implementations/index.dart';
import 'package:nookipedia_flutter/src/types/common/index.dart';
import 'package:nookipedia_flutter/src/types/furniture/index.dart';

import 'furniture_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'nh/furniture',
      name = '1-Up Mushroom',
      encodedName = '1-Up%20Mushroom';

  late FurnitureService furnitureService;

  final errorJson = {
    "title": "Some title.",
    "details": "Some Message",
  };

  final furnitureJson = {
    "url": "https://nookipedia.com/wiki/Item:1-Up_Mushroom_(New_Horizons)",
    "name": "1-Up Mushroom",
    "category": "Miscellaneous",
    "item_series": "Mario",
    "item_set": "",
    "hha_category": "",
    "tag": "Mario",
    "hha_base": 201,
    "lucky": false,
    "lucky_season": "",
    "sell": 500,
    "variation_total": 0,
    "pattern_total": 0,
    "customizable": false,
    "custom_kits": 0,
    "custom_kit_type": "",
    "custom_body_part": "",
    "custom_pattern_part": "",
    "height": "7.390978",
    "door_decor": false,
    "version_added": "1.8.0",
    "unlocked": true,
    "notes": "",
    "grid_width": 1.0,
    "grid_length": 1.0,
    "themes": ["Fancy", "Child's Room"],
    "functions": ["Audio"],
    "availability": [
      {
        "from": "Nook Shopping",
        "note": "''Super Mario Bros.'' 35th anniversary"
      }
    ],
    "buy": [
      {"price": 2000, "currency": "Bells"}
    ],
    "variations": [
      {
        "variation": "",
        "pattern": "",
        "image_url": "https://dodo.ac/np/images/7/77/1-Up_Mushroom_NH_Icon.png",
        "colors": ["Green", "White"]
      }
    ]
  };

  const furniture = Furniture(
    "https://nookipedia.com/wiki/Item:1-Up_Mushroom_(New_Horizons)",
    "1-Up Mushroom",
    FurnitureCategory.miscellaneous,
    "Mario",
    "",
    "",
    "Mario",
    201,
    false,
    "",
    500,
    0,
    0,
    false,
    0,
    "",
    "",
    "",
    7.390978,
    false,
    "1.8.0",
    true,
    "",
    1.0,
    1.0,
    ["Fancy", "Child's Room"],
    [FurnitureFunction.audio],
    [Availability("Nook Shopping", "''Super Mario Bros.'' 35th anniversary")],
    [
      Price(
        2000,
        "Bells",
      )
    ],
    [
      FurnitureVariation(
        "",
        "",
        "https://dodo.ac/np/images/7/77/1-Up_Mushroom_NH_Icon.png",
        [
          "Green",
          "White",
        ],
      )
    ],
  );

  setUpAll(() {
    furnitureService = FurnitureServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Furniture data with details', () {
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
            furnitureJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await furnitureService.fetchDetails(), [furniture]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with filter criteria - colors', () async {
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
            furnitureJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await furnitureService.fetchDetails(
            colors: [
              "Aqua",
              "Beige",
            ],
          ),
          [furniture]);

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

    test('with filter criteria - category', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {
            "category": "Wall-mounted",
          },
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            furnitureJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await furnitureService.fetchDetails(
            category: FurnitureCategory.wallMounted,
          ),
          [furniture]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {
            "category": "Wall-mounted",
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
            "color": [
              "Aqua",
              "Beige",
            ],
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
        () async => await furnitureService.fetchDetails(
          colors: [
            "Aqua",
            "Beige",
          ],
        ),
        throwsA(
          isA<NookipediaException>(),
        ),
      );

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

  group('Fetching Furniture names', () {
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

      expect(await furnitureService.fetchNames(), [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with filter criteria - colors', () async {
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
          await furnitureService.fetchNames(
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

    test('with filter criteria - category', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"category": "Wall-mounted", "excludedetails": true},
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
          await furnitureService.fetchNames(
              category: FurnitureCategory.wallMounted),
          [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"category": "Wall-mounted", "excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single Furniture', () {
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
          data: furnitureJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await furnitureService.get(name: name),
        furniture,
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
          data: furnitureJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await furnitureService.get(
          name: name,
          thumbSize: 100,
        ),
        furniture,
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
