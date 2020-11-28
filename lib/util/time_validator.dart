import 'package:flutter/material.dart';

///
///
///
class TimeValidator {
  ///
  ///
  ///
  static String format(TimeOfDay time) {
    return time.hour.toString().padLeft(2, '0') +
        ':' +
        time.minute.toString().padLeft(2, '0');
  }

  ///
  ///
  ///
  static String formatDateTime(DateTime dateTime) {
    return format(TimeOfDay.fromDateTime(dateTime));
  }

  ///
  ///
  ///
  static String valid(String value) {
    if (value.isEmpty) return 'Hora vazia';

    List<String> parts = value.split(':');

    if (parts.length != 2) return 'Hora inválida';

    int hour = int.tryParse(parts[0]);

    if (hour == null || hour < 0 || hour > 23) {
      return 'Horas inválidas';
    }

    int minute = int.tryParse(parts[1]);

    if (minute == null || minute < 0 || minute > 59) {
      return 'Minutos inválidos';
    }

    return null;
  }

  ///
  ///
  ///
  static bool isValid(String value) => valid(value) == null;

  ///
  ///
  ///
  static TimeOfDay parse(String value) {
    if (isValid(value)) {
      List<String> parts = value.split(':');
      return TimeOfDay(
        hour: int.tryParse(parts[0]),
        minute: int.tryParse(parts[1]),
      );
    }
    return null;
  }
}
