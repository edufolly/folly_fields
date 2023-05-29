import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/ncm_validator.dart';

///
///
///
void main() {
  group('NcmValidator Coverage', () {
    final NcmValidator validator = NcmValidator();
    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
