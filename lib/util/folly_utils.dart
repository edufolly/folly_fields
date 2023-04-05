// ignore_for_file: prefer-first

import 'package:flutter/material.dart';
import 'package:folly_fields/util/date_time_extension.dart';

///
///
///
class FollyUtils {
  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('Prefer to use DateTime.time. '
      'This class will be removed in version 1.0.0.')
  static TimeOfDay? getTime(DateTime? dateTime) => dateTime?.time;

  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('Prefer to use DateTime.mergeStartSeconds '
      'This class will be removed in version 1.0.0.')
  static DateTime? dateTimeMergeStart({
    required DateTime? date,
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  }) =>
      date?.mergeStartSeconds(
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      );

  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('Prefer to use DateTime.mergeStart '
      'This class will be removed in version 1.0.0.')
  static DateTime? dateMergeStart({
    required DateTime? date,
    TimeOfDay time = const TimeOfDay(hour: 0, minute: 0),
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  }) =>
      date?.mergeStart(
        time: time,
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      );

  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('Prefer to use DateTime.mergeEndSeconds '
      'This class will be removed in version 1.0.0.')
  static DateTime? dateTimeMergeEnd({
    required DateTime? date,
    int second = 59,
    int millisecond = 999,
    int microsecond = 0,
  }) =>
      date?.mergeEndSeconds(
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      );

  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('Prefer to use DateTime.mergeEnd '
      'This class will be removed in version 1.0.0.')
  static DateTime? dateMergeEnd({
    required DateTime? date,
    TimeOfDay time = const TimeOfDay(hour: 23, minute: 59),
    int second = 59,
    int millisecond = 999,
    int microsecond = 0,
  }) =>
      date?.mergeEnd(
        time: time,
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      );

  ///
  ///
  ///
  static String? validDate(String value) {
    if (value.isEmpty) {
      return 'Informe uma data.';
    }

    List<String> parts = value.split('/');

    if (parts.length != 3) {
      return 'Data inválida.';
    }

    if (parts[2].length != 4) {
      return 'Ano inválido.';
    }

    int? year = int.tryParse(parts[2]);
    if (year == null) {
      return 'Ano inválido.';
    }

    int? month = int.tryParse(parts[1]);
    if (month == null || month < 1 || month > 12) {
      return 'Mês inválido.';
    }

    int? day = int.tryParse(parts[0]);
    if (day == null || day < 1 || day > DateTime(year, month).daysInMonth) {
      return 'Dia inválido.';
    }

    return null;
  }

  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('Prefer to use DateTime.daysInMonth '
      'This class will be removed in version 1.0.0.')
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      return (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
          ? 29
          : 28;
    }
    List<int> days = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    return days[month - 1];
  }

  ///
  ///
  ///
  static String? validTime(String value) {
    if (value.length != 5) {
      return 'Informe uma hora.';
    }

    List<String> parts = value.split(':');

    if (parts.length != 2) {
      return 'Hora inválida.';
    }

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

  ///
  ///
  ///
  static bool isPascalCase(String value) =>
      !(value.isEmpty ||
          value.contains(RegExp('[^a-zA-Z0-9]+')) ||
          value.startsWith(RegExp('[0-9]+'))) &&
      value[0].toUpperCase() == value[0];

  ///
  ///
  ///
  static bool isCamelCase(String value) =>
      !(value.isEmpty ||
          value.contains(RegExp('[^a-zA-Z0-9]+')) ||
          value.startsWith(RegExp('[0-9]+'))) &&
      value[0].toLowerCase() == value[0];

  ///
  ///
  ///
  static bool isSnakeCase(String value) => !(value.isEmpty ||
      value.contains(RegExp('[^_a-z0-9]+')) ||
      value.startsWith(RegExp('[0-9]+')));

  ///
  ///
  ///
  static String camel2Snake(String camel, {bool internal = false}) =>
      internal || isCamelCase(camel)
          ? camel.splitMapJoin(
              RegExp('[A-Z]'),
              onMatch: (Match m) => '_${m.group(0)!.toLowerCase()}',
              onNonMatch: (String n) => n,
            )
          : '';

  ///
  ///
  ///
  static String snake2Camel(String snake) => isSnakeCase(snake)
      ? pascal2Camel(snake2Pascal(snake, internal: true), internal: true)
      : '';

  ///
  ///
  ///
  static String pascal2Camel(String pascal, {bool internal = false}) =>
      internal || isPascalCase(pascal)
          ? pascal[0].toLowerCase() + pascal.substring(1)
          : '';

  ///
  ///
  ///
  static String camel2Pascal(String camel) =>
      isCamelCase(camel) ? camel[0].toUpperCase() + camel.substring(1) : '';

  ///
  ///
  ///
  static String pascal2Snake(String pascal) => isPascalCase(pascal)
      ? camel2Snake(pascal, internal: true).substring(1)
      : '';

  ///
  ///
  ///
  static String snake2Pascal(String snake, {bool internal = false}) =>
      internal || isSnakeCase(snake)
          ? snake.toLowerCase().splitMapJoin(
                RegExp('_'),
                onMatch: (Match m) => '',
                onNonMatch: (String n) =>
                    n.substring(0, 1).toUpperCase() + n.substring(1),
              )
          : '';

  ///
  ///
  ///
  static Color textColorByLuminance(
    Color color, {
    Color darkColor = Colors.black,
    Color lightColor = Colors.white,
    double redFactor = 0.299,
    double greenFactor = 0.587,
    double blueFactor = 0.114,
    double threshold = 186,
  }) =>
      color.red * redFactor +
                  color.green * greenFactor +
                  color.blue * blueFactor >
              threshold
          ? darkColor
          : lightColor;

  ///
  ///
  ///
  static MaterialColor? createMaterialColor({
    int? intColor,
    Color? color,
  }) {
    if (intColor != null) {
      color = Color(intColor);
    }

    if (color == null) {
      return null;
    }

    return MaterialColor(
      color.value,
      <int, Color>{
        50: color,
        100: color,
        200: color,
        300: color,
        400: color,
        500: color,
        600: color,
        700: color,
        800: color,
        900: color,
      },
    );
  }
}
