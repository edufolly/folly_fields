import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class MobilePhoneValidator extends AbstractValidator<String> {
  MobilePhoneValidator()
    : super(<TextInputFormatter>[
        MaskTextInputFormatter(mask: '(##) #####-####'),
      ]);

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  String? format(final String? value) => strip(value)?.replaceAllMapped(
    RegExp(r'^(\d{2})(\d{5})(\d{4})$'),
    (final Match m) => '(${m[1]}) ${m[2]}-${m[3]}',
  );

  @override
  bool isValid(final String? value) {
    String? v = strip(value);

    /// phone must be defined
    if (v == null || v.length != 11) {
      return false;
    }

    /// Não existe DDD com zero.
    if (v[0] == '0' || v[1] == '0') {
      return false;
    }

    /// Telefones celulares sempre iniciam com 9.
    return v[2] == '9';
  }
}
