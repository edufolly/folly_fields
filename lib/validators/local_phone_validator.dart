import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class LocalPhoneValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  LocalPhoneValidator()
      : super(
          <TextInputFormatter>[
            ChangeMask(
              firstMask: '####-####',
              secondMask: '#####-####',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => strip(value).replaceAllMapped(
        RegExp(r'^(\d{4,5})(\d{4})$'),
        (Match m) => '${m[1]}-${m[2]}',
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

    /// phone must have 10 or 11 chars
    if (value.length < 8 || value.length > 9) {
      return false;
    }

    /// Números de 9 dígitos sempre iniciam com 9.
    return !(value.length == 9 && value[0] != '9');
  }
}
