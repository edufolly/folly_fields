import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class CpfCnpjValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CpfCnpjValidator()
      : super(
          <TextInputFormatter>[
            ChangeMask(
              firstMask: '###.###.###-##',
              secondMask: '##.###.###/####-##',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) {
    String stripped = strip(value);

    return (stripped.length > 11)
        ? CNPJValidator.format(value)
        : CPFValidator.format(value);
  }

  ///
  ///
  ///
  @override
  bool isValid(String value) {
    value = strip(value);

    if (value.isEmpty) {
      return false;
    }

    return (value.length > 11)
        ? CNPJValidator.isValid(value, false)
        : CPFValidator.isValid(value, false);
  }
}
