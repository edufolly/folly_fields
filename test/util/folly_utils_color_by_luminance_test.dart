import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_utils.dart';

void main() {
  Map<int, int> domain = <int, int>{
    0xFF000000: 0xFFFFFFFF,
    0xFF333333: 0xFFFFFFFF,
    0xFF808080: 0xFF000000,
    0xFF0A141E: 0xFFFFFFFF,
    0xFFC86432: 0xFF000000,
    0xFFAAAAAA: 0xFF000000,
    0xFFBBBBBB: 0xFF000000,
    0xFFFFFFFF: 0xFF000000,
  };

  group('textColorByLuminance', () {
    for (final MapEntry<int, int>(:int key, :int value) in domain.entries) {
      test(
        'Testing ${key.toRadixString(16)} - ${Color(key).computeLuminance()}',
        () => expect(FollyUtils.textColorByLuminance(Color(key)), Color(value)),
      );
    }
  });
}
