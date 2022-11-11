import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/exceptions/index.dart';
import 'package:nookipedia_flutter/src/services/implementations/clothing_service.dart';
import 'package:nookipedia_flutter/src/services/index.dart';
import 'package:nookipedia_flutter/src/types/common/index.dart';
import 'package:nookipedia_flutter/src/types/clothing/index.dart';

import 'clothing_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'nh/clothing',
      name = "Academy Uniform",
      encodedName = "Academy%20Uniform";

  late ClothingService clothingService;

  final errorJson = {
    "title": "Some title.",
    "details": "Some Message",
  };

  final clothingJson = {
    "url": "https://nookipedia.com/wiki/Item:3D_Glasses_(New_Horizons)",
    "name": "3D Glasses",
    "category": "Accessories",
    "sell": 122,
    "variation_total": 2,
    "vill_equip": true,
    "seasonality": "All year",
    "version_added": "1.0.0",
    "unlocked": true,
    "notes": "",
    "label_themes": ["Party"],
    "styles": ["Active"],
    "availability": [
      {"from": "Able Sisters", "note": ""}
    ],
    "buy": [
      {"price": 490, "currency": "Bells"},
      {"price": 440, "currency": "Poki"}
    ],
    "variations": [
      {
        "variation": "White",
        "image_url":
            "https://dodo.ac/np/images/1/15/3D_Glasses_%28White%29_NH_Icon.png",
        "colors": ["Colorful", "White"]
      },
      {
        "variation": "Black",
        "image_url":
            "https://dodo.ac/np/images/2/28/3D_Glasses_%28Black%29_NH_Icon.png",
        "colors": ["Colorful", "Black"]
      }
    ]
  };

  final clothing = Clothing(
    "3D Glasses",
    "https://nookipedia.com/wiki/Item:3D_Glasses_(New_Horizons)",
    ClothingCategory.accessories,
    122,
    2,
    true,
    "All year",
    "1.0.0",
    true,
    "",
    ["Party"],
    ["Active"],
    [
      Availability(
        "Able Sisters",
        "",
      )
    ],
    [
      Price(
        490,
        "Bells",
      ),
      Price(
        440,
        "Poki",
      ),
    ],
    [
      ClothingVariation(
        "White",
        "https://dodo.ac/np/images/1/15/3D_Glasses_%28White%29_NH_Icon.png",
        [
          "Colorful",
          "White",
        ],
      ),
      ClothingVariation(
        "Black",
        "https://dodo.ac/np/images/2/28/3D_Glasses_%28Black%29_NH_Icon.png",
        [
          "Colorful",
          "Black",
        ],
      ),
    ],
  );

  setUpAll(() {
    clothingService = ClothingServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Clothing data without details', () {
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

      expect(await clothingService.fetchNames(), [name]);

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
          await clothingService.fetchNames(
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

    test('Should throw the expected exception when the network call fails',
        () async {
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
          statusCode: 400,
          data: errorJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
        () async => await clothingService.fetchNames(
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
            "excludedetails": true
          },
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single furniture', () {
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
          data: clothingJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await clothingService.get(name: name),
        clothing,
      );

      verify(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with filter criteria', () async {
      when(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: clothingJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await clothingService.get(
          name: name,
          thumbSize: 100,
        ),
        clothing,
      );

      verify(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('Should throw the expected exception when the network call fails',
        () async {
      when(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {"thumbsize": 100},
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
        () async => await clothingService.get(
          name: name,
          thumbSize: 100,
        ),
        throwsA(
          isA<NookipediaException>(),
        ),
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
