import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/credit_card_number_validator.dart';

void main() {
  group('CreditCardNumberValidator Coverage', () {
    CreditCardNumberValidator validator = CreditCardNumberValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
