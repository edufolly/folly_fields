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
  Color? parse(String? text, [int? defaultColor]) {
    if (text == null || text.isEmpty) {
      return defaultColor == null ? null : Color(defaultColor);
    } else {
      try {
        if (!text.startsWith('0x')) {
          text = text.replaceAll('#', '').trim().toUpperCase();

          if (text.length == 3) {
            text = text[0] + text[0] + text[1] + text[1] + text[2] + text[2];
          }

          if (text.length == 4) {
            text = text[0] +
                text[0] +
                text[1] +
                text[1] +
                text[2] +
                text[2] +
                text[3] +
                text[3];
          }

          if (text.length == 6) {
            text = 'FF$text';
          }

          if(text.length > 8) {
            text = text.substring(0, 8);
          }

          text = '0x$text';
        }

        return Color(int.parse(text));
      } on Exception catch (_) {
        return defaultColor == null ? null : Color(defaultColor);
      }
    }
  }

  ///
  ///
  ///
  @override
  String? valid(String? value) => parse(value) == null ? 'Cor inválida.' : null;
}
