import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/services/implementations/recipe_service.dart';
import 'package:nookipedia_flutter/src/services/recipe_service.dart';
import 'package:nookipedia_flutter/src/types/common/index.dart';
import 'package:nookipedia_flutter/src/types/recipes/index.dart';

import 'recipe_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'nh/recipes',
      name = "Acorn Pochette",
      encodedName = "Acorn%20Pochette";

  late RecipeService recipeService;

  final recipeJson = {
    "url": "https://nookipedia.com/wiki/Item:Acorn_Pochette_(New_Horizons)",
    "name": "Acorn Pochette",
    "image_url":
        "https://dodo.ac/np/images/d/de/Acorn_Pochette_NH_DIY_Icon.png",
    "serial_id": 2982,
    "sell": 200,
    "recipes_to_unlock": 0,
    "materials": [
      {"name": "Acorn", "count": 6}
    ],
    "availability": [
      {"from": "Balloons", "note": "fall"}
    ],
    "buy": []
  };

  const recipe = Recipe(
      "https://nookipedia.com/wiki/Item:Acorn_Pochette_(New_Horizons)",
      "Acorn Pochette",
      "https://dodo.ac/np/images/d/de/Acorn_Pochette_NH_DIY_Icon.png",
      2982,
      200,
      0, [
    Material(
      "Acorn",
      6,
    ),
  ], [
    Availability(
      "Balloons",
      "fall",
    ),
  ], []);

  setUpAll(() {
    recipeService = RecipeServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Recipe data with details', () {
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
            recipeJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await recipeService.fetchDetails(), [recipe]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetching Recipe data without details', () {
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

      expect(await recipeService.fetchNames(), [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single recipe', () {
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
          data: recipeJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await recipeService.get(
          name: name,
        ),
        recipe,
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
          data: recipeJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await recipeService.get(
          name: name,
          thumbSize: 100,
        ),
        recipe,
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
