import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group(
    'ModelUtils fromJsonNullableDateSecs',
    () {
      DateTime now = DateTime.now().copyWith(millisecond: 0, microsecond: 0);

      Map<int?, DateTime?> domain = <int?, DateTime?>{
        null: null,
        now.millisecondsSinceEpoch ~/ 1000: now,
        -1: null,
        0: DateTime.utc(1970).toLocal(),
        1: DateTime.utc(1970, 1, 1, 0, 0, 1).toLocal(),
        1999: DateTime.utc(1970, 1, 1, 0, 33, 19).toLocal(),
        59999: DateTime.utc(1970, 1, 1, 16, 39, 59).toLocal(),
        3599999: DateTime.utc(1970, 2, 11, 15, 59, 59).toLocal(),
        8640000000000: DateTime.utc(275760, 9, 13).toLocal(),
        8640000000001: null,
      };

      for (final MapEntry<int?, DateTime?> input in domain.entries) {
        test(
          '${input.key} - ${input.value}',
          () {
            expect(
              ModelUtils.fromJsonNullableDateSecs(input.key),
              input.value,
            );
          },
        );
      }
    },
  );
}
