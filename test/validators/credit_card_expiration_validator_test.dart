import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/credit_card_expiration_validator.dart';
import 'package:intl/intl.dart';

void main() {
  group('CreditCardExpirationValidator isValid', () {
    CreditCardExpirationValidator validator = CreditCardExpirationValidator();

    DateFormat dateFormat = DateFormat('MM/yy');

    DateTime nowDate = DateTime.now();

    DateTime firstDate = DateTime(nowDate.year, nowDate.month);
    String now = dateFormat.format(firstDate);

    DateTime lastOp = firstDate.subtract(const Duration(days: 1));
    DateTime lastDate = DateTime(lastOp.year, lastOp.month);
    String last = dateFormat.format(lastDate);

    DateTime nextOp = firstDate.add(const Duration(days: 32));
    DateTime nextDate = DateTime(nextOp.year, nextOp.month);
    String next = dateFormat.format(nextDate);

    String lastYear = (firstDate.year - 2001).toString().padLeft(2, '0');

    String nextYear = (firstDate.year - 1999).toString().padLeft(2, '0');

    Map<String, bool> domain = <String, bool>{
      '': false,
      ' ': false,
      '0': false,
      '1': false,
      '_': false,
      '!': false,
      '@': false,
      'a': false,
      'á': false,
      '00': false,
      '000': false,
      '0000': false,
      '00000': false,
      'A': false,
      'AA': false,
      'AAA': false,
      'AAAA': false,
      'AAAAA': false,
      '00/00': false,
      '01/00': false,
      '01/01': false,
      '1/01': false,
      '1/1': false,
      '01/1': false,
      '00/$lastYear': false,
      '01/$lastYear': false,
      '11/$lastYear': false,
      '12/$lastYear': false,
      '13/$lastYear': false,
      last: false,
      now: false,
      next: true,
      '00/$nextYear': false,
      '01/$nextYear': true,
      '11/$nextYear': true,
      '12/$nextYear': true,
      '13/$nextYear': false,
    };

    for (final MapEntry<String, bool> input in domain.entries) {
      test(
        'Testing: ${input.key}',
        () => expect(validator.isValid(input.key), input.value),
      );
    }
  });

  group('CreditCardExpirationValidator Coverage', () {
    CreditCardExpirationValidator validator = CreditCardExpirationValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
