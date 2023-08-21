import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

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
  String format(String value) => (strip(value).length > 11)
      ? CNPJValidator.format(value)
      : CPFValidator.format(value);

  ///
  ///
  ///
  @override
  bool isValid(String value) {
    String v = strip(value);

    if (v.isEmpty) {
      return false;
    }

    return (v.length > 11)
        ? CNPJValidator.isValid(v, false)
        : CPFValidator.isValid(v, false);
  }

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.number;
}
