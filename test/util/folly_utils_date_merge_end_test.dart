import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_utils.dart';

///
///
///
void main() {
  ///
  /// dateMergeEnd
  ///
  Map<String?, DateTime?> domain = <String?, DateTime?>{
    null: FollyUtils.dateMergeEnd(date: null),
    '2000-01-01T23:59:59.999': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
    ),
    '2000-01-01T23:59:59.999888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      microsecond: 888,
    ),
    '2000-01-01T23:59:22.999': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      second: 22,
    ),
    '2000-01-01T23:59:22.999888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      second: 22,
      microsecond: 888,
    ),
    '2000-01-01T23:59:22.222': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
    ),
    '2000-01-01T23:59:22.222888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-01-01T23:59:59.222': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      millisecond: 222,
    ),
    '2000-01-01T23:59:59.222888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 1, 1, 11, 11, 11, 111, 111),
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-01T23:59:59.999': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
    ),
    '2000-12-01T23:59:59.999888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      microsecond: 888,
    ),
    '2000-12-01T23:59:22.999': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      second: 22,
    ),
    '2000-12-01T23:59:22.999888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      second: 22,
      microsecond: 888,
    ),
    '2000-12-01T23:59:22.222': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
    ),
    '2000-12-01T23:59:22.222888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-01T23:59:59.222': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      millisecond: 222,
    ),
    '2000-12-01T23:59:59.222888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 1, 11, 11, 11, 111, 111),
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-31T23:59:59.999': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
    ),
    '2000-12-31T23:59:59.999888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      microsecond: 888,
    ),
    '2000-12-31T23:59:22.999': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      second: 22,
    ),
    '2000-12-31T23:59:22.999888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      second: 22,
      microsecond: 888,
    ),
    '2000-12-31T23:59:22.222': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
    ),
    '2000-12-31T23:59:22.222888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      second: 22,
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-31T23:59:59.222': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      millisecond: 222,
    ),
    '2000-12-31T23:59:59.222888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-31T22:22:59.999': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 22, minute: 22),
    ),
    '2000-12-31T22:22:59.999888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 22, minute: 22),
      microsecond: 888,
    ),
    '2000-12-31T22:22:22.999': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 22, minute: 22),
      second: 22,
    ),
    '2000-12-31T22:22:22.999888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 22, minute: 22),
      second: 22,
      microsecond: 888,
    ),
    '2000-12-31T22:22:22.222': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 22, minute: 22),
      second: 22,
      millisecond: 222,
    ),
    '2000-12-31T22:22:22.222888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 22, minute: 22),
      second: 22,
      millisecond: 222,
      microsecond: 888,
    ),
    '2000-12-31T22:22:59.222': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 22, minute: 22),
      millisecond: 222,
    ),
    '2000-12-31T22:22:59.222888': FollyUtils.dateMergeEnd(
      date: DateTime(2000, 12, 31, 11, 11, 11, 111, 111),
      time: const TimeOfDay(hour: 22, minute: 22),
      millisecond: 222,
      microsecond: 888,
    ),
  };

  group(
    'dateMergeEnd',
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
