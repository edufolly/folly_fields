import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_string_extension.dart';

///
///
///
void main() {
  group(
    'FollyStringExtension capitalizeWords',
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
        'word last': 'Word Last',
        'Word last': 'Word Last',
        'Word Last': 'Word Last',
        'word Last': 'Word Last',
        'WORD LAST': 'Word Last',
        'word last next': 'Word Last Next',
        'WORD LAST NEXT': 'Word Last Next',
      };

      for (final MapEntry<String, String> input in domain.entries) {
        test(
          'Testing ${input.key} => ${input.value}',
          () => expect(input.key.capitalizeWords, input.value),
        );
      }
    },
  );
}
