import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

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
        RegExp(r'^(\d{4})(\d)(\d{2})$'),
        (Match m) => '${m[1]}-${m[2]}/${m[3]}',
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
  bool isValid(String value) => strip(value).length == 7;
}
