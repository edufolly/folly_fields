import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/extensions/string_extension.dart';

void main() {
  group('FollyStringExtension capitalizeWords', () {
    Set<(String, String)> domain = <(String, String)>{
      ('word', 'Word'),
      ('Word', 'Word'),
      ('WOrd', 'Word'),
      ('WORd', 'Word'),
      ('WORD', 'Word'),
      ('worD', 'Word'),
      ('wOrD', 'Word'),
      ('WOrD', 'Word'),
      ('word last', 'Word Last'),
      ('Word last', 'Word Last'),
      ('Word Last', 'Word Last'),
      ('word Last', 'Word Last'),
      ('WORD LAST', 'Word Last'),
      ('word last next', 'Word Last Next'),
      ('WORD LAST NEXT', 'Word Last Next'),
    };

    for (final (String key, String value) in domain) {
      test('Testing $key => $value', () => expect(key.capitalizeWords, value));
    }
  });
}
