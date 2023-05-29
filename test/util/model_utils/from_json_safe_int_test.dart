import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/duplet.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group('ModelUtils fromJsonSafeInt', () {
    final Map<Triplet<dynamic, int?, int>, int?> domain =
        <Triplet<dynamic, int?, int>, int?>{
      const Triplet<dynamic, int?, int>(null, 8, 1): 1,
      const Triplet<dynamic, int?, int>(null, null, 1): 1,
      const Triplet<dynamic, int?, int>(null, 16, 1): 1,
      const Triplet<dynamic, int?, int>(true, null, 1): 1,
      const Triplet<dynamic, int?, int>(false, null, 1): 1,
      const Triplet<dynamic, int?, int>(<dynamic>[], null, 1): 1,
      const Triplet<dynamic, int?, int>(<dynamic>{}, null, 1): 1,
      const Triplet<dynamic, int?, int>(<dynamic, dynamic>{}, null, 1): 1,
      const Triplet<dynamic, int?, int>(-9, 8, 1): 1,
      const Triplet<dynamic, int?, int>(-9, null, 1): -9,
      const Triplet<dynamic, int?, int>(-9, 16, 1): -9,
      const Triplet<dynamic, int?, int>(-1.0, 8, 1): 1,
      const Triplet<dynamic, int?, int>(-1.0, null, 1): 1,
      const Triplet<dynamic, int?, int>(-1.0, 16, 1): 1,
      const Triplet<dynamic, int?, int>(0, 8, 1): 0,
      const Triplet<dynamic, int?, int>(0, null, 1): 0,
      const Triplet<dynamic, int?, int>(0, 16, 1): 0,
      const Triplet<dynamic, int?, int>(9, 8, 1): 1,
      const Triplet<dynamic, int?, int>(9, null, 1): 9,
      const Triplet<dynamic, int?, int>(9, 16, 1): 9,
      const Triplet<dynamic, int?, int>(10, 8, 1): 8,
      const Triplet<dynamic, int?, int>(10, null, 1): 10,
      const Triplet<dynamic, int?, int>(10, 16, 1): 16,
      const Triplet<dynamic, int?, int>(1.0, 8, 1): 1,
      const Triplet<dynamic, int?, int>(1.0, null, 1): 1,
      const Triplet<dynamic, int?, int>(1.0, 16, 1): 1,
      const Triplet<dynamic, int?, int>(1.5, 8, 1): 1,
      const Triplet<dynamic, int?, int>(1.5, null, 1): 1,
      const Triplet<dynamic, int?, int>(1.5, 16, 1): 1,
      const Triplet<dynamic, int?, int>('', 8, 1): 1,
      const Triplet<dynamic, int?, int>('', null, 1): 1,
      const Triplet<dynamic, int?, int>('', 16, 1): 1,
      const Triplet<dynamic, int?, int>(' ', 8, 1): 1,
      const Triplet<dynamic, int?, int>(' ', null, 1): 1,
      const Triplet<dynamic, int?, int>(' ', 16, 1): 1,
      const Triplet<dynamic, int?, int>('-1', 8, 1): -1,
      const Triplet<dynamic, int?, int>('-1', null, 1): -1,
      const Triplet<dynamic, int?, int>('-1', 16, 1): -1,
      const Triplet<dynamic, int?, int>('0', 8, 1): 0,
      const Triplet<dynamic, int?, int>('0', null, 1): 0,
      const Triplet<dynamic, int?, int>('0', 16, 1): 0,
      const Triplet<dynamic, int?, int>('1.0', 8, 1): 1,
      const Triplet<dynamic, int?, int>('1.0', null, 1): 1,
      const Triplet<dynamic, int?, int>('1.0', 16, 1): 1,
      const Triplet<dynamic, int?, int>('1.5', 8, 1): 1,
      const Triplet<dynamic, int?, int>('1.5', null, 1): 1,
      const Triplet<dynamic, int?, int>('1.5', 16, 1): 1,
      const Triplet<dynamic, int?, int>('9', 8, 1): 1,
      const Triplet<dynamic, int?, int>('9', null, 1): 9,
      const Triplet<dynamic, int?, int>('9', 16, 1): 9,
      const Triplet<dynamic, int?, int>('10', 8, 1): 8,
      const Triplet<dynamic, int?, int>('10', null, 1): 10,
      const Triplet<dynamic, int?, int>('10', 16, 1): 16,
      const Triplet<dynamic, int?, int>('A', 8, 1): 1,
      const Triplet<dynamic, int?, int>('A', null, 1): 1,
      const Triplet<dynamic, int?, int>('A', 16, 1): 10,
      const Triplet<dynamic, int?, int>('-A', 8, 1): 1,
      const Triplet<dynamic, int?, int>('-A', null, 1): 1,
      const Triplet<dynamic, int?, int>('-A', 16, 1): -10,
      const Triplet<dynamic, int?, int>('Z', 8, 1): 1,
      const Triplet<dynamic, int?, int>('Z', null, 1): 1,
      const Triplet<dynamic, int?, int>('Z', 16, 1): 1,
      const Triplet<dynamic, int?, int>('0xA', 8, 1): 1,
      const Triplet<dynamic, int?, int>('0xA', null, 1): 10,
      const Triplet<dynamic, int?, int>('0xA', 16, 1): 1,
      const Triplet<dynamic, int?, int>('true', 8, 1): 1,
      const Triplet<dynamic, int?, int>('true', null, 1): 1,
      const Triplet<dynamic, int?, int>('true', 16, 1): 1,
      const Triplet<dynamic, int?, int>('false', 8, 1): 1,
      const Triplet<dynamic, int?, int>('false', null, 1): 1,
      const Triplet<dynamic, int?, int>('false', 16, 1): 1,
    };

    for (final MapEntry<Triplet<dynamic, int?, int>, int?> input
        in domain.entries) {
      test(
        '${input.key} // ${input.value}',
        () {
          expect(
            ModelUtils.fromJsonSafeInt(
              input.key.a,
              radix: input.key.b,
              defaultValue: input.key.c,
            ),
            input.value,
          );
        },
      );
    }
  });
}
