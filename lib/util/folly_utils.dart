import 'package:flutter/material.dart';

///
///
///
class FollyUtils {
  ///
  ///
  ///
  static DateTime dateMergeStart({
    required DateTime date,
    TimeOfDay time = const TimeOfDay(hour: 0, minute: 0),
    int second = 0,
    int millisecond = 0,
  }) =>
      DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        second,
        millisecond,
      );

  ///
  ///
  ///
  static DateTime dateMergeEnd({
    required DateTime date,
    TimeOfDay time = const TimeOfDay(hour: 23, minute: 59),
    int second = 59,
    int millisecond = 999,
  }) =>
      DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
        second,
        millisecond,
      );

  ///
  ///
  ///
  static String? validDate(String value) {
    if (value.isEmpty) return 'Informe uma data.';

    List<String> parts = value.split('/');

    if (parts.length != 3) return 'Data inválida.';

    if (parts[2].length != 4) return 'Ano inválido.';

    int? year = int.tryParse(parts[2]);
    if (year == null) return 'Ano inválido.';

    int? month = int.tryParse(parts[1]);
    if (month == null || month < 1 || month > 12) return 'Mês inválido.';

    int? day = int.tryParse(parts[0]);
    if (day == null || day < 1 || day > getDaysInMonth(year, month)) {
      return 'Dia inválido.';
    }

    return null;
  }

  ///
  ///
  ///
  static int getDaysInMonth(int year, int month) {
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
  static String? validTime(String value) {
    if (value.isEmpty) return 'Informe uma hora.';

    List<String> parts = value.split(':');

    if (parts.length != 2) return 'Hora inválida.';

    int? hour = int.tryParse(parts[0]);

    if (hour == null || hour < 0 || hour > 23) {
      return 'Horas inválidas.';
    }

    int? minute = int.tryParse(parts[1]);

    if (minute == null || minute < 0 || minute > 59) {
      return 'Minutos inválidos.';
    }

    return null;
  }
}
