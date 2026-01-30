import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/extensions/string_extension.dart';

void main() {
  group('FollyStringExtension capitalize', () {
    Set<(String, String)> domain = <(String, String)>{
      ('word', 'Word'),
      ('Word', 'Word'),
      ('WOrd', 'Word'),
      ('WORd', 'Word'),
      ('WORD', 'Word'),
      ('worD', 'Word'),
      ('wOrD', 'Word'),
      ('WOrD', 'Word'),
      ('word last', 'Word last'),
      ('Word last', 'Word last'),
      ('Word Last', 'Word last'),
      ('word Last', 'Word last'),
      ('WORD LAST', 'Word last'),
    };

    for (final (String key, String value) in domain) {
      test('Testing $key => $value', () => expect(key.capitalize, value));
    }
  });
}
