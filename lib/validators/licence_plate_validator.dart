import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class LicencePlateValidator extends AbstractValidator<String> {
  LicencePlateValidator()
    : super(<TextInputFormatter>[
        UppercaseMask(
          mask: 'AAA-9#99',
          filter: <String, RegExp>{
            'A': RegExp('[a-zA-Z]'),
            '9': RegExp('[0-9]'),
            '#': RegExp('[a-zA-Z0-9]'),
          },
        ),
      ]);

  @override
  String? format(final String? value) => strip(value)?.replaceAllMapped(
    RegExp(r'^([A-Z]{3})([0-9])([A-Z0-9])([0-9]{2})$'),
    (final Match m) => '${m[1]}-${m[2]}${m[3]}${m[4]}',
  );

  @override
  String? strip(final String? value) =>
      value?.replaceAll(RegExp('[^A-Z0-9]'), '');

  @override
  bool isValid(final String? value) {
    String? v = strip(value);

    if (v == null || v.length != 7) {
      return false;
    }

    return format(v)?.length == 8;
  }
}
