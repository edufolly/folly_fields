import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/date_time_extension.dart';

///
///
///
void main() {
  group(
    'DateTimeExtension mergeStart',
    () {
      Map<String, DateTime> domain = <String, DateTime>{
        '2000-01-01T00:00:00.000':
            DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeStart(),
        '2000-01-01T00:00:00.000888':
            DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeStart(
          microsecond: 888,
        ),
        '2000-01-01T00:00:22.000':
            DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
        ),
        '2000-01-01T00:00:22.000888':
            DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          microsecond: 888,
        ),
        '2000-01-01T00:00:22.222':
            DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          millisecond: 222,
        ),
        '2000-01-01T00:00:22.222888':
            DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-01-01T00:00:00.222':
            DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeStart(
          millisecond: 222,
        ),
        '2000-01-01T00:00:00.222888':
            DateTime(2000, 1, 1, 11, 11, 11, 111, 111).mergeStart(
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-01T00:00:00.000':
            DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeStart(),
        '2000-12-01T00:00:00.000888':
            DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeStart(
          microsecond: 888,
        ),
        '2000-12-01T00:00:22.000':
            DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
        ),
        '2000-12-01T00:00:22.000888':
            DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          microsecond: 888,
        ),
        '2000-12-01T00:00:22.222':
            DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          millisecond: 222,
        ),
        '2000-12-01T00:00:22.222888':
            DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-01T00:00:00.222':
            DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeStart(
          millisecond: 222,
        ),
        '2000-12-01T00:00:00.222888':
            DateTime(2000, 12, 1, 11, 11, 11, 111, 111).mergeStart(
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T00:00:00.000':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(),
        '2000-12-31T00:00:00.000888':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          microsecond: 888,
        ),
        '2000-12-31T00:00:22.000':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
        ),
        '2000-12-31T00:00:22.000888':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          microsecond: 888,
        ),
        '2000-12-31T00:00:22.222':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          millisecond: 222,
        ),
        '2000-12-31T00:00:22.222888':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T00:00:00.222':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          millisecond: 222,
        ),
        '2000-12-31T00:00:00.222888':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T23:59:00.000':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          time: const TimeOfDay(hour: 23, minute: 59),
        ),
        '2000-12-31T23:59:00.000888':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          time: const TimeOfDay(hour: 23, minute: 59),
          microsecond: 888,
        ),
        '2000-12-31T23:59:22.000':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          time: const TimeOfDay(hour: 23, minute: 59),
          second: 22,
        ),
        '2000-12-31T23:59:22.000888':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          time: const TimeOfDay(hour: 23, minute: 59),
          second: 22,
          microsecond: 888,
        ),
        '2000-12-31T23:59:22.222':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          time: const TimeOfDay(hour: 23, minute: 59),
          second: 22,
          millisecond: 222,
        ),
        '2000-12-31T23:59:22.222888':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          time: const TimeOfDay(hour: 23, minute: 59),
          second: 22,
          millisecond: 222,
          microsecond: 888,
        ),
        '2000-12-31T23:59:00.222':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          time: const TimeOfDay(hour: 23, minute: 59),
          millisecond: 222,
        ),
        '2000-12-31T23:59:00.222888':
            DateTime(2000, 12, 31, 11, 11, 11, 111, 111).mergeStart(
          time: const TimeOfDay(hour: 23, minute: 59),
          millisecond: 222,
          microsecond: 888,
        ),
      };

      for (final MapEntry<String?, DateTime?> input in domain.entries) {
        test(
          'Testing ${input.key}',
          () => expect(input.key, input.value?.toIso8601String()),
        );
      }
    },
  );
}
