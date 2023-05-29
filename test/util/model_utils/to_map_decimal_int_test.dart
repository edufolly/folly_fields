import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils toMapDecimalInt',
    () {
      final Map<Decimal, int> domain = <Decimal, int>{
        Decimal(doubleValue: 1, precision: 0): 1,
        Decimal(doubleValue: 1, precision: 2): 100,
        Decimal(doubleValue: 1.1, precision: 2): 110,
        Decimal(doubleValue: 1.12, precision: 2): 112,
      };

      for (final MapEntry<Decimal, int> input in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.toMapDecimalInt(input.key),
              input.value,
            );
          },
        );
      }
    },
  );
}
