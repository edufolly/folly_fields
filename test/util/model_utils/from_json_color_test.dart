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
      Set<(String?, int?, Color)> domain = <(String?, int?, Color)>{
        (null, null, Colors.transparent),
        (null, 0xFF000000, Colors.black),
        ('', null, Colors.transparent),
        ('#', null, Colors.transparent),
        ('#F', null, Colors.transparent),
        ('#FF', null, Colors.transparent),
        ('#FFF', null, Colors.white),
        ('#', 0xFF000000, Colors.black),
        ('#F', 0xFF000000, Colors.black),
        ('#FF', 0xFF000000, Colors.black),
        ('#FFF', 0xFF000000, Colors.white),
      };

      for (final (String? a, int? b, Color r) in domain) {
        test(
          '$a // $b => $r',
          () => expect(ModelUtils.fromJsonColor(a, b), r),
        );
      }
    },
  );
}
