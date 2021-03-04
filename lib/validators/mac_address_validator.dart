import 'dart:math';

import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class MacAddressValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  MacAddressValidator()
      : super(
          <TextInputFormatter>[
            UppercaseMask(
              mask: '##:##:##:##:##:##',
              filter: <String, RegExp>{
                '#': RegExp(r'[a-fA-F0-9]'),
              },
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(String macAddress) => strip(macAddress).replaceAllMapped(
        RegExp(r'^([A-F0-9]{2})([A-F0-9]{2})([A-F0-9]{2})'
            r'([A-F0-9]{2})([A-F0-9]{2})([A-F0-9]{2})$'),
        (Match m) => '${m[1]}:${m[2]}:${m[3]}:${m[4]}:${m[5]}:${m[6]}',
      );

  ///
  ///
  ///
  @override
  String strip(String value) => value.replaceAll(RegExp(r'[^A-F0-9]'), '');

  ///
  ///
  ///
  @override
  bool isValid(String value) {
    if (value.isEmpty || value.length != 17) return false;

    value = strip(value);

    if (value.isEmpty || value.length != 12) return false;

    return !value.contains(RegExp(r'[^A-F0-9]'));
  }

  static final Random _random = Random();

  ///
  ///
  ///
  static String generate() => List<String>.generate(
        17,
        (int index) =>
            (index + 1) % 3 == 0 ? ':' : _random.nextInt(16).toRadixString(16),
      ).join().toUpperCase();
}
