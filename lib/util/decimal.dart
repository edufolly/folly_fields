import 'dart:math';

import 'package:flutter/foundation.dart';

///
///
///
class Decimal {
  final int precision;
  double value;

  ///
  ///
  ///
  Decimal({
    @required this.precision,
    int initialValue,
    double doubleValue,
  }) : assert(precision >= 0) {
    value = initialValue != null
        ? initialValue.toDouble() / pow(10, precision)
        : doubleValue ?? 0.0;
  }

  ///
  ///
  ///
  int get integer => int.parse((value * pow(10, precision)).toStringAsFixed(0));

  ///
  ///
  /// TODO - Formatar corretamente.
  @override
  String toString() => value.toStringAsFixed(precision);
}
