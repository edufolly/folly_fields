import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_utils.dart';

void main() {
  const Color red = Color(0xFFFF0000);
  const Color green = Color(0xFF00FF00);
  const Color blue = Color(0xFF0000FF);

  Map<String?, Color?> domain = <String?, Color?>{
    null: null,
    '': null,
    ' ': null,
    '#': null,
    '0': null,
    '#0': null,
    '00': null,
    '#00': null,
    '0x0': Colors.transparent,
    '0xFF000000FF': Colors.black,
    //
    '0xFFFF0000': red,
    '#FFFF0000': red,
    '#FFFF000': null,
    '#FF0000': red,
    '#FF000': null,
    '#FF00': red,
    '#F00': red,
    //
    '0xFF00FF00': green,
    '#FF00FF00': green,
    '#FF00FF0': null,
    '#00FF00': green,
    '#00FF0': null,
    '#F0F0': green,
    '#0F0': green,
    //
    '0xFF0000FF': blue,
    '#FF0000FF': blue,
    '#FF000FF': null,
    '#0000FF': blue,
    '#000FF': null,
    '#F00F': blue,
    '#00F': blue,
  };

  group('colorParse', () {
    for (final MapEntry<String?, Color?>(:String? key, :Color? value)
        in domain.entries) {
      test('Testing $key', () => expect(FollyUtils.colorParse(key), value));
    }
  });
}
