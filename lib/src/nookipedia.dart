import 'package:dio/dio.dart';
import 'services/implementations/index.dart';

import 'services/index.dart';

/// Nookipedia Client instance
///
/// It must be initialized before being used, otherwise an error is thrown
///
/// Initialization:
///
/// ```dart
/// NookipediaClient.initialize(...)
/// ```
///
/// Usage:
///
/// final instance = NookipediaClient.instance;
class NookipediaClient {
  /// Initialize the current Nookipedia client instance
  ///
  /// This must be called only once. If called more than once, an
  /// [AssertionError] is thrown
  static void initialize({required String apiKey, String version = "1.5.0"}) {
    assert(!_instance._initialized, 'This instance is already initialized');
    // Initialize all available services with the specified parameters
    _instance._init(apiKey, version);
    _instance._initialized = true;
  }

  /// Gets the current Nookipedia client instance
  ///
  /// An [AssertionError] is thrown if Nookipedia isn't initialized yet.
  /// Call [NookipediaClient.initialize] to initialize it.
  static NookipediaClient get instance {
    assert(_instance._initialized,
        'You must initialize Nookipedia client before accessing the instance');
    return _instance;
  }

  NookipediaClient._();
  static final NookipediaClient _instance = NookipediaClient._();

  bool _initialized = false;

  // Different services within Nookipedia clients representing individual entity types within Animal Crossing

  /// Provides services related to the `villagers` in the Animal Crossing series.
  late VillagerService villagers;

  /// Provides services related to the `artwork` in the Animal Crossing series.
  late ArtworkService artwork;

  /// Provides services related to `events` in the Animal Crossing series.
  late EventsService events;

  /// Provides services related to the `furniture` in the Animal Crossing series.
  late FurnitureService furniture;

  /// Provides services related to the `clothing` in the Animal Crossing series.
  late ClothingService clothing;

  /// Provides services related to the `interior` in the Animal Crossing series.
  late InteriorService interior;

  /// Provides services related to the `tools` in the Animal Crossing series.
  late ToolService tools;

  /// Provides services related to the `miscellaneous items` in the Animal Crossing series.
  late ItemService items;

  /// Provides services related to the `recipes` in the Animal Crossing series.
  late RecipeService recipes;

  /// Provides services related to the `sea creatures` in the Animal Crossing series.
  late SeaCreatureService seaCreatures;

  /// Provides services related to the `fishes` in the Animal Crossing series.
  late FishService fish;

  /// Provides services related to the `insects` in the Animal Crossing series.
  late InsectService insects;

  /// Provides services related to the `fossils` in the Animal Crossing series.
  late FossilService fossils;

  /// Provides services related to the `photos` in the Animal Crossing series.
  late PhotoService photos;

  void _init(String apiKey, String version) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.nookipedia.com/',
      ),
    );
    villagers = VillagerServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    artwork = ArtworkServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    events = EventsServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    furniture = FurnitureServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    clothing = ClothingServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    interior = InteriorServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    tools = ToolServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    items = ItemServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    recipes = RecipeServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    seaCreatures = SeaCreatureServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    fish = FishServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    insects = InsectServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    fossils = FossilServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
    photos = PhotoServiceImpl(
      apiKey: apiKey,
      version: version,
      dio: dio,
    );
  }
}
