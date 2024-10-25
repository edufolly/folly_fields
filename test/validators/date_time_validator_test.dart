import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/date_time_validator.dart';

///
///
///
void main() {
  group('DateTimeValidator Coverage', () {
    DateTimeValidator validator = DateTimeValidator();

    test(
      'strip',
      () => expect(validator.strip('01/01/2000 00:00'), '01/01/2000 00:00'),
    );

    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
