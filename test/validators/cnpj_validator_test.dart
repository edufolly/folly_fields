import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/cnpj_validator.dart';

///
///
///
void main() {
  group(
    'CnpjValidator isValid',
    () {
      final Map<String, bool> domain = <String, bool>{
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

      for (int gen = 0; gen < 10; gen++) {
        domain[CnpjValidator.generate()] = true;
        domain[CnpjValidator.generate(format: true)] = true;
      }

      final CnpjValidator validator = CnpjValidator();

      for (final MapEntry<String, bool> input in domain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  group(
    'CnpjValidator format',
    () {
      final Map<String, String> domain = <String, String>{};

      final CnpjValidator validator = CnpjValidator();

      for (int gen = 0; gen < 10; gen++) {
        final String formatted = CnpjValidator.generate(format: true);
        final String striped = validator.strip(formatted);
        domain[striped] = formatted;
      }

      for (final MapEntry<String, String> input in domain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.format(input.key), input.value),
        );
      }
    },
  );

  group('CnpjValidator Coverage', () {
    final CnpjValidator validator = CnpjValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
