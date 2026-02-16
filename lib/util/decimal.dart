import 'dart:math';

import 'package:flutter/foundation.dart';

@immutable
class Decimal {
  final int precision;
  final double _doubleValue;

  Decimal({required this.precision, int? intValue, double? doubleValue})
    : assert(precision >= 0, 'precision must be positive or zero'),
      assert(
        intValue == null || doubleValue == null,
        'intValue or doubleValue must be null',
      ),
      _doubleValue =
          double.tryParse(doubleValue?.toStringAsFixed(precision) ?? '') ??
          (intValue ?? 0).toDouble() / pow(10, precision);

  double get doubleValue => _doubleValue;

  int get intValue =>
      int.parse((_doubleValue * pow(10, precision)).toStringAsFixed(0));

  @override
  String toString() => _doubleValue.toStringAsFixed(precision);

  @override
  int get hashCode => precision.hashCode + _doubleValue.hashCode;

  @override
  bool operator ==(Object other) =>
      (other is Decimal) &&
      (precision == other.precision && doubleValue == other.doubleValue);
}
