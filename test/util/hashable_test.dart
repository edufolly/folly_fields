import 'package:flutter_test/flutter_test.dart';

import '../mocks/hashable_mock.dart';

///
///
///
void main() {
  ///
  group(
    'Hashable',
    () {
      Map<dynamic, int> domain = <dynamic, int>{
        HashableObjectMock(): 120981707,
        HashableIterableMock<int>(const <int?>{}): 8,
        HashableIterableMock<int>(const <int?>{null}): 174759375,
        HashableIterableMock<int>(const <int?>{0}): 97342612,
        HashableIterableMock<String>(const <String?>{}): 8,
        HashableIterableMock<String>(const <String?>{null}): 174759375,
        HashableIterableMock<String>(const <String?>{''}): 0,
        HashableIterableMock<String>(const <String?>{'0'}): 328788615,
        HashableIterableMock<String>(const <String?>{'0'}): 328788615,
        HashableIterableMock<int>(const <int?>[]): 8,
        HashableIterableMock<int>(const <int?>[null]): 174759375,
        HashableIterableMock<int>(const <int?>[0]): 97342612,
        HashableIterableMock<int>(const <int?>[0, 0]): 46155461,
      };

      for (final MapEntry<dynamic, int>(
            :dynamic key,
            :int value,
          ) in domain.entries) {
        test('$key // $value', () => expect(key.hashCode, value));
      }
    },
  );
}
