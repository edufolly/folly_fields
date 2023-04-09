import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_string_extension.dart';

///
///
///
void main() {
  group(
    'FollyStringExtension capitalize',
    () {
      Map<String, String> domain = <String, String>{
        'word': 'Word',
        'Word': 'Word',
        'WOrd': 'Word',
        'WORd': 'Word',
        'WORD': 'Word',
        'worD': 'Word',
        'wOrD': 'Word',
        'WOrD': 'Word',
        'word last': 'Word last',
        'Word last': 'Word last',
        'Word Last': 'Word last',
        'word Last': 'Word last',
        'WORD LAST': 'Word last',
      };

      for (final MapEntry<String, String> input in domain.entries) {
        test(
          'Testing ${input.key} => ${input.value}',
          () => expect(input.key.capitalize, input.value),
        );
      }
    },
  );
}
