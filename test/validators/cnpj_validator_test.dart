import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';

///
///
///
void main() {
  CnpjValidator validator = CnpjValidator();

  Map<String, bool> isValidTests = <String, bool>{
    '00000000000000': false,
    '11111111111111': false,
    '22222222222222': false,
    '33333333333333': false,
    '44444444444444': false,
    '55555555555555': false,
    '66666666666666': false,
    '77777777777777': false,
    '88888888888888': false,
    '99999999999999': false,
    'AAAAAAAAAAAAAA': false,
    '0': false,
    '01': false,
    '012': false,
    '0123': false,
    '01234': false,
    '012345': false,
    '0123456': false,
    '01234567': false,
    '012345678': false,
    '0123456789': false,
    '01234567890': false,
    '012345678901': false,
    '0123456789012': false,
    '01234567890123': false,
    '012345678901234': false,
    '12.175.094/0001-19': true,
    '12.175.094/0001-18': false,
    '17942159000128': true,
    '17942159000129': false,
    '017942159000128': false,
  };

  for (int i = 0; i < 10; i++) {
    isValidTests[CnpjValidator.generate()] = true;
    isValidTests[CnpjValidator.generate(format: true)] = true;
  }

  group(
    'CnpjValidator isValid',
    () {
      for (MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  Map<String, String> formatTests = <String, String>{};

  for (int i = 0; i < 10; i++) {
    String formatted = CnpjValidator.generate(format: true);
    String striped = validator.strip(formatted);
    formatTests[striped] = formatted;
  }

  group(
    'CnpjValidator format',
    () {
      for (MapEntry<String, String> input in formatTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.format(input.key), input.value),
        );
      }
    },
  );
}
