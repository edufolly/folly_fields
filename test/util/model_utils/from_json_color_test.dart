import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/duplet.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonColor',
    () {
      final Map<Duplet<String?, int?>, Color> domain =
          <Duplet<String?, int?>, Color>{
        const Duplet<String?, int?>(null, null): Colors.transparent,
        const Duplet<String?, int?>(null, 0xFF000000): Colors.black,
        const Duplet<String?, int?>('', null): Colors.transparent,
        const Duplet<String?, int?>('#', null): Colors.transparent,
        const Duplet<String?, int?>('#F', null): Colors.transparent,
        const Duplet<String?, int?>('#FF', null): Colors.transparent,
        const Duplet<String?, int?>('#FFF', null): Colors.white,
        const Duplet<String?, int?>('#', 0xFF000000): Colors.black,
        const Duplet<String?, int?>('#F', 0xFF000000): Colors.black,
        const Duplet<String?, int?>('#FF', 0xFF000000): Colors.black,
        const Duplet<String?, int?>('#FFF', 0xFF000000): Colors.white,
      };

      for (final MapEntry<Duplet<String?, int?>, Color> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonColor(input.key.a, input.key.b),
              input.value,
            );
          },
        );
      }
    },
  );
}
