import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_iterable_extension.dart';

///
///
///
void main() {
  group('FollyIterableExtension removeNulls', () {
    test('Testing String List', () {
      List<String> match = <String>['A', 'B', 'C'];

      List<String?> list = <String?>[null, 'A', null, 'B', null, 'C', null];

      List<String> actual = list.removeNulls.toList();

      expect(actual, match);
      expect(actual.runtimeType, match.runtimeType);
    });
  });
}
