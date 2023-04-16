import 'dart:math';

import 'package:folly_fields/util/hashable.dart';

///
///
///
class Decimal with Hashable {
  final int precision;
  late double _doubleValue;

  ///
  ///
  ///
  Decimal({
    required this.precision,
    int? intValue,
    double? doubleValue,
  })  : assert(precision >= 0, 'precision must be positive or zero'),
        assert(
          intValue == null || doubleValue == null,
          'intValue or doubleValue must be null',
        ) {
    if (doubleValue != null) {
      this.doubleValue = doubleValue;
    } else {
      this.intValue = intValue;
    }
  }

  ///
  ///
  ///
  int get intValue =>
      int.parse((_doubleValue * pow(10, precision)).toStringAsFixed(0));

  ///
  ///
  ///
  set intValue(int? value) =>
      _doubleValue = (value ?? 0).toDouble() / pow(10, precision);

  ///
  ///
  ///
  double get doubleValue => _doubleValue;

  ///
  ///
  ///
  set doubleValue(double? value) => _doubleValue =
      ((value ?? 0) * pow(10, precision)).toInt() / pow(10, precision);

  ///
  ///
  ///
  @override
  String toString() => _doubleValue.toStringAsFixed(precision);

  ///
  ///
  ///
  @override
  int get hashCode => finish(combine(precision, intValue));

  ///
  ///
  ///
  @override
  bool operator ==(Object other) {
    if (other is Decimal) {
      return precision == other.precision && doubleValue == other.doubleValue;
    }

    return false;
  }
}
