import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_utils.dart';

///
///
///
void main() {
  Map<String?, DateTime?> domain = <String?, DateTime?>{
    null: FollyUtils.dateMergeStart(date: null),
    '2000-01-01T00:00:00.000': FollyUtils.dateMergeStart(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
    ),
    '2000-01-01T00:00:00.000888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      microsecond: 888,
    ),
    '2000-01-01T00:00:22.000': FollyUtils.dateMergeStart(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      second: 22,
    ),
    '2000-01-01T00:00:22.000888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      second: 22,
      microsecond: 888,
    ),
    '2000-01-01T00:00:22.222': FollyUtils.dateMergeStart(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
    ),
    '2000-01-01T00:00:22.222888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-01-01T00:00:00.222': FollyUtils.dateMergeStart(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      millisecond: 222,
    ),
    '2000-01-01T00:00:00.222888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-01T00:00:00.000': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
    ),
    '2000-12-01T00:00:00.000888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      microsecond: 888,
    ),
    '2000-12-01T00:00:22.000': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      second: 22,
    ),
    '2000-12-01T00:00:22.000888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      second: 22,
      microsecond: 888,
    ),
    '2000-12-01T00:00:22.222': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
    ),
    '2000-12-01T00:00:22.222888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-01T00:00:00.222': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      millisecond: 222,
    ),
    '2000-12-01T00:00:00.222888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-31T00:00:00.000': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
    ),
    '2000-12-31T00:00:00.000888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      microsecond: 888,
    ),
    '2000-12-31T00:00:22.000': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      second: 22,
    ),
    '2000-12-31T00:00:22.000888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      second: 22,
      microsecond: 888,
    ),
    '2000-12-31T00:00:22.222': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
    ),
    '2000-12-31T00:00:22.222888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-31T00:00:00.222': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      millisecond: 222,
    ),
    '2000-12-31T00:00:00.222888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-31T23:59:00.000': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 23, minute: 59),
    ),
    '2000-12-31T23:59:00.000888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 23, minute: 59),
      microsecond: 888,
    ),
    '2000-12-31T23:59:22.000': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 23, minute: 59),
      second: 22,
    ),
    '2000-12-31T23:59:22.000888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 23, minute: 59),
      second: 22,
      microsecond: 888,
    ),
    '2000-12-31T23:59:22.222': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 23, minute: 59),
      second: 22,
      millisecond: 222,
    ),
    '2000-12-31T23:59:22.222888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 23, minute: 59),
      second: 22,
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-31T23:59:00.222': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 23, minute: 59),
      millisecond: 222,
    ),
    '2000-12-31T23:59:00.222888': FollyUtils.dateMergeStart(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 23, minute: 59),
      millisecond: 222,
      microsecond: 888,
    ),
  };

  group(
    'dateMergeStart',
    () {
      for (MapEntry<String?, DateTime?> input in domain.entries) {
        test(
          'Testing ${input.key}',
          () => expect(input.key, input.value?.toIso8601String()),
        );
      }
    },
  );
}
