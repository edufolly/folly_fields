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
      final DateTime now = DateTime.now().copyWith(microsecond: 0);

      final Map<({int? a, DateTime? b}), dynamic> domain =
          <({int? a, DateTime? b}), dynamic>{
        (a: null, b: now): now,
        (a: now.millisecondsSinceEpoch, b: null): now,
        (a: 8640000000000001, b: now): now,
        (a: null, b: null): isA<DateTime>(),
        (a: -1, b: null): isA<DateTime>(),
        (a: 0, b: null): DateTime.utc(1970).toLocal(),
        (a: 1, b: null): DateTime.utc(1970, 1, 1, 0, 0, 0, 1).toLocal(),
        (a: 1999, b: null): DateTime.utc(1970, 1, 1, 0, 0, 1, 999).toLocal(),
        (a: 59999, b: null): DateTime.utc(1970, 1, 1, 0, 0, 59, 999).toLocal(),
        (a: 3599999, b: null):
            DateTime.utc(1970, 1, 1, 0, 59, 59, 999).toLocal(),
        (a: 8640000000000000, b: null): DateTime.utc(275760, 9, 13).toLocal(),
        (a: 8640000000000001, b: null): isA<DateTime>(),
      };

      for (final MapEntry<({int? a, DateTime? b}), dynamic> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonDateMillis(input.key.a, input.key.b),
              input.value,
            );
          },
        );
      }
    },
  );
}
