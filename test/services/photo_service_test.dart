import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/services/implementations/photo_service.dart';
import 'package:nookipedia_flutter/src/services/photo_service.dart';
import 'package:nookipedia_flutter/src/types/common/index.dart';
import 'package:nookipedia_flutter/src/types/photos/index.dart';

import 'photo_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = 'nh/photos',
      name = "Ace's Photo",
      encodedName = "Ace's%20Photo";

  late PhotoService photoService;

  final photoJson = {
    "url": "https://nookipedia.com/wiki/Item:Ace's_Photo_(New_Horizons)",
    "name": "Ace's Photo",
    "category": "Photos",
    "hha_base": 351,
    "sell": 10,
    "customizable": true,
    "custom_kits": 1,
    "custom_body_part": "Frame",
    "interactable": true,
    "version_added": "2.0.0",
    "unlocked": true,
    "grid_width": 1.0,
    "grid_length": 1.0,
    "availability": [
      {"from": "Friendship", "note": ""}
    ],
    "buy": [],
    "variations": [
      {
        "variation": "Natural Wood",
        "image_url":
            "https://dodo.ac/np/images/b/b9/Ace%27s_Photo_%28Natural_Wood%29_NH_Icon.png",
        "colors": ["Blue", "Yellow"]
      },
      {
        "variation": "Dark Wood",
        "image_url":
            "https://dodo.ac/np/images/d/d7/Ace%27s_Photo_%28Dark_Wood%29_NH_Icon.png",
        "colors": ["Blue", "Yellow"]
      },
      {
        "variation": "Pastel",
        "image_url":
            "https://dodo.ac/np/images/5/5a/Ace%27s_Photo_%28Pastel%29_NH_Icon.png",
        "colors": ["Blue", "Yellow"]
      },
      {
        "variation": "White",
        "image_url":
            "https://dodo.ac/np/images/2/2b/Ace%27s_Photo_%28White%29_NH_Icon.png",
        "colors": ["Blue", "Yellow"]
      },
      {
        "variation": "Pop",
        "image_url":
            "https://dodo.ac/np/images/9/99/Ace%27s_Photo_%28Pop%29_NH_Icon.png",
        "colors": ["Blue", "Yellow"]
      },
      {
        "variation": "Colorful",
        "image_url":
            "https://dodo.ac/np/images/3/36/Ace%27s_Photo_%28Colorful%29_NH_Icon.png",
        "colors": ["Blue", "Yellow"]
      },
      {
        "variation": "Silver",
        "image_url":
            "https://dodo.ac/np/images/5/57/Ace%27s_Photo_%28Silver%29_NH_Icon.png",
        "colors": ["Blue", "Yellow"]
      },
      {
        "variation": "Gold",
        "image_url":
            "https://dodo.ac/np/images/4/49/Ace%27s_Photo_%28Gold%29_NH_Icon.png",
        "colors": ["Blue", "Yellow"]
      }
    ]
  };

  const photo = Photo(
    "https://nookipedia.com/wiki/Item:Ace's_Photo_(New_Horizons)",
    "Ace's Photo",
    PhotoCategory.photo,
    351,
    10,
    true,
    1,
    "Frame",
    true,
    "2.0.0",
    true,
    1.0,
    1.0,
    [
      Availability(
        "Friendship",
        "",
      ),
    ],
    [],
    [
      PhotoVariation(
        "Natural Wood",
        "https://dodo.ac/np/images/b/b9/Ace%27s_Photo_%28Natural_Wood%29_NH_Icon.png",
        ["Blue", "Yellow"],
      ),
      PhotoVariation(
        "Dark Wood",
        "https://dodo.ac/np/images/d/d7/Ace%27s_Photo_%28Dark_Wood%29_NH_Icon.png",
        ["Blue", "Yellow"],
      ),
      PhotoVariation(
        "Pastel",
        "https://dodo.ac/np/images/5/5a/Ace%27s_Photo_%28Pastel%29_NH_Icon.png",
        ["Blue", "Yellow"],
      ),
      PhotoVariation(
        "White",
        "https://dodo.ac/np/images/2/2b/Ace%27s_Photo_%28White%29_NH_Icon.png",
        ["Blue", "Yellow"],
      ),
      PhotoVariation(
        "Pop",
        "https://dodo.ac/np/images/9/99/Ace%27s_Photo_%28Pop%29_NH_Icon.png",
        ["Blue", "Yellow"],
      ),
      PhotoVariation(
        "Colorful",
        "https://dodo.ac/np/images/3/36/Ace%27s_Photo_%28Colorful%29_NH_Icon.png",
        ["Blue", "Yellow"],
      ),
      PhotoVariation(
        "Silver",
        "https://dodo.ac/np/images/5/57/Ace%27s_Photo_%28Silver%29_NH_Icon.png",
        ["Blue", "Yellow"],
      ),
      PhotoVariation(
        "Gold",
        "https://dodo.ac/np/images/4/49/Ace%27s_Photo_%28Gold%29_NH_Icon.png",
        ["Blue", "Yellow"],
      ),
    ],
  );

  setUpAll(() {
    photoService = PhotoServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Photo data with details', () {
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
            photoJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await photoService.fetchDetails(), [photo]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": false},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetching Photo names', () {
    test('shouldd return results as expected', () async {
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

      expect(await photoService.fetchNames(), [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single photo', () {
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
          data: photoJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await photoService.get(name: name),
        photo,
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
          data: photoJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await photoService.get(
          name: name,
          thumbSize: 100,
        ),
        photo,
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
