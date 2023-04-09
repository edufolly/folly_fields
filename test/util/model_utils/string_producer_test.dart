import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils stringProducer',
    () {
      Map<dynamic, String> domain = <dynamic, String>{
        null: 'null',
        'null': 'null',
        '': '',
        true: 'true',
        false: 'false',
        1: '1',
        2.3: '2.3',
        <dynamic>['a', true, false, null, 1, 2.3]:
            '[a, true, false, null, 1, 2.3]',
        <dynamic, dynamic>{
          null: null,
          true: true,
          '': '',
          'null': 'null',
          false: false,
          1: 1,
          2.3: 2.3,
        }: '{null: null, '
            'true: true, : , '
            'null: null, '
            'false: false, '
            '1: 1, '
            '2.3: 2.3}',
      };

      for (final MapEntry<dynamic, String> input in domain.entries) {
        test(
          '${input.key}',
          () {
            expect(ModelUtils.stringProducer(input.key), input.value);
          },
        );
      }
    },
  );
}
