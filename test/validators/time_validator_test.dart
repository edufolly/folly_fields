import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/validators/time_validator.dart';

///
///
///
void main() {
  group(
    'TimeValidator isValid',
    () {
      final Map<String, bool> isValidTests = <String, bool>{
        '': false,
        'A': false,
        'AA': false,
        'A:A': false,
        'AAA': false,
        'AA:A': false,
        'AA:AA': false,
        'AAA:AA': false,
        'AA:AAA': false,
        'AA:AA:A': false,
        'AA:AA:AA': false,
        '1,00': false,
        '01,00': false,
        '0': false,
        '00': false,
        '0:0': false,
        '000': false,
        '00:0': false,
        '00:00': true,
        '000:00': false,
        '00:000': false,
        '00:00:0': false,
        '00:00:00': false,
        '1': false,
        '11': false,
        '1:1': false,
        '111': false,
        '11:1': false,
        '11:11': true,
        '111:11': false,
        '11:111': false,
        '11:11:1': false,
        '11:11:11': false,
        '00:01': true,
        '00:59': true,
        '0:01': false,
        '0:59': false,
        '00:60': false,
        '00:61': false,
        '0:60': false,
        '0:61': false,
        '01:00': true,
        '01:01': true,
        '1:00': false,
        '1:01': false,
        '01:59': true,
        '01:60': false,
        '01:61': false,
        '23:00': true,
        '23:59': true,
        '23:60': false,
        '23:61': false,
        '24:00': false,
        '24:01': false,
        '24:59': false,
        '24:60': false,
        '24:61': false,
      };

      final TimeValidator validator = TimeValidator();

      for (final MapEntry<String, bool> input in isValidTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.isValid(input.key), input.value),
        );
      }
    },
  );

  group(
    'TimeValidator parse',
    () {
      final Map<String, TimeOfDay?> parseTests = <String, TimeOfDay?>{
        '': null,
        'A': null,
        'AA': null,
        'A:A': null,
        'AAA': null,
        'AA:A': null,
        'AA:AA': null,
        'AAA:AA': null,
        'AA:AAA': null,
        'AA:AA:A': null,
        'AA:AA:AA': null,
        '1,00': null,
        '01,00': null,
        '0': null,
        '00': null,
        '0:0': null,
        '000': null,
        '00:0': null,
        '00:00': const TimeOfDay(hour: 0, minute: 0),
        '000:00': null,
        '00:000': null,
        '00:00:0': null,
        '00:00:00': null,
        '1': null,
        '11': null,
        '1:1': null,
        '111': null,
        '11:1': null,
        '11:11': const TimeOfDay(hour: 11, minute: 11),
        '111:11': null,
        '11:111': null,
        '11:11:1': null,
        '11:11:11': null,
        '00:01': const TimeOfDay(hour: 0, minute: 1),
        '00:59': const TimeOfDay(hour: 0, minute: 59),
        '0:01': null,
        '0:59': null,
        '00:60': null,
        '00:61': null,
        '0:60': null,
        '0:61': null,
        '01:00': const TimeOfDay(hour: 1, minute: 0),
        '01:01': const TimeOfDay(hour: 1, minute: 1),
        '1:00': null,
        '1:01': null,
        '01:59': const TimeOfDay(hour: 1, minute: 59),
        '01:60': null,
        '01:61': null,
        '23:00': const TimeOfDay(hour: 23, minute: 0),
        '23:59': const TimeOfDay(hour: 23, minute: 59),
        '23:60': null,
        '23:61': null,
        '24:00': null,
        '24:01': null,
        '24:59': null,
        '24:60': null,
        '24:61': null,
      };

      final TimeValidator validator = TimeValidator();

      for (final MapEntry<String, TimeOfDay?> input in parseTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.parse(input.key), input.value),
        );
      }
    },
  );

  group(
    'TimeValidator format',
    () {
      final Map<TimeOfDay, String> formatTests = <TimeOfDay, String>{
        const TimeOfDay(hour: 0, minute: 0): '00:00',
        const TimeOfDay(hour: 0, minute: 1): '00:01',
        const TimeOfDay(hour: 0, minute: 9): '00:09',
        const TimeOfDay(hour: 0, minute: 10): '00:10',
        const TimeOfDay(hour: 0, minute: 59): '00:59',
        const TimeOfDay(hour: 1, minute: 0): '01:00',
        const TimeOfDay(hour: 1, minute: 1): '01:01',
        const TimeOfDay(hour: 1, minute: 9): '01:09',
        const TimeOfDay(hour: 1, minute: 10): '01:10',
        const TimeOfDay(hour: 1, minute: 59): '01:59',
        const TimeOfDay(hour: 10, minute: 0): '10:00',
        const TimeOfDay(hour: 10, minute: 1): '10:01',
        const TimeOfDay(hour: 10, minute: 9): '10:09',
        const TimeOfDay(hour: 10, minute: 10): '10:10',
        const TimeOfDay(hour: 10, minute: 59): '10:59',
        const TimeOfDay(hour: 23, minute: 0): '23:00',
        const TimeOfDay(hour: 23, minute: 1): '23:01',
        const TimeOfDay(hour: 23, minute: 9): '23:09',
        const TimeOfDay(hour: 23, minute: 10): '23:10',
        const TimeOfDay(hour: 23, minute: 59): '23:59',
      };

      final TimeValidator validator = TimeValidator();

      for (final MapEntry<TimeOfDay, String> input in formatTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.format(input.key), input.value),
        );
      }
    },
  );

  group(
    'TimeValidator formatDateTime',
    () {
      final Map<DateTime, String> formatTests = <DateTime, String>{
        DateTime(2000): '00:00',
        DateTime(2000, 1, 1, 0, 1): '00:01',
        DateTime(2000, 1, 1, 0, 9): '00:09',
        DateTime(2000, 1, 1, 0, 10): '00:10',
        DateTime(2000, 1, 1, 0, 59): '00:59',
        DateTime(2000, 1, 1, 1): '01:00',
        DateTime(2000, 1, 1, 1, 1): '01:01',
        DateTime(2000, 1, 1, 1, 9): '01:09',
        DateTime(2000, 1, 1, 1, 10): '01:10',
        DateTime(2000, 1, 1, 1, 59): '01:59',
        DateTime(2000, 1, 1, 10): '10:00',
        DateTime(2000, 1, 1, 10, 1): '10:01',
        DateTime(2000, 1, 1, 10, 9): '10:09',
        DateTime(2000, 1, 1, 10, 10): '10:10',
        DateTime(2000, 1, 1, 10, 59): '10:59',
        DateTime(2000, 1, 1, 23): '23:00',
        DateTime(2000, 1, 1, 23, 1): '23:01',
        DateTime(2000, 1, 1, 23, 9): '23:09',
        DateTime(2000, 1, 1, 23, 10): '23:10',
        DateTime(2000, 1, 1, 23, 59): '23:59',
      };

      final TimeValidator validator = TimeValidator();

      for (final MapEntry<DateTime, String> input in formatTests.entries) {
        test(
          'Testing: ${input.key}',
          () => expect(validator.formatDateTime(input.key), input.value),
        );
      }
    },
  );

  group('TimeValidator Coverage', () {
    final TimeValidator validator = TimeValidator();

    test('strip', () => expect(validator.strip('00:00'), '00:00'));

    test('keyboard', () => expect(validator.keyboard, isNotNull));
  });
}
