import 'dart:math';

import 'package:folly_fields/util/hashable.dart';

///
///
///
class Decimal with Hashable {
  final int precision;
  double doubleValue;

  ///
  ///
  ///
  Decimal({
    required this.precision,
    @Deprecated('Use intValue instead initialValue') int? initialValue,
    int? intValue,
    double? doubleValue,
  })  : assert(precision >= 0, 'precision must be positive or zero'),
        assert(intValue == null || doubleValue == null,
            'intValue or doubleValue must be null'),
        doubleValue = doubleValue ??
            (intValue ?? initialValue ?? 0).toDouble() / pow(10, precision);

  ///
  ///
  ///
  @Deprecated('Use doubleValue instead value')
  set value(double value) => doubleValue = value;

  ///
  ///
  ///
  @Deprecated('Use doubleValue instead value')
  double get value => doubleValue;

  ///
  ///
  ///
  int get intValue =>
      int.parse((doubleValue * pow(10, precision)).toStringAsFixed(0));

  ///
  ///
  ///
  @Deprecated('Use integerValue instead integer')
  int get integer => intValue;

  ///
  ///
  ///
  // TODO(edufolly): Formatar corretamente.
  @override
  String toString() => doubleValue.toStringAsFixed(precision);

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
