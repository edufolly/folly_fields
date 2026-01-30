import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/extensions/string_extension.dart';

void main() {
  List<({String name, String camelCase, String pascalCase, String snakeCase})>
  tests =
      <({String name, String camelCase, String pascalCase, String snakeCase})>[
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
      )
      in tests) {
    group('Valid: $name', () {
      test('camelCase is true', () => expect(camelCase.isCamelCase, true));

      test(
        'Compare camelCase with PascalCase',
        () => expect(pascalCase.isCamelCase, camelCase == pascalCase),
      );

      test(
        'Compare camelCase with snake_case',
        () => expect(snakeCase.isCamelCase, camelCase == snakeCase),
      );

      test('PascalCase is true', () => expect(pascalCase.isPascalCase, true));

      test(
        'Compare PascalCase with camelCase',
        () => expect(camelCase.isPascalCase, pascalCase == camelCase),
      );

      test(
        'Compare PascalCase with snake_case',
        () => expect(snakeCase.isPascalCase, pascalCase == snakeCase),
      );

      test('snake_case is true', () => expect(snakeCase.isSnakeCase, true));

      test(
        'Compare snake_case with camelCase',
        () => expect(camelCase.isSnakeCase, snakeCase == camelCase),
      );

      test(
        'Compare snake_case with PascalCase',
        () => expect(pascalCase.isSnakeCase, snakeCase == pascalCase),
      );

      test(
        'Convert camelCase to PascalCase',
        () => expect(camelCase.camel2Pascal, pascalCase),
      );

      test(
        'Convert camelCase to snake_case',
        () => expect(camelCase.camel2Snake, snakeCase),
      );

      test(
        'Convert PascalCase to camelCase',
        () => expect(pascalCase.pascal2Camel, camelCase),
      );

      test(
        'Convert PascalCase to snake_case',
        () => expect(pascalCase.pascal2Snake, snakeCase),
      );

      test(
        'Convert snake_case to camelCase',
        () => expect(snakeCase.snake2Camel, camelCase),
      );

      test(
        'Convert snake_case to PascalCase',
        () => expect(snakeCase.snake2Pascal, pascalCase),
      );
    });
  }

  Map<String, String> errors = <String, String>{
    '[Empty]': '',
    '9Name': '9Name',
    'Nameç': 'Nameç',
    '[Line Break]': 'Name\n',
  };

  for (final MapEntry<String, String>(:String key, :String value)
      in errors.entries) {
    group('Errors: $key', () {
      test('camelCase is false', () => expect(value.isCamelCase, false));

      test('PascalCase is false', () => expect(value.isPascalCase, false));

      test('snake_case is false', () => expect(value.isSnakeCase, false));

      test(
        'Convert camelCase to PascalCase',
        () => expect(() => value.camel2Pascal, throwsException),
      );

      test(
        'Convert camelCase to snake_case',
        () => expect(() => value.camel2Snake, throwsException),
      );

      test(
        'Convert PascalCase to camelCase',
        () => expect(() => value.pascal2Camel, throwsException),
      );

      test(
        'Convert PascalCase to snake_case',
        () => expect(() => value.pascal2Snake, throwsException),
      );

      test(
        'Convert snake_case to camelCase',
        () => expect(() => value.snake2Camel, throwsException),
      );

      test(
        'Convert snake_case to PascalCase',
        () => expect(() => value.snake2Pascal, throwsException),
      );
    });
  }
}
