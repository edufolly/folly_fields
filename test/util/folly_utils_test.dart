import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_utils.dart';

///
///
///
void main() {
  List<
      ({
        String name,
        String camelCase,
        String pascalCase,
        String snakeCase,
      })> tests = <({
    String name,
    String camelCase,
    String pascalCase,
    String snakeCase,
  })>[
    (
      name: 'Name',
      camelCase: 'name',
      pascalCase: 'Name',
      snakeCase: 'name',
    ),
    (
      name: 'Name9',
      camelCase: 'name9',
      pascalCase: 'Name9',
      snakeCase: 'name9',
    ),
    (
      name: 'Feature Model',
      camelCase: 'featureModel',
      pascalCase: 'FeatureModel',
      snakeCase: 'feature_model',
    ),
    (
      name: 'Feature0 Model9',
      camelCase: 'feature0Model9',
      pascalCase: 'Feature0Model9',
      snakeCase: 'feature0_model9',
    ),
    (
      name: 'First Second Third',
      camelCase: 'firstSecondThird',
      pascalCase: 'FirstSecondThird',
      snakeCase: 'first_second_third',
    ),
  ];

  for (final (
        :String name,
        :String camelCase,
        :String pascalCase,
        :String snakeCase,
      ) in tests) {
    group('Valid: $name', () {
      test(
        'camelCase is true',
        () => expect(FollyUtils.isCamelCase(camelCase), true),
      );

      test(
        'Compare camelCase with PascalCase',
        () => expect(
          FollyUtils.isCamelCase(pascalCase),
          camelCase == pascalCase,
        ),
      );

      test(
        'Compare camelCase with snake_case',
        () => expect(
          FollyUtils.isCamelCase(snakeCase),
          camelCase == snakeCase,
        ),
      );

      ///
      test(
        'PascalCase is true',
        () => expect(FollyUtils.isPascalCase(pascalCase), true),
      );

      test(
        'Compare PascalCase with camelCase',
        () => expect(
          FollyUtils.isPascalCase(camelCase),
          pascalCase == camelCase,
        ),
      );

      test(
        'Compare PascalCase with snake_case',
        () => expect(
          FollyUtils.isPascalCase(snakeCase),
          pascalCase == snakeCase,
        ),
      );

      ///
      test(
        'snake_case is true',
        () => expect(FollyUtils.isSnakeCase(snakeCase), true),
      );

      test(
        'Compare snake_case with camelCase',
        () => expect(
          FollyUtils.isSnakeCase(camelCase),
          snakeCase == camelCase,
        ),
      );

      test(
        'Compare snake_case with PascalCase',
        () => expect(
          FollyUtils.isSnakeCase(pascalCase),
          snakeCase == pascalCase,
        ),
      );

      ///
      test(
        'Convert camelCase to PascalCase',
        () => expect(FollyUtils.camel2Pascal(camelCase), pascalCase),
      );

      test(
        'Convert camelCase to snake_case',
        () => expect(FollyUtils.camel2Snake(camelCase), snakeCase),
      );

      ///
      test(
        'Convert PascalCase to camelCase',
        () => expect(FollyUtils.pascal2Camel(pascalCase), camelCase),
      );

      test(
        'Convert PascalCase to snake_case',
        () => expect(FollyUtils.pascal2Snake(pascalCase), snakeCase),
      );

      ///
      test(
        'Convert snake_case to camelCase',
        () => expect(FollyUtils.snake2Camel(snakeCase), camelCase),
      );

      test(
        'Convert snake_case to PascalCase',
        () => expect(
          FollyUtils.snake2Pascal(snakeCase),
          pascalCase,
        ),
      );
    });
  }

  ///
  ///
  ///

  Map<String, String> errors = <String, String>{
    '[Empty]': '',
    '9Name': '9Name',
    'Nameç': 'Nameç',
    '[Line Break]': 'Name\n',
  };

  for (final MapEntry<String, String>(
        :String key,
        :String value,
      ) in errors.entries) {
    group('Errors: $key', () {
      test(
        'camelCase is false',
        () => expect(FollyUtils.isCamelCase(value), false),
      );

      test(
        'PascalCase is false',
        () => expect(FollyUtils.isPascalCase(value), false),
      );

      test(
        'snake_case is false',
        () => expect(FollyUtils.isSnakeCase(value), false),
      );

      ///
      test(
        'Convert camelCase to PascalCase',
        () => expect(FollyUtils.camel2Pascal(value), ''),
      );

      test(
        'Convert camelCase to snake_case',
        () => expect(FollyUtils.camel2Snake(value), ''),
      );

      ///
      test(
        'Convert PascalCase to camelCase',
        () => expect(FollyUtils.pascal2Camel(value), ''),
      );

      test(
        'Convert PascalCase to snake_case',
        () => expect(FollyUtils.pascal2Snake(value), ''),
      );

      ///
      test(
        'Convert snake_case to camelCase',
        () => expect(FollyUtils.snake2Camel(value), ''),
      );

      test(
        'Convert snake_case to PascalCase',
        () => expect(FollyUtils.snake2Pascal(value), ''),
      );
    });
  }

  ///
  /// createMaterialColor
  ///
  const Color staticColor = Colors.black;

  MaterialColor staticMaterialColor = MaterialColor(
    staticColor.value,
    const <int, Color>{
      50: staticColor,
      100: staticColor,
      200: staticColor,
      300: staticColor,
      400: staticColor,
      500: staticColor,
      600: staticColor,
      700: staticColor,
      800: staticColor,
      900: staticColor,
    },
  );

  group(
    'createMaterialColor',
    () {
      test(
        'Testing all null',
        () => expect(FollyUtils.createMaterialColor(), null),
      );

      test(
        'Testing Color',
        () => expect(
          FollyUtils.createMaterialColor(color: staticColor),
          staticMaterialColor,
        ),
      );

      test(
        'Testing Integer Color',
        () => expect(
          FollyUtils.createMaterialColor(intColor: staticColor.value),
          staticMaterialColor,
        ),
      );
    },
  );
}
