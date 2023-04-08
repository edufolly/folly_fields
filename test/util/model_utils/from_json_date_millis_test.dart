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

      Map<MapEntry<int?, DateTime?>, dynamic> domain =
          <MapEntry<int?, DateTime?>, dynamic>{
        MapEntry<int?, DateTime?>(null, now): now,
        MapEntry<int?, DateTime?>(now.millisecondsSinceEpoch, null): now,
        MapEntry<int?, DateTime?>(8640000000000001, now): now,
        const MapEntry<int?, DateTime?>(null, null): isA<DateTime>(),
        const MapEntry<int?, DateTime?>(-1, null): isA<DateTime>(),
        const MapEntry<int?, DateTime?>(0, null): DateTime.utc(1970).toLocal(),
        const MapEntry<int?, DateTime?>(1, null):
            DateTime.utc(1970, 1, 1, 0, 0, 0, 1).toLocal(),
        const MapEntry<int?, DateTime?>(1999, null):
            DateTime.utc(1970, 1, 1, 0, 0, 1, 999).toLocal(),
        const MapEntry<int?, DateTime?>(59999, null):
            DateTime.utc(1970, 1, 1, 0, 0, 59, 999).toLocal(),
        const MapEntry<int?, DateTime?>(3599999, null):
            DateTime.utc(1970, 1, 1, 0, 59, 59, 999).toLocal(),
        const MapEntry<int?, DateTime?>(8640000000000000, null):
            DateTime.utc(275760, 9, 13).toLocal(),
        const MapEntry<int?, DateTime?>(8640000000000001, null):
            isA<DateTime>(),
      };

      for (final MapEntry<MapEntry<int?, DateTime?>, dynamic> input
          in domain.entries) {
        test(
          '${input.key.key} - ${input.key.value}',
          () {
            expect(
              ModelUtils.fromJsonDateMillis(input.key.key, input.key.value),
              input.value,
            );
          },
        );
      }
    },
  );
}
