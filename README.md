<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Dart wrapper for [Nookipedia API](https://api.nookipedia.com/). It  provides simple methods for retrieving Animal Crossing data.

## Features

Contains wrapper methods for the following endpoints:
1. Artwork
2. Clothing
3. Events
4. Furniture
5. Interiors
6. Miscellaneous items available in the game
7. Photos and Posters
8. Recipes
9. Tools
10. Villagers
10. Villagers
11. Insects
12. Fish
13. Sea Creatures
14. Fossils

## Getting started

Import the package:

```dart
import 'package:nookipedia_flutter/nookipedia_flutter.dart';
```

Initialize `NookipediaClient` before using it:

```dart
void main() {
  NookipediaClient.initialize(
    apiKey: NOOKIPEDIA_API_KEY,
    version: API_VERSION_HERE
  );
  runApp(const MyApp());
}
```

> `apiKey` is mandatory. You will have to apply for one [here](https://api.nookipedia.com/).

> `version` is optional. It controls which version of the API you are calling.

## Usage

Call the methods exposed by the API by using the client instance:

```dart
FutureBuilder(
    future: NookipediaClient.instance.clothing
        .fetchNames(category: ClothingCategory.dressUp),
    builder: ((context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
            return Text(snapshot.error?.toString() ?? "Something went wrong");
        }
        var data = snapshot.data!;
        return ListView.builder(
        itemCount: data.length,
        itemBuilder: ((context, index) {
            return ListTile(title: Text(data[index]));
        }),
        );
    }),
)
```
