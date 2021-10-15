import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class ColorValidator extends AbstractValidator<Color>
    implements AbstractParser<Color> {
  ///
  ///
  ///
  ColorValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: 'AAAAAAAA',
              filter: <String, RegExp>{
                'A': RegExp('[0-9,A-F,a-f]'),
              },
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(Color value) => value.value.toRadixString(16).toUpperCase();

  ///
  ///
  ///
  @override
  String strip(String value) => value;

  ///
  ///
  ///
  @override
  bool isValid(String value) => valid(value) == null;

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.text;

  ///
  ///
  ///
  @override
  Color? parse(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    } else {
      text = text.replaceAll('#', '').trim().toUpperCase();
      if (text.length == 6) {
        text = 'FF$text';
      }
      try {
        return Color(int.parse('0x$text'));
      } catch (e) {
        return null;
      }
    }
  }

  ///
  ///
  ///
  @override
  String? valid(String? value) => parse(value) == null ? 'Cor inválida.' : null;
}
