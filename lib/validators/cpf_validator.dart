import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class CpfValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CpfValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '###.###.###-##',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => CPFValidator.format(value);

  ///
  ///
  ///
  @override
  bool isValid(String value) => CPFValidator.isValid(value, true);

  ///
  ///
  ///
  static String generate({bool format = false}) =>
      CPFValidator.generate(format);
}
