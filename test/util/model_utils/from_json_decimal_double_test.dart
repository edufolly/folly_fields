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
    'ModelUtils fromJsonDecimalDouble',
    () {
      Map<Duplet<double?, int>, Decimal> domain =
          <Duplet<double?, int>, Decimal>{
        const Duplet<double?, int>(null, 0): Decimal(precision: 0, intValue: 0),
        const Duplet<double?, int>(1, 0): Decimal(precision: 0, intValue: 1),
        const Duplet<double?, int>(1.1, 0): Decimal(precision: 0, intValue: 1),
        const Duplet<double?, int>(1.12, 0): Decimal(precision: 0, intValue: 1),
        const Duplet<double?, int>(1.123, 0):
            Decimal(precision: 0, intValue: 1),
        const Duplet<double?, int>(null, 2): Decimal(precision: 2, intValue: 0),
        const Duplet<double?, int>(1.1, 2):
            Decimal(precision: 2, intValue: 110),
        const Duplet<double?, int>(1.12, 2):
            Decimal(precision: 2, intValue: 112),
        const Duplet<double?, int>(1.123, 2):
            Decimal(precision: 2, intValue: 112),
      };

      for (final MapEntry<Duplet<double?, int>, Decimal> input
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
