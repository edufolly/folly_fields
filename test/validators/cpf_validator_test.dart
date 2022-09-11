import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/cpf_validator.dart';

///
///
///
void main() {
  CpfValidator validator = CpfValidator();

  Map<String, bool> isValidTests = <String, bool>{
    '00000000000': false,
    '11111111111': false,
    '22222222222': false,
    '33333333333': false,
    '44444444444': false,
    '55555555555': false,
    '66666666666': false,
    '77777777777': false,
    '88888888888': false,
    '99999999999': false,
    '12345678909': false,
    'AAAAAAAAAAA': false,
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
    '01234567891': false,
    '334.616.710-02': true,
    '334.616.710-01': false,
    '3346167100': false,
    '33461671001': false,
    '33461671002': true,
    '33461671003': false,
    '3346167100A': false,
    '!3461671002': false,
  };

  for (int i = 0; i < 50; i++) {
    isValidTests[CpfValidator.generate()] = true;
    isValidTests[CpfValidator.generate(format: true)] = true;
  }

  group(
    'CpfValidator isValid',
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
    String formatted = CpfValidator.generate(format: true);
    String striped = validator.strip(formatted);
    formatTests[striped] = formatted;
  }

  group(
    'CpfValidator format',
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
