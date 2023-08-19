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
      Map<({String? a, int? b}), Color> domain = <({String? a, int? b}), Color>{
        (a: null, b: null): Colors.transparent,
        (a: null, b: 0xFF000000): Colors.black,
        (a: '', b: null): Colors.transparent,
        (a: '#', b: null): Colors.transparent,
        (a: '#F', b: null): Colors.transparent,
        (a: '#FF', b: null): Colors.transparent,
        (a: '#FFF', b: null): Colors.white,
        (a: '#', b: 0xFF000000): Colors.black,
        (a: '#F', b: 0xFF000000): Colors.black,
        (a: '#FF', b: 0xFF000000): Colors.black,
        (a: '#FFF', b: 0xFF000000): Colors.white,
      };

      for (MapEntry<({String? a, int? b}), Color> input in domain.entries) {
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
