import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonDateMillis',
    () {
      DateTime now = DateTime.now().copyWith(microsecond: 0);

      Set<(int?, DateTime?, dynamic)> domain = <(int?, DateTime?, dynamic)>{
        (null, now, now),
        (now.millisecondsSinceEpoch, null, now),
        (8640000000000001, now, now),
        (null, null, isA<DateTime>()),
        (-1, null, isA<DateTime>()),
        (0, null, DateTime.utc(1970).toLocal()),
        (1, null, DateTime.utc(1970, 1, 1, 0, 0, 0, 1).toLocal()),
        (1999, null, DateTime.utc(1970, 1, 1, 0, 0, 1, 999).toLocal()),
        (59999, null, DateTime.utc(1970, 1, 1, 0, 0, 59, 999).toLocal()),
        (3599999, null, DateTime.utc(1970, 1, 1, 0, 59, 59, 999).toLocal()),
        (8640000000000000, null, DateTime.utc(275760, 9, 13).toLocal()),
        (8640000000000001, null, isA<DateTime>()),
      };

      for (final (int? a, DateTime? b, dynamic r) in domain) {
        test(
          '$a // $b => $r',
          () => expect(ModelUtils.fromJsonDateMillis(a, b), r),
        );
      }
    },
  );
}
