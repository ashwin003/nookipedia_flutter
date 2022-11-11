import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/services/implementations/item_service.dart';
import 'package:nookipedia_flutter/src/services/item_service.dart';
import 'package:nookipedia_flutter/src/types/common/index.dart';
import 'package:nookipedia_flutter/src/types/items/index.dart';

import 'tool_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'nh/items',
      name = "Acorn",
      encodedName = "Acorn";

  late ItemService itemService;

  final itemJson = {
    "url": "https://nookipedia.com/wiki/Item:Acorn_(New_Horizons)",
    "name": "Acorn",
    "image_url": "https://dodo.ac/np/images/9/9f/Acorn_NH_Icon.png",
    "stack": 30,
    "hha_base": 0,
    "sell": 200,
    "is_fence": false,
    "material_type": "Tree",
    "material_seasonality": "Fall",
    "material_sort": 3,
    "material_name_sort": 0,
    "material_seasonality_sort": 3,
    "edible": false,
    "plant_type": "",
    "version_added": "1.0.0",
    "unlocked": true,
    "notes": "",
    "availability": [
      {"from": "Tree", "note": "Shaking"},
      {"from": "Cornimer", "note": ""}
    ],
    "buy": []
  };

  final item = Item(
      "https://nookipedia.com/wiki/Item:Acorn_(New_Horizons)",
      "Acorn",
      "https://dodo.ac/np/images/9/9f/Acorn_NH_Icon.png",
      30,
      0,
      200,
      false,
      "Tree",
      "Fall",
      3,
      0,
      3,
      false,
      "",
      "1.0.0",
      true,
      "", [
    Availability(
      "Nook's Cranny",
      "",
    ),
    Availability(
      "Crafting",
      "",
    ),
  ], []);

  setUpAll(() {
    itemService = ItemServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Item data with details', () {
    test('without filter criteria', () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": false},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            itemJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await itemService.fetchDetails(), [item]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": false},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetching Item data without details', () {
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

      expect(await itemService.fetchNames(), [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single item', () {
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
          data: itemJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await itemService.get(
          name: name,
        ),
        item,
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
          data: itemJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await itemService.get(
          name: name,
          thumbSize: 100,
        ),
        item,
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
