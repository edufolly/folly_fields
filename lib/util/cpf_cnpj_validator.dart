import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

///
///
/// TODO - Criar classe abstrata para manter o padrão da validação.
class CpfCnpjValidator {
  static const String STRIP_REGEX = r'[^\d]';

  ///
  ///
  ///
  static String format(String value) {
    String stripped = strip(value);

    if (stripped.length > 11) {
      return CNPJValidator.format(value);
    }

    return CPFValidator.format(value);
  }

  ///
  ///
  ///
  static String strip(String value) {
    RegExp regex = RegExp(STRIP_REGEX);
    value = value ?? '';

    return value.replaceAll(regex, '');
  }

  ///
  ///
  ///
  static bool isValid(String value) {
    value = strip(value);

    if (value == null || value.isEmpty) {
      return false;
    }

    if (value.length > 11) {
      return CNPJValidator.isValid(value, false);
    }

    return CPFValidator.isValid(value, false);
  }
}
