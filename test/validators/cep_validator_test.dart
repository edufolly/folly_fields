import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/cep_validator.dart';

///
///
///
void main() {
  CepValidator validator = CepValidator();

  Map<String, bool> isValidTests = <String, bool>{
    '0': false,
    '00': false,
    '000': false,
    '0000': false,
    '00000': false,
    '000000': false,
    '0000000': false,
    '00000000': true,
    '000000000': false,
    '00.000-000': true,
    '00.000000': true,
    '00000-000': true,
    'A0.000-000': false,
    'AA.AAA-AAA': false,
    'AAAAAAAA': false,
  };

  group(
    'CepValidator isValid',
    () {
      for (MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  group('CepValidator format', () {
    test(
      'Testing 00000000',
      () => expect(validator.format('00000000'), '00.000-000'),
    );
  });
}
