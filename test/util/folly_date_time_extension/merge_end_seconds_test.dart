import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_date_time_extension.dart';

///
///
///
void main() {
  group(
    'DateTimeExtension mergeEndSeconds',
    () {
      Map<String, DateTime> domain = <String, DateTime>{
        '2000-01-01T00:00:59.999':
            DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeEndSeconds(),
        '2000-01-01T00:00:59.999888':
            DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          microsecond: 888,
        ),
        '2000-01-01T00:00:22.999':
            DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
        ),
        '2000-01-01T00:00:22.999888':
            DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          microsecond: 888,
        ),
        '2000-01-01T00:00:22.222':
            DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
        ),
        '2000-01-01T00:00:22.222888':
            DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-01-01T00:00:59.222':
            DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
        ),
        '2000-01-01T00:00:59.222888':
            DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-01T00:00:59.999':
            DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeEndSeconds(),
        '2000-12-01T00:00:59.999888':
            DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          microsecond: 888,
        ),
        '2000-12-01T00:00:22.999':
            DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
        ),
        '2000-12-01T00:00:22.999888':
            DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          microsecond: 888,
        ),
        '2000-12-01T00:00:22.222':
            DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
        ),
        '2000-12-01T00:00:22.222888':
            DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-01T00:00:59.222':
            DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
        ),
        '2000-12-01T00:00:59.222888':
            DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T00:00:59.999':
            DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeEndSeconds(),
        '2000-12-31T00:00:59.999888':
            DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeEndSeconds(
          microsecond: 888,
        ),
        '2000-12-31T00:00:22.999':
            DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
        ),
        '2000-12-31T00:00:22.999888':
            DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          microsecond: 888,
        ),
        '2000-12-31T00:00:22.222':
            DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
        ),
        '2000-12-31T00:00:22.222888':
            DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T00:00:59.222':
            DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
        ),
        '2000-12-31T00:00:59.222888':
            DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T23:00:59.999':
            DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeEndSeconds(),
        '2000-12-31T23:00:59.999888':
            DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeEndSeconds(
          microsecond: 888,
        ),
        '2000-12-31T23:00:22.999':
            DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
        ),
        '2000-12-31T23:00:22.999888':
            DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          microsecond: 888,
        ),
        '2000-12-31T23:00:22.222':
            DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
        ),
        '2000-12-31T23:00:22.222888':
            DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T23:00:59.222':
            DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
        ),
        '2000-12-31T23:00:59.222888':
            DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T23:59:59.999':
            DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeEndSeconds(),
        '2000-12-31T23:59:59.999888':
            DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeEndSeconds(
          microsecond: 888,
        ),
        '2000-12-31T23:59:22.999':
            DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeEndSeconds(
          second: 22,
        ),
        '2000-12-31T23:59:22.999888':
            DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeEndSeconds(
          second: 22,
          microsecond: 888,
        ),
        '2000-12-31T23:59:22.222':
            DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
        ),
        '2000-12-31T23:59:22.222888':
            DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeEndSeconds(
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T23:59:59.222':
            DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
        ),
        '2000-12-31T23:59:59.222888':
            DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeEndSeconds(
          millisecond: 222,
          microsecond: 888,
        ),
      };

      for (MapEntry<String?, DateTime?> input in domain.entries) {
        test(
          'Testing ${input.key}',
          () => expect(input.key, input.value?.toIso8601String()),
        );
      }
    },
  );
}
