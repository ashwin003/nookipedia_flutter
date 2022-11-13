import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/exceptions/index.dart';
import 'package:nookipedia_flutter/src/extensions/string_extensions.dart';
import 'package:nookipedia_flutter/src/services/implementations/insect_service.dart';
import 'package:nookipedia_flutter/src/services/insect_service.dart';
import 'package:nookipedia_flutter/src/types/critter/availability.dart';
import 'package:nookipedia_flutter/src/types/critter/insect.dart';
import 'package:nookipedia_flutter/src/types/critter/month.dart';
import 'package:nookipedia_flutter/src/types/critter/rarity.dart';

import 'insect_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "1.5.0",
      resourceUrl = 'nh/bugs',
      name = 'Agrias Butterfly',
      encodedName = 'Agrias%20Butterfly';

  late InsectService insectService;

  final errorJson = {
    "title": "Some title.",
    "details": "Some Message",
  };

  final insectJson = {
    "name": "Agrias Butterfly",
    "url": "https://nookipedia.com/wiki/Agrias_Butterfly",
    "number": "10",
    "image_url": "https://dodo.ac/np/images/6/60/Agrias_Butterfly_NH_Icon.png",
    "render_url": "https://dodo.ac/np/images/d/db/Agrias_Butterfly_NH.png",
    "catchphrase":
        "I caught an agrias butterfly! I wonder if it finds me disagrias-able?",
    "catchphrase2": "",
    "location": "Flying near flowers",
    "rarity": "",
    "total_catch": "20",
    "sell_nook": "3000",
    "sell_flick": "4500",
    "tank_width": "1",
    "tank_length": "1",
    "time": "8 AM – 5 PM",
    "catchphrases": [
      "I caught an agrias butterfly! I wonder if it finds me disagrias-able?"
    ],
    "north": {
      "availability_array": [
        {"months": "Apr – Sep", "time": "8 AM – 5 PM"}
      ],
      "times_by_month": {
        "1": "NA",
        "2": "NA",
        "3": "NA",
        "4": "8 AM – 5 PM",
        "5": "8 AM – 5 PM",
        "6": "8 AM – 5 PM",
        "7": "8 AM – 5 PM",
        "8": "8 AM – 5 PM",
        "9": "8 AM – 5 PM",
        "10": "NA",
        "11": "NA",
        "12": "NA"
      },
      "months": "Apr – Sep",
      "months_array": ["4", "5", "6", "7", "8", "9"]
    },
    "south": {
      "availability_array": [
        {"months": "Oct – Mar", "time": "8 AM – 5 PM"}
      ],
      "times_by_month": {
        "1": "8 AM – 5 PM",
        "2": "8 AM – 5 PM",
        "3": "8 AM – 5 PM",
        "4": "NA",
        "5": "NA",
        "6": "NA",
        "7": "NA",
        "8": "NA",
        "9": "NA",
        "10": "8 AM – 5 PM",
        "11": "8 AM – 5 PM",
        "12": "8 AM – 5 PM"
      },
      "months": "Oct – Mar",
      "months_array": ["1", "2", "3", "10", "11", "12"]
    }
  };

  CritterMonthlyAvailability getCritterMonthlyAvailability(int month) {
    return CritterMonthlyAvailability(
      monthNumber: month,
      monthName: Month.values[month - 1].name.toCapitalized(),
      hours: const [
        8,
        9,
        10,
        11,
        12,
        13,
        14,
        15,
        16,
      ],
      hourString: "8 AM – 5 PM",
    );
  }

  final north = CritterAvailability(
        availableAllYear: false,
        availability: [4, 5, 6, 7, 8, 9]
            .map((index) => getCritterMonthlyAvailability(index))
            .toList(),
      ),
      south = CritterAvailability(
        availableAllYear: false,
        availability: [1, 2, 3, 10, 11, 12]
            .map((index) => getCritterMonthlyAvailability(index))
            .toList(),
      );

  final insect = Insect(
    number: 10,
    name: "Agrias Butterfly",
    url: "https://nookipedia.com/wiki/Agrias_Butterfly",
    imageUrl: "https://dodo.ac/np/images/6/60/Agrias_Butterfly_NH_Icon.png",
    renderUrl: "https://dodo.ac/np/images/d/db/Agrias_Butterfly_NH.png",
    catchphrases: const [
      "I caught an agrias butterfly! I wonder if it finds me disagrias-able?",
    ],
    location: "Flying near flowers",
    rarity: Rarity.unspecified,
    totalCatch: 20,
    sellNook: 3000,
    tankWidth: 1.0,
    tankLength: 1.0,
    north: north,
    south: south,
    sellFlick: 4500,
  );

  setUpAll(() {
    insectService = InsectServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetch Insect data with details', () {
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
            insectJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await insectService.fetchDetails(), [insect]);

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
            insectJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await insectService.fetchDetails(
            month: "january",
          ),
          [insect]);

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
        () async => await insectService.fetchDetails(
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

  group('Fetch Insect names', () {
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

      expect(await insectService.fetchNames(), [name]);

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
          await insectService.fetchNames(
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

  group('Fetch single Insect', () {
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
          data: insectJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await insectService.get(name: name),
        insect,
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
