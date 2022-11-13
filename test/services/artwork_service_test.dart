import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/index.dart';
import 'package:nookipedia_flutter/src/services/implementations/index.dart';

import 'artwork_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'nh/art',
      name = 'Academic Painting',
      encodedName = 'Academic%20Painting';

  late ArtworkService artworkService;

  final errorJson = {
    "title": "Some title.",
    "details": "Some Message",
  };

  final artworkJson = {
    "name": "Academic Painting",
    "url": "https://nookipedia.com/wiki/Academic_Painting",
    "image_url": "https://dodo.ac/np/images/e/e8/Academic_Painting_NH_Icon.png",
    "has_fake": true,
    "fake_image_url":
        "https://dodo.ac/np/images/4/46/Academic_Painting_%28Fake%29_NH_Icon.png",
    "art_name": "Vitruvian Man",
    "author": "Leonardo da Vinci",
    "year": "circa 1487",
    "art_style": "Pen and ink on paper",
    "description":
        "This drawing is based on the \"ideal\" human-body ratio, as stated in \"De architectura.\" \"De architectura\" was a treatise by Vitruvius, an architect from the early 1st century BCE.",
    "buy": 4980,
    "sell": 1245,
    "availability": "Jolly Redd's Treasure Trawler",
    "authenticity":
        "In the forgery, there is a coffee stain in the top right corner. The forgery also has a key taped to the back of the canvas. If there is no stain and key, it is genuine.",
    "width": 1.0,
    "length": 1.0
  };

  const artwork = Artwork(
    "Academic Painting",
    "https://nookipedia.com/wiki/Academic_Painting",
    "https://dodo.ac/np/images/e/e8/Academic_Painting_NH_Icon.png",
    true,
    "https://dodo.ac/np/images/4/46/Academic_Painting_%28Fake%29_NH_Icon.png",
    "Vitruvian Man",
    "Leonardo da Vinci",
    "circa 1487",
    "Pen and ink on paper",
    "This drawing is based on the \"ideal\" human-body ratio, as stated in \"De architectura.\" \"De architectura\" was a treatise by Vitruvius, an architect from the early 1st century BCE.",
    4980,
    1245,
    "Jolly Redd's Treasure Trawler",
    "In the forgery, there is a coffee stain in the top right corner. The forgery also has a key taped to the back of the canvas. If there is no stain and key, it is genuine.",
    1.0,
    1.0,
  );

  setUpAll(() {
    artworkService = ArtworkServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Artwork data with details', () {
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
            artworkJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await artworkService.fetchDetails(), [artwork]);

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
          queryParameters: {"hasfake": false},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            artworkJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await artworkService.fetchDetails(hasFake: false), [artwork]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"hasfake": false},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('should throw the expected exception when the network call fails',
        () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"hasfake": false},
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
        () async => await artworkService.fetchDetails(hasFake: false),
        throwsA(
          isA<NookipediaException>(),
        ),
      );

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"hasfake": false},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetching Artwork names', () {
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

      expect(await artworkService.fetchNames(), [name]);

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
          queryParameters: {"hasfake": false, "excludedetails": true},
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

      expect(await artworkService.fetchNames(hasFake: false), [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"hasfake": false, "excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('should throw the expected exception when the network call fails',
        () async {
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"hasfake": false, "excludedetails": true},
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
        () async => await artworkService.fetchNames(hasFake: false),
        throwsA(
          isA<NookipediaException>(),
        ),
      );

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"hasfake": false, "excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single artwork', () {
    test('should return expected result', () async {
      when(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: artworkJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(await artworkService.get(name: name), artwork);

      verify(
        dio.get(
          '$resourceUrl/$encodedName',
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('should throw the expected exception when the network call fails',
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
        () async => await artworkService.get(
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
