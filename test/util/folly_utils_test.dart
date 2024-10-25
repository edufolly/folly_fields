import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_utils.dart';

///
///
///
void main() {
  ///
  /// createMaterialColor
  ///
  const Color staticColor = Colors.black;

  MaterialColor staticMaterialColor = MaterialColor(
    staticColor.value,
    const <int, Color>{
      50: staticColor,
      100: staticColor,
      200: staticColor,
      300: staticColor,
      400: staticColor,
      500: staticColor,
      600: staticColor,
      700: staticColor,
      800: staticColor,
      900: staticColor,
    },
  );

  group(
    'createMaterialColor',
    () {
      test(
        'Testing all null',
        () => expect(FollyUtils.createMaterialColor(), null),
      );

      test(
        'Testing Color',
        () => expect(
          FollyUtils.createMaterialColor(color: staticColor),
          staticMaterialColor,
        ),
      );

      test(
        'Testing Integer Color',
        () => expect(
          FollyUtils.createMaterialColor(intColor: staticColor.value),
          staticMaterialColor,
        ),
      );
    },
  );
}
