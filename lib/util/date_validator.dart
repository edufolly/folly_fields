import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
///
/// TODO - Criar classe abstrata para manter o padrão da validação.
class DateValidator {
  static const List<int> _months31 = <int>[1, 3, 5, 7, 8, 10, 12];
  static const List<int> _months30 = <int>[4, 6, 9, 11];

  ///
  ///
  ///
  static String format(
      DateTime datetime, {
        dynamic locale = 'pt_br',
      }) =>
      DateFormat.yMd(locale).format(datetime);

  ///
  ///
  ///
  static String fullFormat(DateTime dateTime) =>
      DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);

  ///
  ///
  ///
  static DateTime parse(
      String text, {
        dynamic locale = 'pt_br',
      }) {
    try {
      return DateFormat.yMd(locale).parse(text);
    } catch (e) {
      return null;
    }
  }

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

  ///
  ///
  ///
  static String valid(String value) {
    if (value.isEmpty) return 'Data vazia';

    List<String> parts = value.split('/');

    if (parts.length != 3) return 'Data inválida';

    if (parts[2].length != 4) return 'Ano inválido';

    int year = int.tryParse(parts[2]);
    if (year == null) return 'Ano inválido';

    int month = int.tryParse(parts[1]);
    if (month == null || month < 1 || month > 12) return 'Mês inválido';

    int day = int.tryParse(parts[0]);
    if (day == null) return 'Dia inválido';

    if (_months31.contains(month)) {
      if (day < 1 || day > 31) return 'Dia inválido';
    }

    if (_months30.contains(month)) {
      if (day < 1 || day > 30) return 'Dia inválido';
    }

    if (month == 2) {
      int max = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0 ? 29 : 28;
      if (day < 1 || day > max) return 'Dia inválido';
    }

    return null;
  }

  ///
  ///
  ///
  static bool isValid(String value) => valid(value) == null;
}
