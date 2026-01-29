import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class CpfValidator extends AbstractValidator<String> {
  CpfValidator()
    : super(<TextInputFormatter>[
        MaskTextInputFormatter(mask: '###.###.###-##'),
      ]);

  @override
  String format(final String value) => CPFValidator.format(value);

  @override
  bool isValid(final String value) => CPFValidator.isValid(value);

  @override
  TextInputType get keyboard => TextInputType.number;

  static String generate({final bool format = false}) =>
      CPFValidator.generate(format);
}
