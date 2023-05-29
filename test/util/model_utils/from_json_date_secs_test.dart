import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/duplet.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonDateSecs',
    () {
      final DateTime now = DateTime.now().copyWith(
        millisecond: 0,
        microsecond: 0,
      );

      final Map<Duplet<int?, DateTime?>, dynamic> domain =
          <Duplet<int?, DateTime?>, dynamic>{
        Duplet<int?, DateTime?>(null, now): now,
        Duplet<int?, DateTime?>(now.millisecondsSinceEpoch ~/ 1000, null): now,
        Duplet<int?, DateTime?>(8640000000001, now): now,
        const Duplet<int?, DateTime?>(null, null): isA<DateTime>(),
        const Duplet<int?, DateTime?>(-1, null): isA<DateTime>(),
        const Duplet<int?, DateTime?>(0, null): DateTime.utc(1970).toLocal(),
        const Duplet<int?, DateTime?>(1, null):
            DateTime.utc(1970, 1, 1, 0, 0, 1).toLocal(),
        const Duplet<int?, DateTime?>(1999, null):
            DateTime.utc(1970, 1, 1, 0, 33, 19).toLocal(),
        const Duplet<int?, DateTime?>(59999, null):
            DateTime.utc(1970, 1, 1, 16, 39, 59).toLocal(),
        const Duplet<int?, DateTime?>(3599999, null):
            DateTime.utc(1970, 2, 11, 15, 59, 59).toLocal(),
        const Duplet<int?, DateTime?>(8640000000000, null):
            DateTime.utc(275760, 9, 13).toLocal(),
        const Duplet<int?, DateTime?>(8640000000001, null): isA<DateTime>(),
      };

      for (final MapEntry<Duplet<int?, DateTime?>, dynamic> input
          in domain.entries) {
        test(
          '${input.key} // ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonDateSecs(input.key.a, input.key.b),
              input.value,
            );
          },
        );
      }
    },
  );
}
