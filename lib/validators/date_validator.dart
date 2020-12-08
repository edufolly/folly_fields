import 'package:flutter/material.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

///
///
///
class DateValidator extends AbstractValidator<DateTime>
    implements AbstractTimeParser<DateTime> {
  final dynamic locale;

  ///
  ///
  ///
  DateValidator({
    this.locale = 'pt_br',
  }) : super(
          MaskTextInputFormatter(
            mask: '##/##/####',
          ),
        );

  ///
  ///
  ///
  @override
  String format(DateTime value) =>
      value == null ? '' : DateFormat.yMd(locale).format(value);

  ///
  ///
  ///
  @override
  String strip(String value) => value;

  ///
  ///
  ///
  @override
  bool isValid(String value, {bool stripBeforeValidation = true}) =>
      valid(value) == null;

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.datetime;

  ///
  ///
  ///
  @override
  DateTime parse(String text) =>
      isValid(text) ? DateFormat.yMd(locale).parse(text) : null;

  ///
  ///
  ///
  @override
  String valid(String value) {
    if (value.isEmpty) return 'Data vazia';

    List<String> parts = value.split('/');

    if (parts.length != 3) return 'Data inválida';

    if (parts[2].length != 4) return 'Ano inválido';

    int year = int.tryParse(parts[2]);
    if (year == null) return 'Ano inválido';

    int month = int.tryParse(parts[1]);
    if (month == null || month < 1 || month > 12) return 'Mês inválido';

    int day = int.tryParse(parts[0]);
    if (day == null || day < 1 || day > getDaysInMonth(year, month)) {
      return 'Dia inválido';
    }

    return null;
  }

  ///
  ///
  ///
  int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      return (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
          ? 29
          : 28;
    }
    List<int> _days = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return _days[month - 1];
  }

  ///
  ///
  ///
  String fullFormat(DateTime dateTime) =>
      DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);

  ///
  ///
  ///
  static DateTime mergeStart({
    @required DateTime date,
    TimeOfDay time = const TimeOfDay(hour: 0, minute: 0),
  }) =>
      DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        0,
        0,
      );

  ///
  ///
  ///
  static DateTime mergeEnd({
    @required DateTime date,
    TimeOfDay time = const TimeOfDay(hour: 23, minute: 59),
  }) =>
      DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        59,
        999,
      );
}
