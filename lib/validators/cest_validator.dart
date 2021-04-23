import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class CestValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CestValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '##.###.##',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => strip(value).replaceAllMapped(
        RegExp(r'^(\d{2})(\d{3})(\d{2})$'),
        (Match m) => '${m[1]}.${m[2]}.${m[3]}',
      );

  ///
  ///
  ///
  @override
  bool isValid(String cest) => strip(cest).length == 7;
}
