import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/mobile_phone_validator.dart';

///
///
///
void main() {
  MobilePhoneValidator validator = MobilePhoneValidator();

  Map<String, bool> isValidTests = <String, bool>{
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
    '99999999999': true,
    '99099999999': false,
    '09999999999': false,
    '90999999999': false,
    '999999999999': false,
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
    '(99) 99999-9999': true,
    '(99) 09999-9999': false,
    '(90) 99999-9999': false,
    '(09) 99999-9999': false,
  };

  group(
    'MobilePhoneValidator isValid',
    () {
      for (MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  Map<String, String> formatTests = <String, String>{
    '': '',
    ' ': '',
    '!': '',
    '9999999999': '9999999999',
    '(99) 99999-999': '9999999999',
    '99999999999': '(99) 99999-9999',
    '(99) 99999-9999': '(99) 99999-9999',
  };

  group(
    'MobilePhoneValidator format',
    () {
      for (MapEntry<String, String> input in formatTests.entries) {
        test(
          'Testing ${input.key}',
          () => expect(validator.format(input.key), input.value),
        );
      }
    },
  );
}
