import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/local_phone_validator.dart';

///
///
///
void main() {
  LocalPhoneValidator validator = LocalPhoneValidator();

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
    '89999999': true,
    '99999999': true,
    '999999999': true,
    '199999999': false,
    '9999999999': false,
    '99999-': false,
    '99999-9': false,
    '99999-99': false,
    '99999-999': true,
    '9999-9999': true,
    '8999-9999': true,
    '99999-9999': true,
    '09999-9999': false,
  };

  group(
    'LocalPhoneValidator isValid',
    () {
      for (final MapEntry<String, bool> input in isValidTests.entries) {
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
    '9999999': '9999999',
    '99999999': '9999-9999',
    '999999999': '99999-9999',
    '9999999999': '9999999999',
    '8999-9999': '8999-9999',
    '9999-9999': '9999-9999',
    '89999-999': '8999-9999',
    '99999-999': '9999-9999',
    '99999-9999': '99999-9999',
  };

  group(
    'MobilePhoneValidator format',
    () {
      for (final MapEntry<String, String> input in formatTests.entries) {
        test(
          'Testing ${input.key}',
          () => expect(validator.format(input.key), input.value),
        );
      }
    },
  );

}
