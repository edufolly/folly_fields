import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/date_time_extension.dart';

///
///
///
void main() {
  Map<DateTime, TimeOfDay> domain = <DateTime, TimeOfDay>{
    DateTime(2000): const TimeOfDay(hour: 0, minute: 0),
    DateTime(2000, 1, 1, 0, 0, 59): const TimeOfDay(hour: 0, minute: 0),
    DateTime(2000, 1, 1, 0, 0, 60): const TimeOfDay(hour: 0, minute: 1),
    DateTime(2000, 1, 1, 0, 1): const TimeOfDay(hour: 0, minute: 1),
    DateTime(2000, 1, 1, 0, 1, 1): const TimeOfDay(hour: 0, minute: 1),
    DateTime(2000, 1, 1, 0, 1, 59): const TimeOfDay(hour: 0, minute: 1),
    DateTime(2000, 1, 1, 0, 1, 60): const TimeOfDay(hour: 0, minute: 2),
    DateTime(2000, 1, 1, 23): const TimeOfDay(hour: 23, minute: 0),
    DateTime(2000, 1, 1, 23, 0, 1): const TimeOfDay(hour: 23, minute: 0),
    DateTime(2000, 1, 1, 23, 0, 59): const TimeOfDay(hour: 23, minute: 0),
    DateTime(2000, 1, 1, 23, 0, 60): const TimeOfDay(hour: 23, minute: 1),
    DateTime(2000, 1, 1, 23, 1): const TimeOfDay(hour: 23, minute: 1),
    DateTime(2000, 1, 1, 23, 59): const TimeOfDay(hour: 23, minute: 59),
    DateTime(2000, 1, 1, 23, 59, 1): const TimeOfDay(hour: 23, minute: 59),
    DateTime(2000, 1, 1, 23, 59, 59): const TimeOfDay(hour: 23, minute: 59),
    DateTime(2000, 1, 1, 23, 59, 60): const TimeOfDay(hour: 0, minute: 0),
    DateTime(2000, 1, 1, 23, 60): const TimeOfDay(hour: 0, minute: 0),
    DateTime(2000, 1, 1, 24): const TimeOfDay(hour: 0, minute: 0),
    DateTime(2000, 1, 1, 24, 0, 59): const TimeOfDay(hour: 0, minute: 0),
    DateTime(2000, 1, 1, 24, 0, 60): const TimeOfDay(hour: 0, minute: 1),
    DateTime(2000, 1, 1, 24, 1): const TimeOfDay(hour: 0, minute: 1),
  };

  group(
    'time',
    () {
      for (final MapEntry<DateTime, TimeOfDay> input in domain.entries) {
        test(
          'Testing ${input.key.toIso8601String()}',
          () => expect(input.key.time, input.value),
        );
      }
    },
  );
}
