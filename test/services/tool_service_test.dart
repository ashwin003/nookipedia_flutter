import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/services/implementations/tool_service.dart';
import 'package:nookipedia_flutter/src/services/tool_service.dart';
import 'package:nookipedia_flutter/src/types/common/index.dart';
import 'package:nookipedia_flutter/src/types/tools/index.dart';

import 'tool_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "4.2.0",
      resourceUrl = "nh/tools",
      name = "Axe",
      encodedName = "Axe";

  late ToolService toolService;

  final toolJson = {
    "url": "https://nookipedia.com/wiki/Item:Axe_(New_Horizons)",
    "name": "Axe",
    "uses": "100",
    "hha_base": 0,
    "sell": 625,
    "customizable": false,
    "custom_kits": 0,
    "custom_body_part": "",
    "version_added": "1.0.0",
    "unlocked": true,
    "notes": "",
    "availability": [
      {"from": "Nook's Cranny", "note": ""},
      {"from": "Crafting", "note": ""}
    ],
    "buy": [
      {"price": 2500, "currency": "Bells"}
    ],
    "variations": [
      {
        "variation": "",
        "image_url": "https://dodo.ac/np/images/f/fa/Axe_NH_Icon.png"
      }
    ]
  };

  const tool = Tool(
    "https://nookipedia.com/wiki/Item:Axe_(New_Horizons)",
    "Axe",
    100,
    0,
    625,
    false,
    0,
    "",
    "1.0.0",
    true,
    "",
    [
      Availability(
        "Nook's Cranny",
        "",
      ),
      Availability(
        "Crafting",
        "",
      ),
    ],
    [
      Price(
        2500,
        "Bells",
      ),
    ],
    [
      ToolVariation("", "https://dodo.ac/np/images/f/fa/Axe_NH_Icon.png"),
    ],
  );

  setUpAll(() {
    toolService = ToolServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetching Tool data with details', () {
    test('should return results as expected', () async {
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
            toolJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await toolService.fetchDetails(), [tool]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": false},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetching Tool data without details', () {
    test('should return results as expected', () async {
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

      expect(await toolService.fetchNames(), [name]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"excludedetails": true},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch single tool', () {
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
          data: toolJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await toolService.get(
          name: name,
        ),
        tool,
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
          data: toolJson,
          requestOptions: RequestOptions(
            path: '$resourceUrl/$encodedName',
          ),
        ),
      );

      expect(
        await toolService.get(
          name: name,
          thumbSize: 100,
        ),
        tool,
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
