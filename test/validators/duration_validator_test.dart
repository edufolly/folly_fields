import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/duration_validator.dart';

///
///
///
void main() {
  group('DurationValidator Coverage', () {
    DurationValidator validator = DurationValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
