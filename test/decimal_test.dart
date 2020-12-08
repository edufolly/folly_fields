import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/decimal.dart';

///
///
///
void main() {
  test('Verificação de valores decimais.', () {
    for (int i = 0; i <= 9999999; i++) {
      Decimal d = Decimal(precision: 2, initialValue: i);
      expect(d.integer, i);
    }
  });
}
