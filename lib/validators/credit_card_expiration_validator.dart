import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/folly_date_time_extension.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class CreditCardExpirationValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  CreditCardExpirationValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '##/##',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => value;

  ///
  ///
  ///
  @override
  String strip(String value) => value;

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
    String v = value.replaceAll(RegExp(r'\D'), '');

    if (v.length != 4) {
      return false;
    }

    int? monthNum = int.tryParse(v.substring(0, 2));
    if (monthNum == null || monthNum < 1 || monthNum > 12) {
      return false;
    }

    int? yearNum = int.tryParse(v.substring(2));

    if (yearNum == null) {
      return false;
    }

    yearNum += 2000;

    return DateTime(yearNum, monthNum).isAfter(DateTime.now().monthFirstDay);
  }
}
