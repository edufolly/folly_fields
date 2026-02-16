import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class CpfValidator extends AbstractValidator<String> {
  CpfValidator()
    : super(<TextInputFormatter>[
        MaskTextInputFormatter(mask: '###.###.###-##'),
      ]);

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  String? format(String? value) => value?.let(CPFValidator.format);

  @override
  bool isValid(String? value) => value?.let(CPFValidator.isValid) ?? false;

  static String generate({bool format = false}) =>
      CPFValidator.generate(format);

  static String parse(String value) => CPFValidator.format(value);
}
