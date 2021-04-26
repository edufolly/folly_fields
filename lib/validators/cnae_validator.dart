import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class CnaeValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CnaeValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '####-#/##',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => strip(value).replaceAllMapped(
        RegExp(r'^(\d{4})(\d{1})(\d{2})$'),
        (Match m) => '${m[1]}-${m[2]}/${m[3]}',
      );

  ///
  ///
  ///
  @override
  bool isValid(String cnae) => strip(cnae).length == 7;
}
