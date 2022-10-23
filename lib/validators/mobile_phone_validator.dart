import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class MobilePhoneValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  MobilePhoneValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '(##) #####-####',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => strip(value).replaceAllMapped(
        RegExp(r'^(\d{2})(\d{5})(\d{4})$'),
        (Match m) => '(${m[1]}) ${m[2]}-${m[3]}',
      );

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.number;

  ///
  ///
  ///
  @override
  bool isValid(String value) {
    value = strip(value);

    /// phone must be defined
    if (value.isEmpty) {
      return false;
    }

    /// Não existe DDD com zero.
    if (value[0] == '0' || value[1] == '0') {
      return false;
    }

    /// Telefones celulares sempre iniciam com 9.
    return !(value.length == 11 && value[2] != '9');
  }
}
