import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_date_time_extension.dart';

///
///
///
void main() {
  group(
    'DateTimeExtension nextWeekFirstDay - Monday',
    () {
      Set<(DateTime, DateTime)> domain = <(DateTime, DateTime)>{
        (DateTime(2023, 3, 19), DateTime(2023, 3, 20)),
        (DateTime(2023, 3, 20), DateTime(2023, 3, 27)),
        (DateTime(2023, 3, 21), DateTime(2023, 3, 27)),
        (DateTime(2023, 3, 22), DateTime(2023, 3, 27)),
        (DateTime(2023, 3, 23), DateTime(2023, 3, 27)),
        (DateTime(2023, 3, 24), DateTime(2023, 3, 27)),
        (DateTime(2023, 3, 25), DateTime(2023, 3, 27)),
        (DateTime(2023, 3, 26), DateTime(2023, 3, 27)),
        (DateTime(2023, 3, 27), DateTime(2023, 4, 3)),
        (DateTime(2023, 3, 28), DateTime(2023, 4, 3)),
        (DateTime(2023, 3, 29), DateTime(2023, 4, 3)),
        (DateTime(2023, 3, 30), DateTime(2023, 4, 3)),
        (DateTime(2023, 3, 31), DateTime(2023, 4, 3)),
        (DateTime(2023, 4), DateTime(2023, 4, 3)),
        (DateTime(2023, 4, 2), DateTime(2023, 4, 3)),
        (DateTime(2023, 4, 3), DateTime(2023, 4, 10)),
        (DateTime(2023, 4, 4), DateTime(2023, 4, 10)),
        (DateTime(2023, 4, 5), DateTime(2023, 4, 10)),
        (DateTime(2023, 4, 6), DateTime(2023, 4, 10)),
        (DateTime(2023, 4, 7), DateTime(2023, 4, 10)),
        (DateTime(2023, 4, 8), DateTime(2023, 4, 10)),
      };

      for (final (DateTime key, DateTime value) in domain) {
        test(
          'Testing ${key.toIso8601String()}',
          () => expect(key.nextWeekFirstDay(DateTime.monday), value),
        );
      }
    },
  );

  group(
    'DateTimeExtension nextWeekFirstDay - Wednesday',
    () {
      Set<(DateTime, DateTime)> domain = <(DateTime, DateTime)>{
        (DateTime(2023, 3, 19), DateTime(2023, 3, 22)),
        (DateTime(2023, 3, 20), DateTime(2023, 3, 22)),
        (DateTime(2023, 3, 21), DateTime(2023, 3, 22)),
        (DateTime(2023, 3, 22), DateTime(2023, 3, 29)),
        (DateTime(2023, 3, 23), DateTime(2023, 3, 29)),
        (DateTime(2023, 3, 24), DateTime(2023, 3, 29)),
        (DateTime(2023, 3, 25), DateTime(2023, 3, 29)),
        (DateTime(2023, 3, 26), DateTime(2023, 3, 29)),
        (DateTime(2023, 3, 27), DateTime(2023, 3, 29)),
        (DateTime(2023, 3, 28), DateTime(2023, 3, 29)),
        (DateTime(2023, 3, 29), DateTime(2023, 4, 5)),
        (DateTime(2023, 3, 30), DateTime(2023, 4, 5)),
        (DateTime(2023, 3, 31), DateTime(2023, 4, 5)),
        (DateTime(2023, 4), DateTime(2023, 4, 5)),
        (DateTime(2023, 4, 2), DateTime(2023, 4, 5)),
        (DateTime(2023, 4, 3), DateTime(2023, 4, 5)),
        (DateTime(2023, 4, 4), DateTime(2023, 4, 5)),
        (DateTime(2023, 4, 5), DateTime(2023, 4, 12)),
        (DateTime(2023, 4, 6), DateTime(2023, 4, 12)),
        (DateTime(2023, 4, 7), DateTime(2023, 4, 12)),
        (DateTime(2023, 4, 8), DateTime(2023, 4, 12)),
      };

      for (final (DateTime key, DateTime value) in domain) {
        test(
          'Testing ${key.toIso8601String()}',
          () => expect(key.nextWeekFirstDay(DateTime.wednesday), value),
        );
      }
    },
  );

  group(
    'DateTimeExtension nextWeekFirstDay - Sunday',
    () {
      Set<(DateTime, DateTime)> domain = <(DateTime, DateTime)>{
        (DateTime(2023, 3, 19), DateTime(2023, 3, 26)),
        (DateTime(2023, 3, 20), DateTime(2023, 3, 26)),
        (DateTime(2023, 3, 21), DateTime(2023, 3, 26)),
        (DateTime(2023, 3, 22), DateTime(2023, 3, 26)),
        (DateTime(2023, 3, 23), DateTime(2023, 3, 26)),
        (DateTime(2023, 3, 24), DateTime(2023, 3, 26)),
        (DateTime(2023, 3, 25), DateTime(2023, 3, 26)),
        (DateTime(2023, 3, 26), DateTime(2023, 4, 2)),
        (DateTime(2023, 3, 27), DateTime(2023, 4, 2)),
        (DateTime(2023, 3, 28), DateTime(2023, 4, 2)),
        (DateTime(2023, 3, 29), DateTime(2023, 4, 2)),
        (DateTime(2023, 3, 30), DateTime(2023, 4, 2)),
        (DateTime(2023, 3, 31), DateTime(2023, 4, 2)),
        (DateTime(2023, 4), DateTime(2023, 4, 2)),
        (DateTime(2023, 4, 2), DateTime(2023, 4, 9)),
        (DateTime(2023, 4, 3), DateTime(2023, 4, 9)),
        (DateTime(2023, 4, 4), DateTime(2023, 4, 9)),
        (DateTime(2023, 4, 5), DateTime(2023, 4, 9)),
        (DateTime(2023, 4, 6), DateTime(2023, 4, 9)),
        (DateTime(2023, 4, 7), DateTime(2023, 4, 9)),
        (DateTime(2023, 4, 8), DateTime(2023, 4, 9)),
      };

      for (final (DateTime key, DateTime value) in domain) {
        test(
          'Testing ${key.toIso8601String()}',
          () => expect(key.nextWeekFirstDay(), value),
        );
      }
    },
  );
}
