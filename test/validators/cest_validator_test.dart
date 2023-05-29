import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/cest_validator.dart';

///
///
///
void main() {
  group('CestValidator Coverage', () {
    final CestValidator validator = CestValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
