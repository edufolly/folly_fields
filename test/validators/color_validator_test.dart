import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/color_validator.dart';

///
///
///
void main() {
  group(
    'ColorValidator isValid',
    () {
      final Map<String, bool> domain = <String, bool>{
        '': false,
        ' ': false,
        'F': false,
        'FF': false,
        '0x': false,
        'FFF': true,
        '000': true,
        '0x0': true,
        '0x1': true,
        '0x9': true,
        '0xA': true,
        '0xF': true,
        '0xG': false,
        'F00': true,
        '0F0': true,
        '00F': true,
        'FF0': true,
        '0FF': true,
        'F0F': true,
        'FFFF': true,
        'F000': true,
        'FF00': true,
        'F0F0': true,
        'F00F': true,
        'FFF0': true,
        'F0FF': true,
        'FF0F': true,
        'AFFF': true,
        'FFFFF': false,
        'FFFFFF': true,
        'FFFFFFF': false,
        'FFFFFFFF': true,
        'FFFFFFFFF': true,
        'FFFFFFFF0': true,
        '0FFFFFFFF': true,
        'FFFFFFFFG': true,
        'GFFFFFFFF': false,
        'G': false,
        'GG': false,
        'GGG': false,
        'GGGG': false,
        'GGGGG': false,
        'GGGGGG': false,
        'GGGGGGG': false,
        'GGGGGGGG': false,
      };

      final ColorValidator validator = ColorValidator();

      for (final MapEntry<String, bool> input in domain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  group(
    'ColorValidator parse',
    () {
      final Map<String?, Color?> domain = <String?, Color?>{
        null: null,
        '': null,
        ' ': null,
        'F': null,
        'FF': null,
        '0x': null,
        'FFF': Colors.white,
        '000': Colors.black,
        '0x0': Colors.transparent,
        '0x1': const Color(0x00000001),
        '0x9': const Color(0x00000009),
        '0xA': const Color(0x0000000a),
        '0xF': const Color(0x0000000f),
        '0xG': null,
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
        'FFFFF': null,
        'FFFFFF': Colors.white,
        'FFFFFFF': null,
        'FFFFFFFF': Colors.white,
        'FFFFFFFFF': Colors.white,
        'FFFFFFFF0': Colors.white,
        '0FFFFFFFF': const Color(0x0fffffff),
        'FFFFFFFFG': Colors.white,
        'GFFFFFFFF': null,
        'G': null,
        'GG': null,
        'GGG': null,
        'GGGG': null,
        'GGGGG': null,
        'GGGGGG': null,
        'GGGGGGG': null,
        'GGGGGGGG': null,
      };

      final ColorValidator validator = ColorValidator();

      for (final MapEntry<String?, Color?> input in domain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.parse(input.key), input.value),
        );
      }
    },
  );

  group(
    'ColorValidator format',
    () {
      final List<String> ocp = <String>['0', 'F'];

      final ColorValidator validator = ColorValidator();

      for (final String oc0 in ocp) {
        for (final String oc1 in ocp) {
          for (final String oc2 in ocp) {
            for (final String oc3 in ocp) {
              for (final String oc4 in ocp) {
                for (final String oc5 in ocp) {
                  for (final String oc6 in ocp) {
                    for (final String oc7 in ocp) {
                      final String value = '$oc0$oc1$oc2$oc3$oc4$oc5$oc6$oc7';
                      final Color key =
                          Color(int.tryParse('0x$value') ?? 0x00000000);

                      test(
                        'Testing: $key',
                        () => expect(validator.format(key), value),
                      );
                    }
                  }
                }
              }
            }
          }
        }
      }
    },
  );

  group(
    'ColorValidator parse with default color',
    () {
      const Color red = Color(0xffff0000);

      final Map<String?, Color?> domain = <String?, Color?>{
        null: red,
        '': red,
        ' ': red,
        'F': red,
        'FF': red,
        '0x': red,
        'FFF': Colors.white,
        'FFFF': Colors.white,
        'FFFFFF': Colors.white,
        'FFFFFFFF': Colors.white,
        'FFFFFFFFF': Colors.white,
        'FFFFFFFF0': Colors.white,
        'GFFFFFFFF': red,
        'G': red,
        'GG': red,
        'GGG': red,
        'GGGG': red,
        'GGGGG': red,
        'GGGGGG': red,
        'GGGGGGG': red,
        'GGGGGGGG': red,
      };

      final ColorValidator validator = ColorValidator();

      for (final MapEntry<String?, Color?> input in domain.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(
            validator.parse(input.key, intColor: 0xffff0000),
            input.value,
          ),
        );
      }
    },
  );

  group('TimeValidator Coverage', () {
    final ColorValidator validator = ColorValidator();

    test('strip', () => expect(validator.strip('#FFFFFF'), '#FFFFFF'));

    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
