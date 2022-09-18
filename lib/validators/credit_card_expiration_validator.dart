import 'package:flutter/services.dart';
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
    value = value.replaceAll(RegExp(r'\D'), '');

    if (value.length != 4) {
      return false;
    }

    String month = value.substring(0, 2);

    int? m = int.tryParse(month);
    if (m == null || m < 1 || m > 12) {
      return false;
    }

    String year = value.substring(2);

    int? y = int.tryParse(year);
    if (y == null) {
      return false;
    }

    y += 2000;

    DateTime now = DateTime.now();

    DateTime base = DateTime(now.year, now.month);

    DateTime expiration = DateTime(y, m);

    return expiration.isAfter(base);
  }
}
