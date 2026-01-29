import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/extensions/folly_date_time_extension.dart';

///
///
///
void main() {
  group(
    'DateTimeExtension mergeStartSeconds',
    () {
      Set<(String, DateTime)> domain = <(String, DateTime)>{
        (
          '2000-01-01T00:00:00.000',
          DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeStartSeconds()
        ),
        (
          '2000-01-01T00:00:00.000888',
          DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            microsecond: 888,
          )
        ),
        (
          '2000-01-01T00:00:22.000',
          DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
          )
        ),
        (
          '2000-01-01T00:00:22.000888',
          DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-01-01T00:00:22.222',
          DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-01-01T00:00:22.222888',
          DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-01-01T00:00:00.222',
          DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
          )
        ),
        (
          '2000-01-01T00:00:00.222888',
          DateTime(2000, 1, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-01T00:00:00.000',
          DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeStartSeconds()
        ),
        (
          '2000-12-01T00:00:00.000888',
          DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            microsecond: 888,
          )
        ),
        (
          '2000-12-01T00:00:22.000',
          DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
          )
        ),
        (
          '2000-12-01T00:00:22.000888',
          DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-12-01T00:00:22.222',
          DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-12-01T00:00:22.222888',
          DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-01T00:00:00.222',
          DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
          )
        ),
        (
          '2000-12-01T00:00:00.222888',
          DateTime(2000, 12, 1, 0, 0, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T00:00:00.000',
          DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeStartSeconds()
        ),
        (
          '2000-12-31T00:00:00.000888',
          DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeStartSeconds(
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T00:00:22.000',
          DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
          )
        ),
        (
          '2000-12-31T00:00:22.000888',
          DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T00:00:22.222',
          DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T00:00:22.222888',
          DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T00:00:00.222',
          DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T00:00:00.222888',
          DateTime(2000, 12, 31, 0, 0, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:00:00.000',
          DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeStartSeconds()
        ),
        (
          '2000-12-31T23:00:00.000888',
          DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeStartSeconds(
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:00:22.000',
          DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
          )
        ),
        (
          '2000-12-31T23:00:22.000888',
          DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:00:22.222',
          DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T23:00:22.222888',
          DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:00:00.222',
          DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T23:00:00.222888',
          DateTime(2000, 12, 31, 23, 0, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:59:00.000',
          DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeStartSeconds()
        ),
        (
          '2000-12-31T23:59:00.000888',
          DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeStartSeconds(
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:59:22.000',
          DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeStartSeconds(
            second: 22,
          )
        ),
        (
          '2000-12-31T23:59:22.000888',
          DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeStartSeconds(
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:59:22.222',
          DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T23:59:22.222888',
          DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeStartSeconds(
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:59:00.222',
          DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T23:59:00.222888',
          DateTime(2000, 12, 31, 23, 59, 11, 111, 111).mergeStartSeconds(
            millisecond: 222,
            microsecond: 888,
          )
        ),
      };

      for (final (String key, DateTime value) in domain) {
        test(
          'Testing $key',
          () => expect(key, value.toIso8601String()),
        );
      }
    },
  );
}
