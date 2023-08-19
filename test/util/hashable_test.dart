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

      for (MapEntry<HashableMock, int> input in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () => expect(input.key.hashCode, input.value),
        );
      }
    },
  );
}
