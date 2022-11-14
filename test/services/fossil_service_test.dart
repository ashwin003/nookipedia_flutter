import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nookipedia_flutter/src/services/fossil_service.dart';
import 'package:nookipedia_flutter/src/services/implementations/fossil_service.dart';
import 'package:nookipedia_flutter/src/types/museum/fossil.dart';

import 'fossil_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  const String apiKey = "SOME-KEY-HERE",
      version = "1.5.0",
      name = 'Acanthostega',
      encodedName = 'Acanthostega',
      groupName = 'Spinosaurus',
      encodedGroupName = 'Spinosaurus';

  late FossilService fossilService;

  final fossilJson = {
    "name": "Acanthostega",
    "url": "https://nookipedia.com/wiki/Acanthostega",
    "image_url": "https://dodo.ac/np/images/e/e0/Acanthostega_NH_Icon.png",
    "fossil_group": "Acanthostega",
    "interactable": false,
    "sell": 2000,
    "hha_base": 87,
    "width": 1.0,
    "length": 1.0,
    "colors": ["Beige", "Brown"]
  };

  const fossil = Fossil(
    "Acanthostega",
    "https://nookipedia.com/wiki/Acanthostega",
    "https://dodo.ac/np/images/e/e0/Acanthostega_NH_Icon.png",
    "Acanthostega",
    false,
    2000,
    87,
    1.0,
    1.0,
    ["Beige", "Brown"],
  );

  final fossilGroupJson = {
    "name": "Spinosaurus",
    "url": "https://nookipedia.com/wiki/Spinosaurus",
    "room": 2,
    "description":
        "Ahem. Yes. The Spinosaurus was a very large, carnivorous dinosaur, roughly the size of a T. Rex. Unlike its more famous cousin, however, Spinosaurus seems to have spent a great deal of time in water. Similar to modern crocodiles, this creature lived on a diet of fish AND land-dwelling animals. Personally, I am simply relieved that it did not seek FLYING prey.",
  };

  const fossilGroup = FossilGroup(
    "Spinosaurus",
    "https://nookipedia.com/wiki/Spinosaurus",
    2,
    "Ahem. Yes. The Spinosaurus was a very large, carnivorous dinosaur, roughly the size of a T. Rex. Unlike its more famous cousin, however, Spinosaurus seems to have spent a great deal of time in water. Similar to modern crocodiles, this creature lived on a diet of fish AND land-dwelling animals. Personally, I am simply relieved that it did not seek FLYING prey.",
    null,
  );

  final fossilGroupWithFossilsJson = {
    "name": "Spinosaurus",
    "url": "https://nookipedia.com/wiki/Spinosaurus",
    "room": 2,
    "description":
        "Ahem. Yes. The Spinosaurus was a very large, carnivorous dinosaur, roughly the size of a T. Rex. Unlike its more famous cousin, however, Spinosaurus seems to have spent a great deal of time in water. Similar to modern crocodiles, this creature lived on a diet of fish AND land-dwelling animals. Personally, I am simply relieved that it did not seek FLYING prey.",
    "fossils": [
      {
        "name": "Spino Skull",
        "url": "https://nookipedia.com/wiki/Spinosaurus",
        "image_url": "https://dodo.ac/np/images/7/7b/Spino_Skull_NH_Icon.png",
        "interactable": true,
        "sell": 4000,
        "hha_base": 87,
        "width": 2,
        "length": 2,
        "colors": ["Brown"]
      },
      {
        "name": "Spino Tail",
        "url": "https://nookipedia.com/wiki/Spinosaurus",
        "image_url": "https://dodo.ac/np/images/4/40/Spino_Tail_NH_Icon.png",
        "interactable": true,
        "sell": 2500,
        "hha_base": 87,
        "width": 2,
        "length": 2,
        "colors": ["Brown"]
      },
      {
        "name": "Spino Torso",
        "url": "https://nookipedia.com/wiki/Spinosaurus",
        "image_url": "https://dodo.ac/np/images/9/92/Spino_Torso_NH_Icon.png",
        "interactable": true,
        "sell": 3000,
        "hha_base": 87,
        "width": 2,
        "length": 2,
        "colors": ["Brown"]
      }
    ]
  };

  const fossilGroupWithFossil = FossilGroup(
    "Spinosaurus",
    "https://nookipedia.com/wiki/Spinosaurus",
    2,
    "Ahem. Yes. The Spinosaurus was a very large, carnivorous dinosaur, roughly the size of a T. Rex. Unlike its more famous cousin, however, Spinosaurus seems to have spent a great deal of time in water. Similar to modern crocodiles, this creature lived on a diet of fish AND land-dwelling animals. Personally, I am simply relieved that it did not seek FLYING prey.",
    [
      Fossil(
        "Spino Skull",
        "https://nookipedia.com/wiki/Spinosaurus",
        "https://dodo.ac/np/images/7/7b/Spino_Skull_NH_Icon.png",
        "",
        true,
        4000,
        87,
        2,
        2,
        ["Brown"],
      ),
      Fossil(
        "Spino Tail",
        "https://nookipedia.com/wiki/Spinosaurus",
        "https://dodo.ac/np/images/4/40/Spino_Tail_NH_Icon.png",
        "",
        true,
        2500,
        87,
        2,
        2,
        ["Brown"],
      ),
      Fossil(
        "Spino Torso",
        "https://nookipedia.com/wiki/Spinosaurus",
        "https://dodo.ac/np/images/9/92/Spino_Torso_NH_Icon.png",
        "",
        true,
        3000,
        87,
        2,
        2,
        ["Brown"],
      ),
    ],
  );

  setUpAll(() {
    fossilService = FossilServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  });

  group('Fetch a list of Fossils', () {
    test('without specifying a thumb size', () async {
      const resourceUrl = 'nh/fossils/individuals';
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
            fossilJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fossilService.fetch(), [fossil]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with a specific thumb size', () async {
      const resourceUrl = 'nh/fossils/individuals';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            fossilJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fossilService.fetch(thumbSize: 100), [fossil]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch a single Fossil', () {
    test('without specifying a thumb size', () async {
      const resourceUrl = 'nh/fossils/individuals/$encodedName';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: fossilJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fossilService.get(name: name), fossil);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with a specific thumb size', () async {
      const resourceUrl = 'nh/fossils/individuals/$encodedName';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: fossilJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fossilService.get(name: name, thumbSize: 100), fossil);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch a list of Fossil groups', () {
    test('without fossils and without specifying a thumb size', () async {
      const resourceUrl = 'nh/fossils/groups';
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
            fossilGroupJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fossilService.fetchGroups(), [fossilGroup]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('without fossils and with a specific thumb size', () async {
      const resourceUrl = 'nh/fossils/groups';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            fossilGroupJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fossilService.fetchGroups(thumbSize: 100), [fossilGroup]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with fossils and without specifying a thumb size', () async {
      const resourceUrl = 'nh/fossils/all';
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
            fossilGroupWithFossilsJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await fossilService.fetchGroups(
            includeFossils: true,
          ),
          [fossilGroupWithFossil]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with fossils and with a specific thumb size', () async {
      const resourceUrl = 'nh/fossils/all';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: [
            fossilGroupWithFossilsJson,
          ],
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await fossilService.fetchGroups(includeFossils: true, thumbSize: 100),
          [fossilGroupWithFossil]);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });

  group('Fetch a single Fossil group', () {
    test('without fossils and without specifying a thumb size', () async {
      const resourceUrl = 'nh/fossils/groups/$encodedGroupName';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: fossilGroupJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fossilService.getGroup(name: groupName), fossilGroup);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('without fossils and with a specific thumb size', () async {
      const resourceUrl = 'nh/fossils/groups/$encodedGroupName';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: fossilGroupJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(await fossilService.getGroup(name: groupName, thumbSize: 100),
          fossilGroup);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with fossils and without specifying a thumb size', () async {
      const resourceUrl = 'nh/fossils/all/$encodedGroupName';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: fossilGroupWithFossilsJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await fossilService.getGroup(
            name: groupName,
            includeFossils: true,
          ),
          fossilGroupWithFossil);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {},
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('with fossils and with a specific thumb size', () async {
      const resourceUrl = 'nh/fossils/all/$encodedGroupName';
      when(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).thenAnswer(
        (realInvocation) async => Response(
          statusCode: 200,
          data: fossilGroupWithFossilsJson,
          requestOptions: RequestOptions(
            path: resourceUrl,
          ),
        ),
      );

      expect(
          await fossilService.getGroup(
            name: groupName,
            includeFossils: true,
            thumbSize: 100,
          ),
          fossilGroupWithFossil);

      verify(
        dio.get(
          resourceUrl,
          queryParameters: {"thumbsize": 100},
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });
}
