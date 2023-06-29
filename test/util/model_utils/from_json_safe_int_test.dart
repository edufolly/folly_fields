import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group('ModelUtils fromJsonSafeInt', () {
    final Map<({dynamic a, int? b, int c}), int?> domain =
        <({dynamic a, int? b, int c}), int?>{
      (a: null, b: 8, c: 1): 1,
      (a: null, b: null, c: 1): 1,
      (a: null, b: 16, c: 1): 1,
      (a: true, b: null, c: 1): 1,
      (a: false, b: null, c: 1): 1,
      (a: <dynamic>[], b: null, c: 1): 1,
      (a: <dynamic>{}, b: null, c: 1): 1,
      (a: <dynamic, dynamic>{}, b: null, c: 1): 1,
      (a: -9, b: 8, c: 1): 1,
      (a: -9, b: null, c: 1): -9,
      (a: -9, b: 16, c: 1): -9,
      (a: -1.0, b: 8, c: 1): 1,
      (a: -1.0, b: null, c: 1): 1,
      (a: -1.0, b: 16, c: 1): 1,
      (a: 0, b: 8, c: 1): 0,
      (a: 0, b: null, c: 1): 0,
      (a: 0, b: 16, c: 1): 0,
      (a: 9, b: 8, c: 1): 1,
      (a: 9, b: null, c: 1): 9,
      (a: 9, b: 16, c: 1): 9,
      (a: 10, b: 8, c: 1): 8,
      (a: 10, b: null, c: 1): 10,
      (a: 10, b: 16, c: 1): 16,
      (a: 1.0, b: 8, c: 1): 1,
      (a: 1.0, b: null, c: 1): 1,
      (a: 1.0, b: 16, c: 1): 1,
      (a: 1.5, b: 8, c: 1): 1,
      (a: 1.5, b: null, c: 1): 1,
      (a: 1.5, b: 16, c: 1): 1,
      (a: '', b: 8, c: 1): 1,
      (a: '', b: null, c: 1): 1,
      (a: '', b: 16, c: 1): 1,
      (a: ' ', b: 8, c: 1): 1,
      (a: ' ', b: null, c: 1): 1,
      (a: ' ', b: 16, c: 1): 1,
      (a: '-1', b: 8, c: 1): -1,
      (a: '-1', b: null, c: 1): -1,
      (a: '-1', b: 16, c: 1): -1,
      (a: '0', b: 8, c: 1): 0,
      (a: '0', b: null, c: 1): 0,
      (a: '0', b: 16, c: 1): 0,
      (a: '1.0', b: 8, c: 1): 1,
      (a: '1.0', b: null, c: 1): 1,
      (a: '1.0', b: 16, c: 1): 1,
      (a: '1.5', b: 8, c: 1): 1,
      (a: '1.5', b: null, c: 1): 1,
      (a: '1.5', b: 16, c: 1): 1,
      (a: '9', b: 8, c: 1): 1,
      (a: '9', b: null, c: 1): 9,
      (a: '9', b: 16, c: 1): 9,
      (a: '10', b: 8, c: 1): 8,
      (a: '10', b: null, c: 1): 10,
      (a: '10', b: 16, c: 1): 16,
      (a: 'A', b: 8, c: 1): 1,
      (a: 'A', b: null, c: 1): 1,
      (a: 'A', b: 16, c: 1): 10,
      (a: '-A', b: 8, c: 1): 1,
      (a: '-A', b: null, c: 1): 1,
      (a: '-A', b: 16, c: 1): -10,
      (a: 'Z', b: 8, c: 1): 1,
      (a: 'Z', b: null, c: 1): 1,
      (a: 'Z', b: 16, c: 1): 1,
      (a: '0xA', b: 8, c: 1): 1,
      (a: '0xA', b: null, c: 1): 10,
      (a: '0xA', b: 16, c: 1): 1,
      (a: 'true', b: 8, c: 1): 1,
      (a: 'true', b: null, c: 1): 1,
      (a: 'true', b: 16, c: 1): 1,
      (a: 'false', b: 8, c: 1): 1,
      (a: 'false', b: null, c: 1): 1,
      (a: 'false', b: 16, c: 1): 1,
    };

    for (final MapEntry<({dynamic a, int? b, int c}), int?> input
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
