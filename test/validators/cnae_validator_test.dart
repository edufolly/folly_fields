import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/cnae_validator.dart';

///
///
///
void main() {
  group('CnaeValidator Coverage', () {
    final CnaeValidator validator = CnaeValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
