import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';

///
///
///
void main() {
  test(
    'Check decimal values.',
    () {
      for (int integer = 0; integer <= 9999999; integer++) {
        expect(Decimal(precision: 2, intValue: integer).intValue, integer);
      }
    },
  );
}
