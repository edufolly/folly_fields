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
      Set<(int?, int, Decimal)> domain = <(int?, int, Decimal)>{
        (null, 0, Decimal(precision: 0, doubleValue: 0)),
        (1, 0, Decimal(precision: 0, doubleValue: 1)),
        (11, 0, Decimal(precision: 0, doubleValue: 11)),
        (112, 0, Decimal(precision: 0, doubleValue: 112)),
        (1123, 0, Decimal(precision: 0, doubleValue: 1123)),
        (null, 2, Decimal(precision: 2, doubleValue: 0)),
        (1, 2, Decimal(precision: 2, doubleValue: 0.01)),
        (11, 2, Decimal(precision: 2, doubleValue: 0.11)),
        (112, 2, Decimal(precision: 2, doubleValue: 1.12)),
        (1123, 2, Decimal(precision: 2, doubleValue: 11.23)),
      };

      for (final (int? a, int b, Decimal r) in domain) {
        test(
          '$a // $b => $r',
          () => expect(ModelUtils.fromJsonDecimalInt(a, b), r),
        );
      }
    },
  );
}
