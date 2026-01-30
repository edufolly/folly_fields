import 'dart:math';

import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class MacAddressValidator extends AbstractValidator<String> {
  MacAddressValidator()
    : super(<TextInputFormatter>[
        UppercaseMask(
          mask: '##:##:##:##:##:##',
          filter: <String, RegExp>{'#': RegExp('[a-fA-F0-9]')},
        ),
      ]);

  @override
  String? format(final String? value) => strip(value)?.replaceAllMapped(
    RegExp(
      '^([A-F0-9]{2})([A-F0-9]{2})([A-F0-9]{2})'
      r'([A-F0-9]{2})([A-F0-9]{2})([A-F0-9]{2})$',
    ),
    (final Match m) => '${m[1]}:${m[2]}:${m[3]}:${m[4]}:${m[5]}:${m[6]}',
  );

  @override
  String? strip(final String? value) =>
      value?.replaceAll(RegExp('[^A-F0-9]'), '');

  @override
  bool isValid(final String? value) {
    String? v = strip(value);

    if (v == null || v.length != 12) {
      return false;
    }

    return format(v)?.length == 17;
  }

  static final Random _random = Random();

  static String generate() => List<String>.generate(
    17,
    (final int index) =>
        (index + 1) % 3 == 0 ? ':' : _random.nextInt(16).toRadixString(16),
  ).join().toUpperCase();
}
