import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonSafeStringSet',
    () {
      final Map<dynamic, Set<String>> domain = <dynamic, Set<String>>{
        null: <String>{},
        '': <String>{''},
        ' ': <String>{' '},
        'A': <String>{'A'},
        'a': <String>{'a'},
        '1': <String>{'1'},
        1: <String>{'1'},
        2.3: <String>{'2.3'},
        true: <String>{'true'},
        false: <String>{'false'},
        <dynamic>[]: <String>{},
        <dynamic>[null, '', 2.3, ' ', 'A', 'a', '1', 1, true, false]: <String>{
          'null',
          '',
          '2.3',
          ' ',
          'A',
          'a',
          '1',
          'true',
          'false',
        },
        <dynamic>{}: <String>{},
        <dynamic>{null, '', 2.3, ' ', 'A', 'a', '1', 1, true, false}: <String>{
          'null',
          '',
          '2.3',
          ' ',
          'A',
          'a',
          '1',
          'true',
          'false',
        },
        <dynamic, dynamic>{}: <String>{'{}'},
        <dynamic, dynamic>{null: null}: <String>{'{null: null}'},
      };

      for (final MapEntry<dynamic, Set<String>> input in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonSafeStringSet(input.key),
              input.value,
            );
          },
        );
      }
    },
  );
}
