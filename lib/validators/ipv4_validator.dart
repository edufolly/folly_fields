import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class Ipv4Validator extends AbstractValidator<String>
    implements AbstractParser<String> {
  ///
  ///
  ///
  Ipv4Validator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '###############',
              filter: <String, RegExp>{
                '#': RegExp('[0-9.]'),
              },
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
  bool isValid(String value) => valid(value) == null;

  ///
  ///
  ///
  @override
  String? parse(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    List<String> parts = value.split('.');

    if (parts.length != 4) {
      return null;
    }

    for (String part in parts) {
      int? octet = int.tryParse(part);
      if (octet == null || octet < 0 || octet > 255) {
        return null;
      }
    }

    return value;
  }

  ///
  ///
  ///
  @override
  String? valid(String? value) =>
      parse(value) == null ? 'IPv4 inválido.' : null;
}
