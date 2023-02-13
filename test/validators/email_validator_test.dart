import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/email_validator.dart';

///
///
///
void main() {
  EmailValidator validator = EmailValidator();

  Map<String, bool> isValidTests = <String, bool>{
    'email@example.com': true,
    'firstname.lastname@example.com': true,
    'email@subdomain.example.com': true,
    'firstname+lastname@example.com': true,
    // 'email@123.123.123.123': true,
    'email@[123.123.123.123]': true,
    '"email"@example.com': true,
    '1234567890@example.com': true,
    'email@example-one.com': true,
    '_______@example.com': true,
    'email@example.name': true,
    'email@example.museum': true,
    'email@example.co.jp': true,
    'firstname-lastname@example.com': true,
    'plainaddress': false,
    r'#@%^%#$@#$@#.com': false,
    '@example.com': false,
    'Joe Smith <email@example.com>': false,
    'email.example.com': false,
    'email@example@example.com': false,
    '    .email@example.com': false,
    'email.@example.com': false,
    'email..email@example.com': false,
    // 'あいうえお@example.com': false,
    'email@example.com (Joe Smith)': false,
    'email@example': false,
    'email@-example.com': false,
    // 'email@example.web': false,
    'email@111.222.333.44444': false,
    'email@example..com': false,
    'Abc..123@example.com': false,
  };

  group(
    'EmailValidator isValid',
    () {
      for (final MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );
}
