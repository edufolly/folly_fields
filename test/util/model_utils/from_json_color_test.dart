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
        ('0xF', null, const Color(0x0000000f)),
        ('0xZ', null, Colors.transparent),
        (null, 0xFF000000, Colors.black),
        ('0xF', 0xFF000000, const Color(0x0000000f)),
        ('0xZ', 0xFF000000, Colors.black),
        ('', null, Colors.transparent),
        (' ', null, Colors.transparent),
        ('#', null, Colors.transparent),
        ('F', null, Colors.transparent),
        ('#F', null, Colors.transparent),
        ('FF', null, Colors.transparent),
        ('#FF', null, Colors.transparent),
        ('FFF', null, Colors.white),
        ('#FFF', null, Colors.white),
        ('FFFF', null, Colors.white),
        ('#FFFF', null, Colors.white),
        ('FFFFF', null, Colors.transparent),
        ('#FFFFF', null, Colors.transparent),
        ('FFFFFF', null, Colors.white),
        ('#FFFFFF', null, Colors.white),
        ('#FFFFFFF', null, Colors.transparent),
        ('#FFFFFFFF', null, Colors.white),
        ('#FFFFFFFFF', null, Colors.white),
        (' ', 0xFF000000, Colors.black),
        ('#', 0xFF000000, Colors.black),
        ('F', 0xFF000000, Colors.black),
        ('#F', 0xFF000000, Colors.black),
        ('FF', 0xFF000000, Colors.black),
        ('#FF', 0xFF000000, Colors.black),
        ('FFF', 0xFF000000, Colors.white),
        ('#FFF', 0xFF000000, Colors.white),
        ('FFFF', 0xFF000000, Colors.white),
        ('#FFFF', 0xFF000000, Colors.white),
        ('0FFF', 0xFF000000, const Color(0x00FFFFFF)),
        ('#0FFF', 0xFF000000, const Color(0x00FFFFFF)),
        ('FFFFF', 0xFF000000, Colors.black),
        ('#FFFFF', 0xFF000000, Colors.black),
        ('FFFFFF', 0xFF000000, Colors.white),
        ('#FFFFFF', 0xFF000000, Colors.white),
        ('#FFFFFFF', 0xFF000000, Colors.black),
        ('#FFFFFFFF', 0xFF000000, Colors.white),
        ('#FFFFFFFFF', 0xFF000000, Colors.white),
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
