import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonDateSecs',
    () {
      DateTime now = DateTime.now().copyWith(
        millisecond: 0,
        microsecond: 0,
      );

      Set<(int?, DateTime?, dynamic)> domain = <(int?, DateTime?, dynamic)>{
        (null, now, now),
        (now.millisecondsSinceEpoch ~/ 1000, null, now),
        (8640000000001, now, now),
        (null, null, isA<DateTime>()),
        (-1, null, isA<DateTime>()),
        (0, null, DateTime.utc(1970).toLocal()),
        (1, null, DateTime.utc(1970, 1, 1, 0, 0, 1).toLocal()),
        (1999, null, DateTime.utc(1970, 1, 1, 0, 33, 19).toLocal()),
        (59999, null, DateTime.utc(1970, 1, 1, 16, 39, 59).toLocal()),
        (3599999, null, DateTime.utc(1970, 2, 11, 15, 59, 59).toLocal()),
        (8640000000000, null, DateTime.utc(275760, 9, 13).toLocal()),
        (8640000000001, null, isA<DateTime>()),
      };

      for (final (int? a, DateTime? b, dynamic r) in domain) {
        test(
          '$a // $b => $r',
          () => expect(ModelUtils.fromJsonDateSecs(a, b), r),
        );
      }
    },
  );
}
