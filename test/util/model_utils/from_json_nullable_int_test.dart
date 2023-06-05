import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group('ModelUtils fromJsonNullableInt', () {
    final Map<({dynamic a, int? b}), int?> domain =
        <({dynamic a, int? b}), int?>{
      (a: null, b: 8): null,
      (a: null, b: null): null,
      (a: null, b: 16): null,
      (a: true, b: null): null,
      (a: false, b: null): null,
      (a: <dynamic>[], b: null): null,
      (a: <dynamic>{}, b: null): null,
      (a: <dynamic, dynamic>{}, b: null): null,
      (a: -9, b: 8): null,
      (a: -9, b: null): -9,
      (a: -9, b: 16): -9,
      (a: -1.0, b: 8): null,
      (a: -1.0, b: null): null,
      (a: -1.0, b: 16): null,
      (a: 0, b: 8): 0,
      (a: 0, b: null): 0,
      (a: 0, b: 16): 0,
      (a: 9, b: 8): null,
      (a: 9, b: null): 9,
      (a: 9, b: 16): 9,
      (a: 10, b: 8): 8,
      (a: 10, b: null): 10,
      (a: 10, b: 16): 16,
      (a: 1.0, b: 8): null,
      (a: 1.0, b: null): null,
      (a: 1.0, b: 16): null,
      (a: 1.5, b: 8): null,
      (a: 1.5, b: null): null,
      (a: 1.5, b: 16): null,
      (a: '', b: 8): null,
      (a: '', b: null): null,
      (a: '', b: 16): null,
      (a: ' ', b: 8): null,
      (a: ' ', b: null): null,
      (a: ' ', b: 16): null,
      (a: '-1', b: 8): -1,
      (a: '-1', b: null): -1,
      (a: '-1', b: 16): -1,
      (a: '0', b: 8): 0,
      (a: '0', b: null): 0,
      (a: '0', b: 16): 0,
      (a: '1.0', b: 8): null,
      (a: '1.0', b: null): null,
      (a: '1.0', b: 16): null,
      (a: '1.5', b: 8): null,
      (a: '1.5', b: null): null,
      (a: '1.5', b: 16): null,
      (a: '9', b: 8): null,
      (a: '9', b: null): 9,
      (a: '9', b: 16): 9,
      (a: '10', b: 8): 8,
      (a: '10', b: null): 10,
      (a: '10', b: 16): 16,
      (a: 'A', b: 8): null,
      (a: 'A', b: null): null,
      (a: 'A', b: 16): 10,
      (a: '-A', b: 8): null,
      (a: '-A', b: null): null,
      (a: '-A', b: 16): -10,
      (a: 'Z', b: 8): null,
      (a: 'Z', b: null): null,
      (a: 'Z', b: 16): null,
      (a: '0xA', b: 8): null,
      (a: '0xA', b: null): 10,
      (a: '0xA', b: 16): null,
      (a: 'true', b: 8): null,
      (a: 'true', b: null): null,
      (a: 'true', b: 16): null,
      (a: 'false', b: 8): null,
      (a: 'false', b: null): null,
      (a: 'false', b: 16): null,
    };

    for (final MapEntry<({dynamic a, int? b}), int?> input in domain.entries) {
      test(
        '${input.key} // ${input.value}',
        () {
          expect(
            ModelUtils.fromJsonNullableInt(
              input.key.a,
              radix: input.key.b,
            ),
            input.value,
          );
        },
      );
    }
  });
}
