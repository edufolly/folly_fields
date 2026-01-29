import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/cpf_cnpj_validator.dart';

void main() {
  group('CpfCnpjValidator Coverage', () {
    CpfCnpjValidator validator = CpfCnpjValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
