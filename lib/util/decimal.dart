
import 'dart:math';

import 'package:flutter/foundation.dart';


// TODO(edufolly): Create an immutable class.
@immutable
class Decimal {
  final int precision;
  final double _doubleValue;

  Decimal({
    required this.precision,
    final int? intValue,
    final double? doubleValue,
  }) : assert(precision >= 0, 'precision must be positive or zero'),
       assert(
         intValue == null || doubleValue == null,
         'intValue or doubleValue must be null',
       ),
       _doubleValue =
           double.tryParse(doubleValue?.toStringAsFixed(precision) ?? '') ??
           (intValue ?? 0).toDouble() / pow(10, precision);

  double get doubleValue => _doubleValue;

  // set doubleValue(final double value) =>
  //     _doubleValue = double.parse(value.toStringAsFixed(precision));

  int get intValue =>
      int.parse((_doubleValue * pow(10, precision)).toStringAsFixed(0));

  @override
  String toString() => _doubleValue.toStringAsFixed(precision);

  @override
  int get hashCode => precision.hashCode + _doubleValue.hashCode;

  @override
  bool operator ==(final Object other) {
    if (other is Decimal) {
      return precision == other.precision && doubleValue == other.doubleValue;
    }

    return false;
  }
}
