import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_date_time_extension.dart';

///
///
///
void main() {
  group(
    'DateTimeExtension prevWeekLastDay - Saturday',
    () {
      Map<DateTime, DateTime> domain = <DateTime, DateTime>{
        DateTime(2023, 3, 19): DateTime(2023, 3, 18),
        DateTime(2023, 3, 20): DateTime(2023, 3, 18),
        DateTime(2023, 3, 21): DateTime(2023, 3, 18),
        DateTime(2023, 3, 22): DateTime(2023, 3, 18),
        DateTime(2023, 3, 23): DateTime(2023, 3, 18),
        DateTime(2023, 3, 24): DateTime(2023, 3, 18),
        DateTime(2023, 3, 25): DateTime(2023, 3, 18),
        DateTime(2023, 3, 26): DateTime(2023, 3, 25),
        DateTime(2023, 3, 27): DateTime(2023, 3, 25),
        DateTime(2023, 3, 28): DateTime(2023, 3, 25),
        DateTime(2023, 3, 29): DateTime(2023, 3, 25),
        DateTime(2023, 3, 30): DateTime(2023, 3, 25),
        DateTime(2023, 3, 31): DateTime(2023, 3, 25),
        DateTime(2023, 4): DateTime(2023, 3, 25),
        DateTime(2023, 4, 2): DateTime(2023, 4),
        DateTime(2023, 4, 3): DateTime(2023, 4),
        DateTime(2023, 4, 4): DateTime(2023, 4),
        DateTime(2023, 4, 5): DateTime(2023, 4),
        DateTime(2023, 4, 6): DateTime(2023, 4),
        DateTime(2023, 4, 7): DateTime(2023, 4),
        DateTime(2023, 4, 8): DateTime(2023, 4),
      };

      for (MapEntry<DateTime, DateTime> input in domain.entries) {
        test(
          'Testing ${input.key.toIso8601String()}',
          () => expect(input.key.prevWeekLastDay(), input.value),
        );
      }
    },
  );

  group(
    'DateTimeExtension prevWeekLastDay - Sunday',
    () {
      Map<DateTime, DateTime> domain = <DateTime, DateTime>{
        DateTime(2023, 3, 19): DateTime(2023, 3, 12),
        DateTime(2023, 3, 20): DateTime(2023, 3, 19),
        DateTime(2023, 3, 21): DateTime(2023, 3, 19),
        DateTime(2023, 3, 22): DateTime(2023, 3, 19),
        DateTime(2023, 3, 23): DateTime(2023, 3, 19),
        DateTime(2023, 3, 24): DateTime(2023, 3, 19),
        DateTime(2023, 3, 25): DateTime(2023, 3, 19),
        DateTime(2023, 3, 26): DateTime(2023, 3, 19),
        DateTime(2023, 3, 27): DateTime(2023, 3, 26),
        DateTime(2023, 3, 28): DateTime(2023, 3, 26),
        DateTime(2023, 3, 29): DateTime(2023, 3, 26),
        DateTime(2023, 3, 30): DateTime(2023, 3, 26),
        DateTime(2023, 3, 31): DateTime(2023, 3, 26),
        DateTime(2023, 4): DateTime(2023, 3, 26),
        DateTime(2023, 4, 2): DateTime(2023, 3, 26),
        DateTime(2023, 4, 3): DateTime(2023, 4, 2),
        DateTime(2023, 4, 4): DateTime(2023, 4, 2),
        DateTime(2023, 4, 5): DateTime(2023, 4, 2),
        DateTime(2023, 4, 6): DateTime(2023, 4, 2),
        DateTime(2023, 4, 7): DateTime(2023, 4, 2),
        DateTime(2023, 4, 8): DateTime(2023, 4, 2),
      };

      for (MapEntry<DateTime, DateTime> input in domain.entries) {
        test(
          'Testing ${input.key.toIso8601String()}',
          () => expect(input.key.prevWeekLastDay(DateTime.sunday), input.value),
        );
      }
    },
  );

  group(
    'DateTimeExtension prevWeekLastDay - Monday',
    () {
      Map<DateTime, DateTime> domain = <DateTime, DateTime>{
        DateTime(2023, 3, 19): DateTime(2023, 3, 13),
        DateTime(2023, 3, 20): DateTime(2023, 3, 13),
        DateTime(2023, 3, 21): DateTime(2023, 3, 20),
        DateTime(2023, 3, 22): DateTime(2023, 3, 20),
        DateTime(2023, 3, 23): DateTime(2023, 3, 20),
        DateTime(2023, 3, 24): DateTime(2023, 3, 20),
        DateTime(2023, 3, 25): DateTime(2023, 3, 20),
        DateTime(2023, 3, 26): DateTime(2023, 3, 20),
        DateTime(2023, 3, 27): DateTime(2023, 3, 20),
        DateTime(2023, 3, 28): DateTime(2023, 3, 27),
        DateTime(2023, 3, 29): DateTime(2023, 3, 27),
        DateTime(2023, 3, 30): DateTime(2023, 3, 27),
        DateTime(2023, 3, 31): DateTime(2023, 3, 27),
        DateTime(2023, 4): DateTime(2023, 3, 27),
        DateTime(2023, 4, 2): DateTime(2023, 3, 27),
        DateTime(2023, 4, 3): DateTime(2023, 3, 27),
        DateTime(2023, 4, 4): DateTime(2023, 4, 3),
        DateTime(2023, 4, 5): DateTime(2023, 4, 3),
        DateTime(2023, 4, 6): DateTime(2023, 4, 3),
        DateTime(2023, 4, 7): DateTime(2023, 4, 3),
        DateTime(2023, 4, 8): DateTime(2023, 4, 3),
      };

      for (MapEntry<DateTime, DateTime> input in domain.entries) {
        test(
          'Testing ${input.key.toIso8601String()}',
          () => expect(input.key.prevWeekLastDay(DateTime.monday), input.value),
        );
      }
    },
  );
}
