import 'package:flutter/material.dart';
import 'package:folly_fields/util/folly_date_time_extension.dart';

///
///
///
class FollyUtils {
  ///
  ///
  ///
  static String? validDate(String value) {
    if (value.isEmpty) {
      return 'Informe uma data.';
    }

    final List<String> parts = value.split('/');

    if (parts.length != 3) {
      return 'Data inválida.';
    }

    if (parts[2].length != 4) {
      return 'Ano inválido.';
    }

    final int? year = int.tryParse(parts[2]);
    if (year == null) {
      return 'Ano inválido.';
    }

    final int? month = int.tryParse(parts[1]);
    if (month == null || month < 1 || month > 12) {
      return 'Mês inválido.';
    }

    final int? day = int.tryParse(parts[0]);
    if (day == null || day < 1 || day > DateTime(year, month).daysInMonth) {
      return 'Dia inválido.';
    }

    return null;
  }

  ///
  ///
  ///
  static String? validTime(String value) {
    if (value.length != 5) {
      return 'Informe uma hora.';
    }

    final List<String> parts = value.split(':');

    if (parts.length != 2) {
      return 'Hora inválida.';
    }

    final int? hour = int.tryParse(parts[0]);

    if (hour == null || hour < 0 || hour > 23) {
      return 'Horas inválidas.';
    }

    final int? minute = int.tryParse(parts[1]);

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
  static Color? colorParse(String? text, [int? defaultColor]) {
    try {
      String t = text?.replaceAll('#', '').trim().toLowerCase() ?? '';
      if (!t.startsWith('0x')) {
        if (t.length < 3) {
          throw Exception('Length less than 3.');
        }

        t = switch (t.length) {
          3 => 'ff${t[0]}${t[0]}${t[1]}${t[1]}${t[2]}${t[2]}',
          4 => '${t[0]}${t[0]}${t[1]}${t[1]}${t[2]}${t[2]}${t[3]}${t[3]}',
          5 => '',
          6 => 'ff$t',
          7 => '',
          _ => t
        };

        t = '0x$t';
      }

      if (t.length > 10) {
        t = t.substring(0, 10);
      }

      return Color(int.parse(t));
    } on Exception catch (_) {
      return defaultColor == null ? null : Color(defaultColor);
    }
  }

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
