import 'package:flutter/material.dart';
import 'package:folly_fields/extensions/date_time_extension.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/extensions/string_extension.dart';

// TODO(edufolly): Review this class.
class FollyUtils {
  // TODO(edufolly): Move to StringExtension.
  static String? validDate(String? value) {
    if (isNullOrBlank(value)) return 'Informe uma data.';

    List<String> parts = value!.split('/');

    if (parts.length != 3) return 'Data inválida.';

    if (parts[2].length != 4) return 'Ano inválido.';

    int? year = int.tryParse(parts[2]);

    if (year == null) return 'Ano inválido.';

    int? month = int.tryParse(parts[1]);

    if (month == null || month < 1 || month > 12) return 'Mês inválido.';

    int? day = int.tryParse(parts[0]);

    if (day == null || day < 1 || day > DateTime(year, month).daysInMonth) {
      return 'Dia inválido.';
    }

    return null;
  }

  // TODO(edufolly): Move to StringExtension.
  static String? validTime(String? value) {
    if (value == null || value.length != 5) return 'Informe uma hora.';

    List<String> parts = value.split(':');

    if (parts.length != 2) return 'Hora inválida.';

    int? hour = int.tryParse(parts[0]);

    if (hour == null || hour < 0 || hour > 23) return 'Horas inválidas.';

    int? minute = int.tryParse(parts[1]);

    if (minute == null || minute < 0 || minute > 59) {
      return 'Minutos inválidos.';
    }

    return null;
  }

  // TODO(edufolly): Create a Extension.
  static Color textColorByLuminance(
    Color color, {
    Color darkColor = Colors.black,
    Color lightColor = Colors.white,
    double threshold = 0.183,
  }) => color.computeLuminance() > threshold ? darkColor : lightColor;

  // TODO(edufolly): Create a Extension.
  static String colorHex(Color color) =>
      colorToInt(color).toRadixString(16).toUpperCase().padLeft(8, '0');

  // TODO(edufolly): Move to StringExtension.
  static Color? colorParse(String? text) {
    if (text == null) return null;

    try {
      String t = text.replaceAll('#', '').trim().toLowerCase();
      if (!t.startsWith('0x')) {
        if (t.length < 3) error('Length less than 3.');

        t = switch (t.length) {
          3 => 'ff${t[0]}${t[0]}${t[1]}${t[1]}${t[2]}${t[2]}',
          4 => '${t[0]}${t[0]}${t[1]}${t[1]}${t[2]}${t[2]}${t[3]}${t[3]}',
          5 => '',
          6 => 'ff$t',
          7 => '',
          _ => t,
        };

        t = '0x$t';
      }

      return Color(int.parse(t.take(10)));
    } on Exception catch (_) {
      return null;
    }
  }

  static MaterialColor? createMaterialColor({int? intColor, Color? color}) {
    final Color? newColor = intColor?.let(Color.new) ?? color;

    if (newColor == null) return null;

    return MaterialColor(colorToInt(newColor), <int, Color>{
      50: newColor,
      100: newColor,
      200: newColor,
      300: newColor,
      400: newColor,
      500: newColor,
      600: newColor,
      700: newColor,
      800: newColor,
      900: newColor,
    });
  }

  static int _floatToInt8(double x) => (x * 255.0).round() & 0xff;

  static int colorToInt(Color color) =>
      _floatToInt8(color.a) << 24 |
      _floatToInt8(color.r) << 16 |
      _floatToInt8(color.g) << 8 |
      _floatToInt8(color.b) << 0;
}
