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
  }) : assert(precision >= 0) {
    value = (initialValue ?? 0).toDouble() / pow(10, precision);
  }

  ///
  ///
  ///
  int get integer => (value * pow(10, precision)).toInt();
}
