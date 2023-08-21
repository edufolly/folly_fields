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
      Set<(double?, int, Decimal)> domain = <(double?, int, Decimal)>{
        (null, 0, Decimal(precision: 0, intValue: 0)),
        (1, 0, Decimal(precision: 0, intValue: 1)),
        (1.1, 0, Decimal(precision: 0, intValue: 1)),
        (1.12, 0, Decimal(precision: 0, intValue: 1)),
        (1.123, 0, Decimal(precision: 0, intValue: 1)),
        (null, 2, Decimal(precision: 2, intValue: 0)),
        (1.1, 2, Decimal(precision: 2, intValue: 110)),
        (1.12, 2, Decimal(precision: 2, intValue: 112)),
        (1.123, 2, Decimal(precision: 2, intValue: 112)),
      };

      for (final (double? a, int b, Decimal r) in domain) {
        test(
          '$a // $b => $r',
          () => expect(ModelUtils.fromJsonDecimalDouble(a, b), r),
        );
      }
    },
  );
}
