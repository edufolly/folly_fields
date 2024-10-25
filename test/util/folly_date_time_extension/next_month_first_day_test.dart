import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/folly_date_time_extension.dart';

///
///
///
void main() {
  group(
    'DateTimeExtension nextFirstMonthDay',
    () {
      Set<(DateTime, DateTime)> domain = <(DateTime, DateTime)>{
        (DateTime(1900, 2), DateTime(1900, 3)),
        (DateTime(1900, 2, 2), DateTime(1900, 3)),
        (DateTime(1900, 2, 27), DateTime(1900, 3)),
        (DateTime(1900, 2, 28), DateTime(1900, 3)),
        (DateTime(2019, 12), DateTime(2020)),
        (DateTime(2019, 12, 2), DateTime(2020)),
        (DateTime(2019, 12, 30), DateTime(2020)),
        (DateTime(2019, 12, 31), DateTime(2020)),
        (DateTime(2020), DateTime(2020, 2)),
        (DateTime(2020, 1, 2), DateTime(2020, 2)),
        (DateTime(2020, 1, 30), DateTime(2020, 2)),
        (DateTime(2020, 1, 31), DateTime(2020, 2)),
        (DateTime(2020, 2), DateTime(2020, 3)),
        (DateTime(2020, 2, 2), DateTime(2020, 3)),
        (DateTime(2020, 2, 28), DateTime(2020, 3)),
        (DateTime(2020, 2, 29), DateTime(2020, 3)),
        (DateTime(2020, 3), DateTime(2020, 4)),
        (DateTime(2020, 3, 2), DateTime(2020, 4)),
        (DateTime(2020, 3, 30), DateTime(2020, 4)),
        (DateTime(2020, 3, 31), DateTime(2020, 4)),
        (DateTime(2020, 4), DateTime(2020, 5)),
        (DateTime(2020, 4, 2), DateTime(2020, 5)),
        (DateTime(2020, 4, 29), DateTime(2020, 5)),
        (DateTime(2020, 4, 30), DateTime(2020, 5)),
        (DateTime(2020, 5), DateTime(2020, 6)),
        (DateTime(2020, 5, 2), DateTime(2020, 6)),
        (DateTime(2020, 5, 30), DateTime(2020, 6)),
        (DateTime(2020, 5, 31), DateTime(2020, 6)),
        (DateTime(2020, 6), DateTime(2020, 7)),
        (DateTime(2020, 6, 2), DateTime(2020, 7)),
        (DateTime(2020, 6, 29), DateTime(2020, 7)),
        (DateTime(2020, 6, 30), DateTime(2020, 7)),
        (DateTime(2020, 7), DateTime(2020, 8)),
        (DateTime(2020, 7, 2), DateTime(2020, 8)),
        (DateTime(2020, 7, 30), DateTime(2020, 8)),
        (DateTime(2020, 7, 31), DateTime(2020, 8)),
        (DateTime(2020, 8), DateTime(2020, 9)),
        (DateTime(2020, 8, 2), DateTime(2020, 9)),
        (DateTime(2020, 8, 30), DateTime(2020, 9)),
        (DateTime(2020, 8, 31), DateTime(2020, 9)),
        (DateTime(2020, 9), DateTime(2020, 10)),
        (DateTime(2020, 9, 2), DateTime(2020, 10)),
        (DateTime(2020, 9, 29), DateTime(2020, 10)),
        (DateTime(2020, 9, 30), DateTime(2020, 10)),
        (DateTime(2020, 10), DateTime(2020, 11)),
        (DateTime(2020, 10, 2), DateTime(2020, 11)),
        (DateTime(2020, 10, 30), DateTime(2020, 11)),
        (DateTime(2020, 10, 31), DateTime(2020, 11)),
        (DateTime(2020, 11), DateTime(2020, 12)),
        (DateTime(2020, 11, 2), DateTime(2020, 12)),
        (DateTime(2020, 11, 29), DateTime(2020, 12)),
        (DateTime(2020, 11, 30), DateTime(2020, 12)),
        (DateTime(2020, 12), DateTime(2021)),
        (DateTime(2020, 12, 2), DateTime(2021)),
        (DateTime(2020, 12, 30), DateTime(2021)),
        (DateTime(2020, 12, 31), DateTime(2021)),
        (DateTime(2021, 2), DateTime(2021, 3)),
        (DateTime(2021, 2, 2), DateTime(2021, 3)),
        (DateTime(2021, 2, 27), DateTime(2021, 3)),
        (DateTime(2021, 2, 28), DateTime(2021, 3)),
        (DateTime(2024, 2), DateTime(2024, 3)),
        (DateTime(2024, 2, 2), DateTime(2024, 3)),
        (DateTime(2024, 2, 28), DateTime(2024, 3)),
        (DateTime(2024, 2, 29), DateTime(2024, 3)),
        (DateTime(2100, 2), DateTime(2100, 3)),
        (DateTime(2100, 2, 2), DateTime(2100, 3)),
        (DateTime(2100, 2, 27), DateTime(2100, 3)),
        (DateTime(2100, 2, 28), DateTime(2100, 3)),
      };

      for (final (DateTime key, DateTime value) in domain) {
        test(
          'Testing ${key.toIso8601String()}',
          () => expect(key.nextMonthFirstDay, value),
        );
      }
    },
  );
}
