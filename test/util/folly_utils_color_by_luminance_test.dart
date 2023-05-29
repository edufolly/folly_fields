import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_utils.dart';

///
///
///
void main() {
  final Map<int, int> domain = <int, int>{
    0xFF000000: 0xFFFFFFFF,
    0xFF808080: 0xFFFFFFFF,
    0xFF0A141E: 0xFFFFFFFF,
    0xFFC86432: 0xFFFFFFFF,
    0xFFAAAAAA: 0xFFFFFFFF,
    0xFFBBBBBB: 0xFF000000,
    0xFFFFFFFF: 0xFF000000,
  };

  group(
    'textColorByLuminance',
    () {
      for (final MapEntry<int, int> input in domain.entries) {
        test(
          'Testing ${input.key.toRadixString(16)}',
          () => expect(
            FollyUtils.textColorByLuminance(Color(input.key)),
            Color(input.value),
          ),
        );
      }
    },
  );
}
