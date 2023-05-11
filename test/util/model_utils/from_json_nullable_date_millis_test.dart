import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group('ModelUtils fromJsonNullableDateMillis', () {
    DateTime now = DateTime.now().copyWith(microsecond: 0);

    Map<int?, DateTime?> domain = <int?, DateTime?>{
      null: null,
      now.millisecondsSinceEpoch: now,
      -1: null,
      0: DateTime.utc(1970).toLocal(),
      1: DateTime.utc(1970, 1, 1, 0, 0, 0, 1).toLocal(),
      1999: DateTime.utc(1970, 1, 1, 0, 0, 1, 999).toLocal(),
      59999: DateTime.utc(1970, 1, 1, 0, 0, 59, 999).toLocal(),
      3599999: DateTime.utc(1970, 1, 1, 0, 59, 59, 999).toLocal(),
      8640000000000000: DateTime.utc(275760, 9, 13).toLocal(),
      8640000000000001: null,
    };

    for (final MapEntry<int?, DateTime?> input in domain.entries) {
      test('${input.key} - ${input.value}', () {
        expect(
          ModelUtils.fromJsonNullableDateMillis(input.key),
          input.value,
        );
      });
    }
  });
}
