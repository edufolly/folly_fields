import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class CnaeValidator extends AbstractValidator<String> {
  CnaeValidator()
    : super(<TextInputFormatter>[MaskTextInputFormatter(mask: '####-#/##')]);

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  String? format(final String? value) => strip(value)?.replaceAllMapped(
    RegExp(r'^(\d{4})(\d)(\d{2})$'),
    (final Match m) => '${m[1]}-${m[2]}/${m[3]}',
  );

  @override
  bool isValid(final String? value) => strip(value)?.length == 7;
}
