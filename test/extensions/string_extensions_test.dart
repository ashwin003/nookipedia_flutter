import 'package:flutter_test/flutter_test.dart';
import 'package:nookipedia_flutter/src/extensions/string_extensions.dart';

class TestData {
  final String input;
  final dynamic expectedOutput;

  TestData({
    required this.input,
    required this.expectedOutput,
  });
}

void main() {
  group('Should return capitalized strings as expected', () {
    for (var element in [
      TestData(
        input: "january",
        expectedOutput: "January",
      ),
      TestData(
        input: "spider",
        expectedOutput: "Spider",
      )
    ]) {
      test(element.input, () {
        final output = element.input.toCapitalized();
        expect(output, element.expectedOutput);
      });
    }
  });
  group('Should convert time range string to hours list as expected', () {
    for (var element in [
      TestData(
        input: "4 PM – 9 AM",
        expectedOutput: [
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8
        ],
      ),
      TestData(
        input: "4 AM – 9 PM",
        expectedOutput: [
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20
        ],
      )
    ]) {
      test(element.input, () {
        final hours = element.input.toHours();
        expect(hours, element.expectedOutput);
      });
    }
  });

  group('Should convert time string to hour as expected', () {
    for (var element in [
      TestData(input: '4 AM', expectedOutput: 4),
      TestData(input: '4 PM', expectedOutput: 16),
      TestData(input: '12 AM', expectedOutput: 0)
    ]) {
      test(element.input, () {
        final output = element.input.toHour();
        expect(output, element.expectedOutput);
      });
    }
  });
}
