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
      Map<HashableMock, int> domain = <HashableMock, int>{
        HashableMock(): 44916520,
      };

      for (final MapEntry<HashableMock, int>(
            :HashableMock key,
            :int value,
          ) in domain.entries) {
        test('$key // $value', () => expect(key.hashCode, value));
      }
    },
  );
}
