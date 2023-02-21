import 'package:flutter/services.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:intl/intl.dart';

///
///
///
class DateTimeValidator extends AbstractParserValidator<DateTime> {
  final DateFormat dateFormat;

  ///
  ///
  ///
  DateTimeValidator({
    String locale = 'pt_br',
    String format = 'dd/MM/yyyy HH:mm',
    String mask = 'B#/D#/#### A#:C#',
  })  : dateFormat = DateFormat(format, locale),
        super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: mask,
              filter: <String, RegExp>{
                'A': RegExp('[0-2]'),
                'B': RegExp('[0-3]'),
                'C': RegExp('[0-5]'),
                'D': RegExp('[0-1]'),
                '#': RegExp('[0-9]'),
              },
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(DateTime value) => dateFormat.format(value);

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
  TextInputType get keyboard => TextInputType.datetime;

  ///
  ///
  ///
  @override
  DateTime? parse(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    } else {
      try {
        return dateFormat.parse(text);
      } on Exception catch (_) {
        return null;
      }
    }
  }

  ///
  ///
  ///
  @override
  String? valid(String value) {
    if (value.isEmpty) {
      return 'Data e Hora inválidas.';
    }

    List<String> p = value.split(' ');

    if (p.length != 2) {
      return 'Partes da Data e Hora inválidas.';
    }

    return FollyUtils.validDate(p.first) ?? FollyUtils.validTime(p.last);
  }
}
