import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonDecimalInt',
    () {
      final Map<({int? a, int b}), Decimal> domain =
          <({int? a, int b}), Decimal>{
        (a: null, b: 0): Decimal(precision: 0, doubleValue: 0),
        (a: 1, b: 0): Decimal(precision: 0, doubleValue: 1),
        (a: 11, b: 0): Decimal(precision: 0, doubleValue: 11),
        (a: 112, b: 0): Decimal(precision: 0, doubleValue: 112),
        (a: 1123, b: 0): Decimal(precision: 0, doubleValue: 1123),
        (a: null, b: 2): Decimal(precision: 2, doubleValue: 0),
        (a: 1, b: 2): Decimal(precision: 2, doubleValue: 0.01),
        (a: 11, b: 2): Decimal(precision: 2, doubleValue: 0.11),
        (a: 112, b: 2): Decimal(precision: 2, doubleValue: 1.12),
        (a: 1123, b: 2): Decimal(precision: 2, doubleValue: 11.23),
      };

      for (final MapEntry<({int? a, int b}), Decimal> input in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonDecimalInt(input.key.a, input.key.b),
              input.value,
            );
          },
        );
      }
    },
  );
}
