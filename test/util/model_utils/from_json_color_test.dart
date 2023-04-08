import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonColor',
    () {
      Map<MapEntry<String?, int?>, Color> domain =
          <MapEntry<String?, int?>, Color>{
        const MapEntry<String?, int?>(null, null): Colors.transparent,
        const MapEntry<String?, int?>(null, 0xFF000000): Colors.black,
        const MapEntry<String?, int?>('', null): Colors.transparent,
        const MapEntry<String?, int?>('#', null): Colors.transparent,
        const MapEntry<String?, int?>('#F', null): Colors.transparent,
        const MapEntry<String?, int?>('#FF', null): Colors.transparent,
        const MapEntry<String?, int?>('#FFF', null): Colors.white,
        const MapEntry<String?, int?>('#', 0xFF000000): Colors.black,
        const MapEntry<String?, int?>('#F', 0xFF000000): Colors.black,
        const MapEntry<String?, int?>('#FF', 0xFF000000): Colors.black,
        const MapEntry<String?, int?>('#FFF', 0xFF000000): Colors.white,
      };

      for (final MapEntry<MapEntry<String?, int?>, Color> input
          in domain.entries) {
        test(
          '${input.key.key} - ${input.key.value}',
          () {
            expect(
              ModelUtils.fromJsonColor(input.key.key, input.key.value),
              input.value,
            );
          },
        );
      }
    },
  );
}
