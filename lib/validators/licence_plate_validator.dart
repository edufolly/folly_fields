import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class LicencePlateValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  LicencePlateValidator()
      : super(
          <TextInputFormatter>[
            UppercaseMask(
              mask: 'AAA-9##9',
              filter: <String, RegExp>{
                'A': RegExp('[a-zA-Z]'),
                '9': RegExp('[0-9]'),
                '#': RegExp('[a-zA-Z0-9]'),
              },
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String value) => strip(value).replaceAllMapped(
        RegExp(r'^([A-Z]{3})([0-9])([A-Z0-9]{2})([0-9])$'),
        (Match m) => '${m[1]}-${m[2]}${m[3]}${m[4]}',
      );

  ///
  ///
  ///
  @override
  String strip(String value) => value.replaceAll(RegExp('[^A-Z0-9]'), '');

  ///
  ///
  ///
  @override
  bool isValid(String value) {
    if (value.isEmpty) {
      return false;
    }

    value = strip(value);

    if (value.length != 7) {
      return false;
    }

    return format(value).length == 8;
  }
}
