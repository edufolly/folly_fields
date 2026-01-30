import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class CpfCnpjValidator extends AbstractValidator<String> {
  CpfCnpjValidator()
    : super(<TextInputFormatter>[
        ChangeMask(
          firstMask: '###.###.###-##',
          secondMask: '##.###.###/####-##',
        ),
      ]);

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  String? format(final String? value) => strip(value)?.let(
    (final String it) =>
        it.length > 11 ? CNPJValidator.format(it) : CPFValidator.format(it),
  );

  @override
  bool isValid(final String? value) =>
      strip(value)
          .takeUnless(isNull)
          ?.let(
            (final String it) => it.length > 11
                ? CNPJValidator.isValid(it, false)
                : CPFValidator.isValid(it, false),
          ) ??
      false;
}
