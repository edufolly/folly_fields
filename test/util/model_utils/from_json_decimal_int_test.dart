import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/duplet.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonDecimalInt',
    () {
      final Map<Duplet<int?, int>, Decimal> domain =
          <Duplet<int?, int>, Decimal>{
        const Duplet<int?, int>(null, 0): Decimal(precision: 0, doubleValue: 0),
        const Duplet<int?, int>(1, 0): Decimal(precision: 0, doubleValue: 1),
        const Duplet<int?, int>(11, 0): Decimal(precision: 0, doubleValue: 11),
        const Duplet<int?, int>(112, 0):
            Decimal(precision: 0, doubleValue: 112),
        const Duplet<int?, int>(1123, 0):
            Decimal(precision: 0, doubleValue: 1123),
        const Duplet<int?, int>(null, 2): Decimal(precision: 2, doubleValue: 0),
        const Duplet<int?, int>(1, 2): Decimal(precision: 2, doubleValue: 0.01),
        const Duplet<int?, int>(11, 2):
            Decimal(precision: 2, doubleValue: 0.11),
        const Duplet<int?, int>(112, 2):
            Decimal(precision: 2, doubleValue: 1.12),
        const Duplet<int?, int>(1123, 2):
            Decimal(precision: 2, doubleValue: 11.23),
      };

      for (final MapEntry<Duplet<int?, int>, Decimal> input in domain.entries) {
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
