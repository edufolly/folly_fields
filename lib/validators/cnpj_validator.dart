import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class CnpjValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CnpjValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '##.###.###/####-##',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => CNPJValidator.format(value);

  ///
  ///
  ///
  @override
  bool isValid(String value) => CNPJValidator.isValid(value, true);

  ///
  ///
  ///
  static String generate({bool format = false}) =>
      CNPJValidator.generate(format);
}
