import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class Ipv4Validator extends AbstractParserValidator<String> {
  Ipv4Validator()
    : super(<TextInputFormatter>[
        MaskTextInputFormatter(
          mask: '###############',
          filter: <String, RegExp>{'#': RegExp('[0-9.]')},
        ),
      ]);

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  String? format(final String? value) => value;

  @override
  String? strip(final String? value) => value;

  @override
  bool isValid(final String? value) =>
      value?.let((final String it) => isNull(valid(it))) ?? false;

  @override
  String? parse(final String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    List<String> parts = value.split('.');

    if (parts.length != 4) {
      return null;
    }

    for (final String part in parts) {
      int? octet = int.tryParse(part);
      if (octet == null || octet < 0 || octet > 255) {
        return null;
      }
    }

    return value;
  }

  @override
  String? valid(final String? value) =>
      parse(value) == null ? 'IPv4 inválido.' : null;
}
