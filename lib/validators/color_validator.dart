import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class ColorValidator extends AbstractParserValidator<Color> {
  ColorValidator()
    : super(<TextInputFormatter>[
        MaskTextInputFormatter(
          mask: 'AAAAAAAA',
          filter: <String, RegExp>{'A': RegExp('[0-9,A-F,a-f]')},
        ),
      ]);

  @override
  String format(final Color? value) => value?.let(FollyUtils.colorHex) ?? '';

  @override
  String? strip(final String? value) => value;

  @override
  bool isValid(final String? value) => valid(value) == null;

  @override
  Color? parse(final String? text) => FollyUtils.colorParse(text);

  @override
  String? valid(final String? value) =>
      parse(value) == null ? 'Cor inválida.' : null;
}
