import 'package:flutter/material.dart';
import 'package:folly_fields/extensions/date_time_extension.dart';

// TODO(edufolly): Review this class.
class FollyUtils {
  static String? validDate(final String? value) {
    if (value == null || value.isEmpty) {
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

  static String? validTime(final String? value) {
    if (value == null || value.length != 5) {
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

  static Color textColorByLuminance(
    final Color color, {
    final Color darkColor = Colors.black,
    final Color lightColor = Colors.white,
    final double threshold = 0.183,
  }) => color.computeLuminance() > threshold ? darkColor : lightColor;

  static String colorHex(final Color color) =>
      colorToInt(color).toRadixString(16).toUpperCase().padLeft(8, '0');

  static Color? colorParse(final String? text) {
    if (text == null) {
      return null;
    }

    try {
      String t = text.replaceAll('#', '').trim().toLowerCase();
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
          _ => t,
        };

        t = '0x$t';
      }

      if (t.length > 10) {
        t = t.substring(0, 10);
      }

      return Color(int.parse(t));
    } on Exception catch (_) {
      return null;
    }
  }

  static MaterialColor? createMaterialColor({
    final int? intColor,
    Color? color,
  }) {
    if (intColor != null) {
      color = Color(intColor);
    }

    if (color == null) {
      return null;
    }

    return MaterialColor(colorToInt(color), <int, Color>{
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
    });
  }

  static int _floatToInt8(final double x) {
    return (x * 255.0).round() & 0xff;
  }

  static int colorToInt(final Color color) {
    return _floatToInt8(color.a) << 24 |
        _floatToInt8(color.r) << 16 |
        _floatToInt8(color.g) << 8 |
        _floatToInt8(color.b) << 0;
  }
}
