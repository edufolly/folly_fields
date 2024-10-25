import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group('ModelUtils fromJsonNullableInt', () {
    Set<(dynamic, int?, int?)> domain = <(dynamic, int?, int?)>{
      (null, 8, null),
      (null, null, null),
      (null, 16, null),
      (true, null, null),
      (false, null, null),
      (<dynamic>[], null, null),
      (<dynamic>{}, null, null),
      (<dynamic, dynamic>{}, null, null),
      (-9, 8, null),
      (-9, null, -9),
      (-9, 16, -9),
      (-1.0, 8, null),
      (-1.0, null, null),
      (-1.0, 16, null),
      (0, 8, 0),
      (0, null, 0),
      (0, 16, 0),
      (9, 8, null),
      (9, null, 9),
      (9, 16, 9),
      (10, 8, 8),
      (10, null, 10),
      (10, 16, 16),
      (1.0, 8, null),
      (1.0, null, null),
      (1.0, 16, null),
      (1.5, 8, null),
      (1.5, null, null),
      (1.5, 16, null),
      ('', 8, null),
      ('', null, null),
      ('', 16, null),
      (' ', 8, null),
      (' ', null, null),
      (' ', 16, null),
      ('-1', 8, -1),
      ('-1', null, -1),
      ('-1', 16, -1),
      ('0', 8, 0),
      ('0', null, 0),
      ('0', 16, 0),
      ('1.0', 8, null),
      ('1.0', null, null),
      ('1.0', 16, null),
      ('1.5', 8, null),
      ('1.5', null, null),
      ('1.5', 16, null),
      ('9', 8, null),
      ('9', null, 9),
      ('9', 16, 9),
      ('10', 8, 8),
      ('10', null, 10),
      ('10', 16, 16),
      ('A', 8, null),
      ('A', null, null),
      ('A', 16, 10),
      ('-A', 8, null),
      ('-A', null, null),
      ('-A', 16, -10),
      ('Z', 8, null),
      ('Z', null, null),
      ('Z', 16, null),
      ('0xA', 8, null),
      ('0xA', null, 10),
      ('0xA', 16, null),
      ('true', 8, null),
      ('true', null, null),
      ('true', 16, null),
      ('false', 8, null),
      ('false', null, null),
      ('false', 16, null),
    };

    for (final (dynamic a, int? b, int? r) in domain) {
      test(
        '$a // $b => $r',
        () => expect(ModelUtils.fromJsonNullableInt(a, radix: b), r),
      );
    }
  });
}
