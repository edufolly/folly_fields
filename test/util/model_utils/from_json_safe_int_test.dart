import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group('ModelUtils fromJsonSafeInt', () {
    Set<(dynamic, int?, int, int?)> domain = <(dynamic, int?, int, int?)>{
      (null, 8, 1, 1),
      (null, null, 1, 1),
      (null, 16, 1, 1),
      (true, null, 1, 1),
      (false, null, 1, 1),
      (<dynamic>[], null, 1, 1),
      (<dynamic>{}, null, 1, 1),
      (<dynamic, dynamic>{}, null, 1, 1),
      (-9, 8, 1, 1),
      (-9, null, 1, -9),
      (-9, 16, 1, -9),
      (-1.0, 8, 1, 1),
      (-1.0, null, 1, 1),
      (-1.0, 16, 1, 1),
      (0, 8, 1, 0),
      (0, null, 1, 0),
      (0, 16, 1, 0),
      (9, 8, 1, 1),
      (9, null, 1, 9),
      (9, 16, 1, 9),
      (10, 8, 1, 8),
      (10, null, 1, 10),
      (10, 16, 1, 16),
      (1.0, 8, 1, 1),
      (1.0, null, 1, 1),
      (1.0, 16, 1, 1),
      (1.5, 8, 1, 1),
      (1.5, null, 1, 1),
      (1.5, 16, 1, 1),
      ('', 8, 1, 1),
      ('', null, 1, 1),
      ('', 16, 1, 1),
      (' ', 8, 1, 1),
      (' ', null, 1, 1),
      (' ', 16, 1, 1),
      ('-1', 8, 1, -1),
      ('-1', null, 1, -1),
      ('-1', 16, 1, -1),
      ('0', 8, 1, 0),
      ('0', null, 1, 0),
      ('0', 16, 1, 0),
      ('1.0', 8, 1, 1),
      ('1.0', null, 1, 1),
      ('1.0', 16, 1, 1),
      ('1.5', 8, 1, 1),
      ('1.5', null, 1, 1),
      ('1.5', 16, 1, 1),
      ('9', 8, 1, 1),
      ('9', null, 1, 9),
      ('9', 16, 1, 9),
      ('10', 8, 1, 8),
      ('10', null, 1, 10),
      ('10', 16, 1, 16),
      ('A', 8, 1, 1),
      ('A', null, 1, 1),
      ('A', 16, 1, 10),
      ('-A', 8, 1, 1),
      ('-A', null, 1, 1),
      ('-A', 16, 1, -10),
      ('Z', 8, 1, 1),
      ('Z', null, 1, 1),
      ('Z', 16, 1, 1),
      ('0xA', 8, 1, 1),
      ('0xA', null, 1, 10),
      ('0xA', 16, 1, 1),
      ('true', 8, 1, 1),
      ('true', null, 1, 1),
      ('true', 16, 1, 1),
      ('false', 8, 1, 1),
      ('false', null, 1, 1),
      ('false', 16, 1, 1),
    };

    for (final (dynamic a, int? b, int c, int? r) in domain) {
      test(
        '$a // $b // $c => $r',
        () => expect(
          ModelUtils.fromJsonSafeInt(a, radix: b, defaultValue: c),
          r,
        ),
      );
    }
  });
}
