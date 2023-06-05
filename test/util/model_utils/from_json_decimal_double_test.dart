import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonDecimalDouble',
    () {
      final Map<({double? a, int b}), Decimal> domain =
          <({double? a, int b}), Decimal>{
        (a: null, b: 0): Decimal(precision: 0, intValue: 0),
        (a: 1, b: 0): Decimal(precision: 0, intValue: 1),
        (a: 1.1, b: 0): Decimal(precision: 0, intValue: 1),
        (a: 1.12, b: 0): Decimal(precision: 0, intValue: 1),
        (a: 1.123, b: 0): Decimal(precision: 0, intValue: 1),
        (a: null, b: 2): Decimal(precision: 2, intValue: 0),
        (a: 1.1, b: 2): Decimal(precision: 2, intValue: 110),
        (a: 1.12, b: 2): Decimal(precision: 2, intValue: 112),
        (a: 1.123, b: 2): Decimal(precision: 2, intValue: 112),
      };

      for (final MapEntry<({double? a, int b}), Decimal> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonDecimalDouble(input.key.a, input.key.b),
              input.value,
            );
          },
        );
      }
    },
  );
}
