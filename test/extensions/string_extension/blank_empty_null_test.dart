import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/extensions/string_extension.dart';

void main() {
  group('FollyStringExtension isNullOrEmpty', () {
    Set<(String?, bool)> domain = <(String?, bool)>{
      (null, true),
      ('', true),
      (' ', false),
      ('A', false),
      ('A ', false),
      (' A', false),
      ('\n', false),
      ('\t', false),
    };

    for (final (String? key, bool value) in domain) {
      test('Testing $key => $value', () => expect(key.isNullOrEmpty, value));
    }
  });

  group('FollyStringExtension isNullOrBlank', () {
    Set<(String?, bool)> domain = <(String?, bool)>{
      (null, true),
      ('', true),
      (' ', true),
      ('A', false),
      ('A ', false),
      (' A', false),
      ('\n', true),
      ('\t', true),
    };

    for (final (String? key, bool value) in domain) {
      test('Testing $key => $value', () => expect(key.isNullOrBlank, value));
    }
  });

  group('FollyStringExtension isBlank', () {
    Set<(String?, bool)> domain = <(String?, bool)>{
      (null, false),
      ('', true),
      (' ', true),
      ('A', false),
      ('A ', false),
      (' A', false),
      ('\n', true),
      ('\t', true),
    };

    for (final (String? key, bool value) in domain) {
      test('Testing $key => $value', () => expect(key.isBlank, value));
    }
  });
}
