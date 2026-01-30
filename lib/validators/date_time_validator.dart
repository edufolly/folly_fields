import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:intl/intl.dart';

class DateTimeValidator extends AbstractParserValidator<DateTime> {
  final String locale;
  final String dateFormat;

  DateTimeValidator({
    this.locale = 'pt_br',
    this.dateFormat = 'dd/MM/yyyy HH:mm',
    final String mask = 'B#/D#/#### A#:C#',
  }) : super(<TextInputFormatter>[
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
       ]);

  @override
  TextInputType get keyboard => TextInputType.datetime;

  @override
  String? format(final DateTime? value) =>
      value?.let(DateFormat(dateFormat, locale).format);

  @override
  String? strip(final String? value) => value;

  @override
  bool isValid(final String? value) => valid(value) == null;

  @override
  DateTime? parse(final String? text) {
    if (text != null && isValid(text)) {
      try {
        return DateFormat(dateFormat, locale).parse(text);
      } on Exception catch (_) {
        // Do nothing
      }
    }

    return null;
  }

  @override
  String? valid(final String? value) {
    if (value == null || value.isEmpty) {
      return 'Data e Hora inválidas.';
    }

    List<String> parts = value.split(' ');

    if (parts.length != 2) {
      return 'Partes da Data e Hora inválidas.';
    }

    return FollyUtils.validDate(parts.first) ??
        FollyUtils.validTime(parts.last);
  }
}
