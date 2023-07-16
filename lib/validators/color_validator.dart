import 'package:flutter/services.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class ColorValidator extends AbstractParserValidator<Color> {
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
  String format(Color value) => FollyUtils.colorHex(value);

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
  Color? parse(String? text, {Color? defaultColor, int? intColor}) =>
      FollyUtils.colorParse(
        text,
        defaultColor: defaultColor,
        intColor: intColor,
      );

  ///
  ///
  ///
  @override
  String? valid(String? value) => parse(value) == null ? 'Cor inválida.' : null;
}
