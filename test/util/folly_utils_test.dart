import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_utils.dart';

///
///
///
void main() {
  List<_FollyUtilsTest> tests = <_FollyUtilsTest>[
    _FollyUtilsTest(
      name: 'Name',
      camelCase: 'name',
      pascalCase: 'Name',
      snakeCase: 'name',
    ),
    _FollyUtilsTest(
      name: 'Name9',
      camelCase: 'name9',
      pascalCase: 'Name9',
      snakeCase: 'name9',
    ),
    _FollyUtilsTest(
      name: 'Feature Model',
      camelCase: 'featureModel',
      pascalCase: 'FeatureModel',
      snakeCase: 'feature_model',
    ),
    _FollyUtilsTest(
      name: 'Feature0 Model9',
      camelCase: 'feature0Model9',
      pascalCase: 'Feature0Model9',
      snakeCase: 'feature0_model9',
    ),
    _FollyUtilsTest(
      name: 'First Second Third',
      camelCase: 'firstSecondThird',
      pascalCase: 'FirstSecondThird',
      snakeCase: 'first_second_third',
    ),
  ];

  for (_FollyUtilsTest t in tests) {
    group('Valid: ${t.name}', () {
      ///
      test(
        'camelCase is true',
        () => expect(
          FollyUtils.isCamelCase(t.camelCase),
          true,
        ),
      );

      test(
        'Compare camelCase with PascalCase',
        () => expect(
          FollyUtils.isCamelCase(t.pascalCase),
          t.camelCase == t.pascalCase,
        ),
      );

      test(
        'Compare camelCase with snake_case',
        () => expect(
          FollyUtils.isCamelCase(t.snakeCase),
          t.camelCase == t.snakeCase,
        ),
      );

      ///
      test(
        'PascalCase is true',
        () => expect(
          FollyUtils.isPascalCase(t.pascalCase),
          true,
        ),
      );

      test(
        'Compare PascalCase with camelCase',
        () => expect(
          FollyUtils.isPascalCase(t.camelCase),
          t.pascalCase == t.camelCase,
        ),
      );

      test(
        'Compare PascalCase with snake_case',
        () => expect(
          FollyUtils.isPascalCase(t.snakeCase),
          t.pascalCase == t.snakeCase,
        ),
      );

      ///
      test(
        'snake_case is true',
        () => expect(
          FollyUtils.isSnakeCase(t.snakeCase),
          true,
        ),
      );

      test(
        'Compare snake_case with camelCase',
        () => expect(
          FollyUtils.isSnakeCase(t.camelCase),
          t.snakeCase == t.camelCase,
        ),
      );

      test(
        'Compare snake_case with PascalCase',
        () => expect(
          FollyUtils.isSnakeCase(t.pascalCase),
          t.snakeCase == t.pascalCase,
        ),
      );

      ///
      test(
        'Convert camelCase to PascalCase',
        () => expect(
          FollyUtils.camel2Pascal(t.camelCase),
          t.pascalCase,
        ),
      );

      test(
        'Convert camelCase to snake_case',
        () => expect(
          FollyUtils.camel2Snake(t.camelCase),
          t.snakeCase,
        ),
      );

      ///
      test(
        'Convert PascalCase to camelCase',
        () => expect(
          FollyUtils.pascal2Camel(t.pascalCase),
          t.camelCase,
        ),
      );

      test(
        'Convert PascalCase to snake_case',
        () => expect(
          FollyUtils.pascal2Snake(t.pascalCase),
          t.snakeCase,
        ),
      );

      ///
      test(
        'Convert snake_case to camelCase',
        () => expect(
          FollyUtils.snake2Camel(t.snakeCase),
          t.camelCase,
        ),
      );

      test(
        'Convert snake_case to PascalCase',
        () => expect(
          FollyUtils.snake2Pascal(t.snakeCase),
          t.pascalCase,
        ),
      );
    });
  }

  ///
  ///
  ///
  List<_FollyUtilsTest> errors = <_FollyUtilsTest>[
    _FollyUtilsTest(
      name: '[Empty]',
    ),
    _FollyUtilsTest(
      name: '9Name',
      camelCase: '9Name',
    ),
    _FollyUtilsTest(
      name: 'Nameç',
      camelCase: 'Nameç',
    ),
    _FollyUtilsTest(
      name: '[Line Break]',
      camelCase: 'Name\n',
    ),
  ];

  for (_FollyUtilsTest t in errors) {
    group('Errors: ${t.name}', () {
      ///
      test(
        'camelCase is false',
        () => expect(
          FollyUtils.isCamelCase(t.camelCase),
          false,
        ),
      );

      test(
        'PascalCase is false',
        () => expect(
          FollyUtils.isPascalCase(t.camelCase),
          false,
        ),
      );

      test(
        'snake_case is false',
        () => expect(
          FollyUtils.isSnakeCase(t.camelCase),
          false,
        ),
      );

      ///
      test(
        'Convert camelCase to PascalCase',
        () => expect(
          FollyUtils.camel2Pascal(t.camelCase),
          '',
        ),
      );

      test(
        'Convert camelCase to snake_case',
        () => expect(
          FollyUtils.camel2Snake(t.camelCase),
          '',
        ),
      );

      ///
      test(
        'Convert PascalCase to camelCase',
        () => expect(
          FollyUtils.pascal2Camel(t.camelCase),
          '',
        ),
      );

      test(
        'Convert PascalCase to snake_case',
        () => expect(
          FollyUtils.pascal2Snake(t.camelCase),
          '',
        ),
      );

      ///
      test(
        'Convert snake_case to camelCase',
        () => expect(
          FollyUtils.snake2Camel(t.camelCase),
          '',
        ),
      );

      test(
        'Convert snake_case to PascalCase',
        () => expect(
          FollyUtils.snake2Pascal(t.camelCase),
          '',
        ),
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

///
///
///
class _FollyUtilsTest {
  final String name;
  final String camelCase;
  final String pascalCase;
  final String snakeCase;

  _FollyUtilsTest({
    this.name = '',
    this.camelCase = '',
    this.pascalCase = '',
    this.snakeCase = '',
  });
}
