import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/cep_validator.dart';

///
///
///
void main() {
  group(
    'CepValidator isValid',
    () {
      Map<String, bool> domain = <String, bool>{
        '': false,
        ' ': false,
        '0': false,
        '1': false,
        '_': false,
        '!': false,
        '@': false,
        'a': false,
        'á': false,
        '00': false,
        '000': false,
        '0000': false,
        '00000': false,
        '000000': false,
        '0000000': false,
        '00000000': true,
        '________': false,
        '000000000': false,
        '00.000-000': true,
        '00.000000': true,
        '00000-000': true,
        'A0.000-000': false,
        'AA.AAA-AAA': false,
        'AAAAAAAA': false,
      };

      CepValidator validator = CepValidator();

      for (final MapEntry<String, bool>(
            :String key,
            :bool value,
          ) in domain.entries) {
        test(
          'Testing: $key',
          () => expect(validator.isValid(key), value),
        );
      }
    },
  );

  group(
    'CepValidator format',
    () {
      Map<String, String> domain = <String, String>{
        '': '',
        ' ': '',
        '!': '',
        '00000000': '00.000-000',
        '28660123': '28.660-123',
      };

      CepValidator validator = CepValidator();

      for (final MapEntry<String, String>(
            :String key,
            :String value,
          ) in domain.entries) {
        test(
          'Testing $key',
          () => expect(validator.format(key), value),
        );
      }
    },
  );

  group('CepValidator Coverage', () {
    CepValidator validator = CepValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
