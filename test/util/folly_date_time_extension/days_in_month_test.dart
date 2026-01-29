import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/extensions/folly_date_time_extension.dart';

///
///
///
void main() {
  group(
    'DateTimeExtension daysInMonth',
    () {
      Set<(DateTime, int)> domain = <(DateTime, int)>{
        (DateTime(1900, 2), 28),
        (DateTime(1996, 2), 29),
        (DateTime(1997, 2), 28),
        (DateTime(1998, 2), 28),
        (DateTime(1999, 2), 28),
        (DateTime(2000), 31),
        (DateTime(2000, 2), 29),
        (DateTime(2000, 3), 31),
        (DateTime(2000, 4), 30),
        (DateTime(2000, 5), 31),
        (DateTime(2000, 6), 30),
        (DateTime(2000, 7), 31),
        (DateTime(2000, 8), 31),
        (DateTime(2000, 9), 30),
        (DateTime(2000, 10), 31),
        (DateTime(2000, 11), 30),
        (DateTime(2000, 12), 31),
        (DateTime(2001, 2), 28),
        (DateTime(2002, 2), 28),
        (DateTime(2003, 2), 28),
        (DateTime(2004, 2), 29),
        (DateTime(2020, 2), 29),
        (DateTime(2100, 2), 28),
      };

      for (final (DateTime key, int value) in domain) {
        test(
          'Testing ${key.toIso8601String()}',
          () => expect(key.daysInMonth, value),
        );
      }
    },
  );
}
