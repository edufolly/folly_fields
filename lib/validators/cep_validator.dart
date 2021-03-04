import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class CepValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CepValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '##.###-###',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => strip(value).replaceAllMapped(
        RegExp(r'^(\d{2})(\d{3})(\d{3})$'),
        (Match m) => '${m[1]}.${m[2]}-${m[3]}',
      );

  ///
  ///
  ///
  @override
  bool isValid(String cep) => (strip(cep).length == 8);
}
