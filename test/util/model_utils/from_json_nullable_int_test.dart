import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/duplet.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group('ModelUtils fromJsonNullableInt', () {
    final Map<Duplet<dynamic, int?>, int?> domain =
        <Duplet<dynamic, int?>, int?>{
      const Duplet<dynamic, int?>(null, 8): null,
      const Duplet<dynamic, int?>(null, null): null,
      const Duplet<dynamic, int?>(null, 16): null,
      const Duplet<dynamic, int?>(true, null): null,
      const Duplet<dynamic, int?>(false, null): null,
      const Duplet<dynamic, int?>(<dynamic>[], null): null,
      const Duplet<dynamic, int?>(<dynamic>{}, null): null,
      const Duplet<dynamic, int?>(<dynamic, dynamic>{}, null): null,
      const Duplet<dynamic, int?>(-9, 8): null,
      const Duplet<dynamic, int?>(-9, null): -9,
      const Duplet<dynamic, int?>(-9, 16): -9,
      const Duplet<dynamic, int?>(-1.0, 8): null,
      const Duplet<dynamic, int?>(-1.0, null): null,
      const Duplet<dynamic, int?>(-1.0, 16): null,
      const Duplet<dynamic, int?>(0, 8): 0,
      const Duplet<dynamic, int?>(0, null): 0,
      const Duplet<dynamic, int?>(0, 16): 0,
      const Duplet<dynamic, int?>(9, 8): null,
      const Duplet<dynamic, int?>(9, null): 9,
      const Duplet<dynamic, int?>(9, 16): 9,
      const Duplet<dynamic, int?>(10, 8): 8,
      const Duplet<dynamic, int?>(10, null): 10,
      const Duplet<dynamic, int?>(10, 16): 16,
      const Duplet<dynamic, int?>(1.0, 8): null,
      const Duplet<dynamic, int?>(1.0, null): null,
      const Duplet<dynamic, int?>(1.0, 16): null,
      const Duplet<dynamic, int?>(1.5, 8): null,
      const Duplet<dynamic, int?>(1.5, null): null,
      const Duplet<dynamic, int?>(1.5, 16): null,
      const Duplet<dynamic, int?>('', 8): null,
      const Duplet<dynamic, int?>('', null): null,
      const Duplet<dynamic, int?>('', 16): null,
      const Duplet<dynamic, int?>(' ', 8): null,
      const Duplet<dynamic, int?>(' ', null): null,
      const Duplet<dynamic, int?>(' ', 16): null,
      const Duplet<dynamic, int?>('-1', 8): -1,
      const Duplet<dynamic, int?>('-1', null): -1,
      const Duplet<dynamic, int?>('-1', 16): -1,
      const Duplet<dynamic, int?>('0', 8): 0,
      const Duplet<dynamic, int?>('0', null): 0,
      const Duplet<dynamic, int?>('0', 16): 0,
      const Duplet<dynamic, int?>('1.0', 8): null,
      const Duplet<dynamic, int?>('1.0', null): null,
      const Duplet<dynamic, int?>('1.0', 16): null,
      const Duplet<dynamic, int?>('1.5', 8): null,
      const Duplet<dynamic, int?>('1.5', null): null,
      const Duplet<dynamic, int?>('1.5', 16): null,
      const Duplet<dynamic, int?>('9', 8): null,
      const Duplet<dynamic, int?>('9', null): 9,
      const Duplet<dynamic, int?>('9', 16): 9,
      const Duplet<dynamic, int?>('10', 8): 8,
      const Duplet<dynamic, int?>('10', null): 10,
      const Duplet<dynamic, int?>('10', 16): 16,
      const Duplet<dynamic, int?>('A', 8): null,
      const Duplet<dynamic, int?>('A', null): null,
      const Duplet<dynamic, int?>('A', 16): 10,
      const Duplet<dynamic, int?>('-A', 8): null,
      const Duplet<dynamic, int?>('-A', null): null,
      const Duplet<dynamic, int?>('-A', 16): -10,
      const Duplet<dynamic, int?>('Z', 8): null,
      const Duplet<dynamic, int?>('Z', null): null,
      const Duplet<dynamic, int?>('Z', 16): null,
      const Duplet<dynamic, int?>('0xA', 8): null,
      const Duplet<dynamic, int?>('0xA', null): 10,
      const Duplet<dynamic, int?>('0xA', 16): null,
      const Duplet<dynamic, int?>('true', 8): null,
      const Duplet<dynamic, int?>('true', null): null,
      const Duplet<dynamic, int?>('true', 16): null,
      const Duplet<dynamic, int?>('false', 8): null,
      const Duplet<dynamic, int?>('false', null): null,
      const Duplet<dynamic, int?>('false', 16): null,
    };

    for (final MapEntry<Duplet<dynamic, int?>, int?> input in domain.entries) {
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
