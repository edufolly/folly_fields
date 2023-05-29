import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/mobile_phone_validator.dart';

///
///
///
void main() {
  group(
    'MobilePhoneValidator isValid',
    () {
      final Map<String, bool> domain = <String, bool>{
        '': false,
        ' ': false,
        '9': false,
        '99': false,
        '999': false,
        '9999': false,
        '99999': false,
        '999999': false,
        '9999999': false,
        '99999999': false,
        '999999999': false,
        '9999999999': false,
        '88999999999': true,
        '88899999999': false,
        '08999999999': false,
        '80999999999': false,
        '08899999999': false,
        '80899999999': false,
        '889999999999': false,
        '(9)': false,
        '(99)': false,
        '(99) 9': false,
        '(99) 99': false,
        '(99) 999': false,
        '(99) 9999': false,
        '(99) 99999': false,
        '(99) 99999-': false,
        '(99) 99999-9': false,
        '(99) 99999-99': false,
        '(99) 99999-999': false,
        '(88) 99999-9999': true,
        '(88) 89999-9999': false,
        '(80) 99999-9999': false,
        '(08) 99999-9999': false,
        '(80) 89999-9999': false,
        '(08) 89999-9999': false,
      };

      final MobilePhoneValidator validator = MobilePhoneValidator();

      for (final MapEntry<String, bool> input in domain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  group(
    'MobilePhoneValidator format',
    () {
      final Map<String, String> domain = <String, String>{
        '': '',
        ' ': '',
        '!': '',
        '9999999999': '9999999999',
        '(99) 99999-999': '9999999999',
        '99999999999': '(99) 99999-9999',
        '(99) 99999-9999': '(99) 99999-9999',
      };

      final MobilePhoneValidator validator = MobilePhoneValidator();

      for (final MapEntry<String, String> input in domain.entries) {
        test(
          'Testing ${input.key}',
          () => expect(validator.format(input.key), input.value),
        );
      }
    },
  );

  group('MobilePhoneValidator Coverage', () {
    final MobilePhoneValidator validator = MobilePhoneValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
