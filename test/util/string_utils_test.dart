import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/string_utils.dart';

///
///
///
void main() {
  List<_StringUtilsTest> tests = <_StringUtilsTest>[
    _StringUtilsTest(
      name: 'Name',
      camelCase: 'name',
      pascalCase: 'Name',
      snakeCase: 'name',
    ),
    _StringUtilsTest(
      name: 'Name9',
      camelCase: 'name9',
      pascalCase: 'Name9',
      snakeCase: 'name9',
    ),
    _StringUtilsTest(
      name: 'Feature Model',
      camelCase: 'featureModel',
      pascalCase: 'FeatureModel',
      snakeCase: 'feature_model',
    ),
    _StringUtilsTest(
      name: 'Feature0 Model9',
      camelCase: 'feature0Model9',
      pascalCase: 'Feature0Model9',
      snakeCase: 'feature0_model9',
    ),
    _StringUtilsTest(
      name: 'First Second Third',
      camelCase: 'firstSecondThird',
      pascalCase: 'FirstSecondThird',
      snakeCase: 'first_second_third',
    ),
  ];

  for (_StringUtilsTest t in tests) {
    group('Valid: ${t.name}', () {
      ///
      test('camelCase is true',
          () => expect(StringUtils.isCamelCase(t.camelCase), true));

      test(
          'Compare camelCase with PascalCase',
          () => expect(StringUtils.isCamelCase(t.pascalCase),
              t.camelCase == t.pascalCase));

      test(
          'Compare camelCase with snake_case',
          () => expect(StringUtils.isCamelCase(t.snakeCase),
              t.camelCase == t.snakeCase));

      ///
      test('PascalCase is true',
          () => expect(StringUtils.isPascalCase(t.pascalCase), true));

      test(
          'Compare PascalCase with camelCase',
          () => expect(StringUtils.isPascalCase(t.camelCase),
              t.pascalCase == t.camelCase));

      test(
          'Compare PascalCase with snake_case',
          () => expect(StringUtils.isPascalCase(t.snakeCase),
              t.pascalCase == t.snakeCase));

      ///
      test('snake_case is true',
          () => expect(StringUtils.isSnakeCase(t.snakeCase), true));

      test(
          'Compare snake_case with camelCase',
          () => expect(StringUtils.isSnakeCase(t.camelCase),
              t.snakeCase == t.camelCase));

      test(
          'Compare snake_case with PascalCase',
          () => expect(StringUtils.isSnakeCase(t.pascalCase),
              t.snakeCase == t.pascalCase));

      ///
      test('Convert camelCase to PascalCase',
          () => expect(StringUtils.camel2Pascal(t.camelCase), t.pascalCase));

      test('Convert camelCase to snake_case',
          () => expect(StringUtils.camel2Snake(t.camelCase), t.snakeCase));

      ///
      test('Convert PascalCase to camelCase',
          () => expect(StringUtils.pascal2Camel(t.pascalCase), t.camelCase));

      test('Convert PascalCase to snake_case',
          () => expect(StringUtils.pascal2Snake(t.pascalCase), t.snakeCase));

      ///
      test('Convert snake_case to camelCase',
          () => expect(StringUtils.snake2Camel(t.snakeCase), t.camelCase));

      test('Convert snake_case to PascalCase',
          () => expect(StringUtils.snake2Pascal(t.snakeCase), t.pascalCase));
    });
  }

  ///
  ///
  ///
  List<_StringUtilsTest> errors = <_StringUtilsTest>[
    _StringUtilsTest(
      name: '[Empty]',
      camelCase: '',
    ),
    _StringUtilsTest(
      name: '9Name',
      camelCase: '9Name',
    ),
    _StringUtilsTest(
      name: 'Nameç',
      camelCase: 'Nameç',
    ),
    _StringUtilsTest(
      name: '[Line Break]',
      camelCase: 'Name\n',
    ),
  ];

  for (_StringUtilsTest t in errors) {
    group('Errors: ${t.name}', () {
      ///
      test('camelCase is false',
          () => expect(StringUtils.isCamelCase(t.camelCase), false));

      test('PascalCase is false',
          () => expect(StringUtils.isPascalCase(t.camelCase), false));

      test('snake_case is false',
          () => expect(StringUtils.isSnakeCase(t.camelCase), false));

      ///
      test('Convert camelCase to PascalCase',
          () => expect(StringUtils.camel2Pascal(t.camelCase), ''));

      test('Convert camelCase to snake_case',
          () => expect(StringUtils.camel2Snake(t.camelCase), ''));

      ///
      test('Convert PascalCase to camelCase',
          () => expect(StringUtils.pascal2Camel(t.camelCase), ''));

      test('Convert PascalCase to snake_case',
          () => expect(StringUtils.pascal2Snake(t.camelCase), ''));

      ///
      test('Convert snake_case to camelCase',
          () => expect(StringUtils.snake2Camel(t.camelCase), ''));

      test('Convert snake_case to PascalCase',
          () => expect(StringUtils.snake2Pascal(t.camelCase), ''));
    });
  }
}

///
///
///
class _StringUtilsTest {
  final String name;
  final String camelCase;
  final String pascalCase;
  final String snakeCase;

  _StringUtilsTest({
    this.name = '',
    this.camelCase = '',
    this.pascalCase = '',
    this.snakeCase = '',
  });
}
