import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/color_validator.dart';

///
///
///
void main() {
  ColorValidator validator = ColorValidator();

  Map<String?, Color?> parseTests = <String?, Color?>{
    null: null,
    '': null,
    'FFF': Colors.white,
    '000': Colors.black,
    'F00': const Color(0xffff0000),
    '0F0': const Color(0xff00ff00),
    '00F': const Color(0xff0000ff),
    'FF0': const Color(0xffffff00),
    '0FF': const Color(0xff00ffff),
    'F0F': const Color(0xffff00ff),
    'FFFF': Colors.white,
    'F000': Colors.black,
    'FF00': const Color(0xffff0000),
    'F0F0': const Color(0xff00ff00),
    'F00F': const Color(0xff0000ff),
    'FFF0': const Color(0xffffff00),
    'F0FF': const Color(0xff00ffff),
    'FF0F': const Color(0xffff00ff),
    'AFFF': const Color(0xaaffffff),
    'FFFFF': const Color(0x000fffff),
    'FFFFFF': Colors.white,
    'FFFFFFF': const Color(0x0fffffff),
    'FFFFFFFF': Colors.white,
    'FFFFFFFFF': Colors.white,
    'FFFFFFFF0': Colors.white,
    '0FFFFFFFF': const Color(0x0fffffff),
    'FFFFFFFFG': Colors.white,
    'GFFFFFFFF': null,
    'GGG': null,
    'GGGG': null,
    'GGGGG': null,
    'GGGGGG': null,
    'GGGGGGG': null,
    'GGGGGGGG': null,
  };

  group(
    'ColorValidator parse',
    () {
      for (final MapEntry<String?, Color?> input in parseTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.parse(input.key), input.value),
        );
      }
    },
  );
}
