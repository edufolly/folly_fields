import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class LocalPhoneValidator extends AbstractValidator<String> {
  LocalPhoneValidator()
    : super(<TextInputFormatter>[
        ChangeMask(firstMask: '####-####', secondMask: '#####-####'),
      ]);

  @override
  String format(final String value) => strip(value).replaceAllMapped(
    RegExp(r'^(\d{4,5})(\d{4})$'),
    (final Match m) => '${m[1]}-${m[2]}',
  );

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  bool isValid(final String value) {
    String v = strip(value);

    /// phone must have 10 or 11 chars
    if (v.length < 8 || v.length > 9) {
      return false;
    }

    /// Números de 9 dígitos sempre iniciam com 9.
    return !(v.length == 9 && v[0] != '9');
  }
}
