import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils toMapDecimalDouble',
    () {
      Map<Decimal, double> domain = <Decimal, double>{
        Decimal(intValue: 1, precision: 0): 1.0,
        Decimal(intValue: 11, precision: 0): 11.0,
        Decimal(intValue: 112, precision: 0): 112.0,
        Decimal(intValue: 1123, precision: 0): 1123.0,
        Decimal(intValue: 1, precision: 2): 0.01,
        Decimal(intValue: 11, precision: 2): 0.11,
        Decimal(intValue: 112, precision: 2): 1.12,
        Decimal(intValue: 1123, precision: 2): 11.23,
      };

      for (final MapEntry<Decimal, double> input in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.toMapDecimalDouble(input.key),
              input.value,
            );
          },
        );
      }
    },
  );
}
