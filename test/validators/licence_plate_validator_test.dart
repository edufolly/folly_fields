import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/licence_plate_validator.dart';

import '../cartesian_product_helper.dart';

///
///
///
void main() {
  LicencePlateValidator validator = LicencePlateValidator();

  group(
    'LicencePlateValidator isValid',
    () {
      List<Map<String, bool>> domain = <Map<String, bool>>[
        <String, bool>{'A': true, '9': false, '-': false, ' ': false},
        <String, bool>{'A': true, '9': false},
        <String, bool>{'A': true, '9': false},
        <String, bool>{'-': true, '': true},
        <String, bool>{'A': false, '9': true},
        <String, bool>{'A': true, '9': true},
        <String, bool>{'A': false, '9': true},
        <String, bool>{'A': false, '9': true},
      ];

      cartesianProductGenerate(
        domain,
        (List<dynamic> data, {required bool result}) {
          String key = data.join();
          test(
            'Testing "$key" for "$result"',
            () => expect(validator.isValid(key), result),
          );
        },
      );
    },
  );

  group(
    'LicencePlateValidator format',
    () {
      Map<String, String> domain = <String, String>{
        '': '',
        ' ': '',
        '!': '',
        'AAA9999': 'AAA-9999',
        'AAA9A99': 'AAA-9A99',
      };

      for (final MapEntry<String, String> input in domain.entries) {
        test(
          'Testing ${input.key}',
          () => expect(validator.format(input.key), input.value),
        );
      }
    },
  );

  group('LicencePlateValidator Coverage', () {
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
