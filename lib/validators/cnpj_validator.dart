import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class CnpjValidator extends AbstractValidator<String> {
  CnpjValidator()
    : super(<TextInputFormatter>[
        MaskTextInputFormatter(mask: '##.###.###/####-##'),
      ]);

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  String? format(String? value) => value?.let(CNPJValidator.format);

  @override
  bool isValid(String? value) => value?.let(CNPJValidator.isValid) ?? false;

  static String generate({bool format = false}) =>
      CNPJValidator.generate(format);

  static String parse(String value) => CNPJValidator.format(value);
}
