import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/extensions/folly_date_time_extension.dart';

///
///
///
void main() {
  group(
    'DateTimeExtension mergeEnd',
    () {
      Set<(String, DateTime)> domain = <(String, DateTime)>{
        (
          '2000-01-01T23:59:59.999',
          DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeEnd()
        ),
        (
          '2000-01-01T23:59:59.999888',
          DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeEnd(
            microsecond: 888,
          )
        ),
        (
          '2000-01-01T23:59:22.999',
          DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
          )
        ),
        (
          '2000-01-01T23:59:22.999888',
          DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-01-01T23:59:22.222',
          DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-01-01T23:59:22.222888',
          DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-01-01T23:59:59.222',
          DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeEnd(
            millisecond: 222,
          )
        ),
        (
          '2000-01-01T23:59:59.222888',
          DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeEnd(
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-01T23:59:59.999',
          DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeEnd()
        ),
        (
          '2000-12-01T23:59:59.999888',
          DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeEnd(
            microsecond: 888,
          )
        ),
        (
          '2000-12-01T23:59:22.999',
          DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
          )
        ),
        (
          '2000-12-01T23:59:22.999888',
          DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-12-01T23:59:22.222',
          DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-12-01T23:59:22.222888',
          DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-01T23:59:59.222',
          DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeEnd(
            millisecond: 222,
          )
        ),
        (
          '2000-12-01T23:59:59.222888',
          DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeEnd(
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:59:59.999',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd()
        ),
        (
          '2000-12-31T23:59:59.999888',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:59:22.999',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
          )
        ),
        (
          '2000-12-31T23:59:22.999888',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:59:22.222',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T23:59:22.222888',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T23:59:59.222',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T23:59:59.222888',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T22:22:59.999',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            time: const TimeOfDay(hour: 22, minute: 22),
          )
        ),
        (
          '2000-12-31T22:22:59.999888',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            time: const TimeOfDay(hour: 22, minute: 22),
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T22:22:22.999',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            time: const TimeOfDay(hour: 22, minute: 22),
            second: 22,
          )
        ),
        (
          '2000-12-31T22:22:22.999888',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            time: const TimeOfDay(hour: 22, minute: 22),
            second: 22,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T22:22:22.222',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            time: const TimeOfDay(hour: 22, minute: 22),
            second: 22,
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T22:22:22.222888',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            time: const TimeOfDay(hour: 22, minute: 22),
            second: 22,
            millisecond: 222,
            microsecond: 888,
          )
        ),
        (
          '2000-12-31T22:22:59.222',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            time: const TimeOfDay(hour: 22, minute: 22),
            millisecond: 222,
          )
        ),
        (
          '2000-12-31T22:22:59.222888',
          DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeEnd(
            time: const TimeOfDay(hour: 22, minute: 22),
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
