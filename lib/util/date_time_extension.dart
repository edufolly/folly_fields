import 'package:flutter/material.dart';

///
///
///
extension DateTimeExtension on DateTime {
  ///
  ///
  ///
  TimeOfDay get time => TimeOfDay.fromDateTime(this);

  ///
  ///
  ///
  DateTime mergeStartSeconds({
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  }) =>
      copyWith(
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      );

  ///
  ///
  ///
  DateTime mergeStart({
    TimeOfDay time = const TimeOfDay(hour: 0, minute: 0),
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  }) =>
      copyWith(
        hour: time.hour,
        minute: time.minute,
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      );

  ///
  ///
  ///
  DateTime mergeEndSeconds({
    int second = 59,
    int millisecond = 999,
    int microsecond = 0,
  }) =>
      copyWith(
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      );


  ///
  ///
  ///
  DateTime mergeEnd({
    TimeOfDay time = const TimeOfDay(hour: 23, minute: 59),
    int second = 59,
    int millisecond = 999,
    int microsecond = 0,
  }) =>
      copyWith(
        hour: time.hour,
        minute: time.minute,
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      );

  ///
  ///
  ///
  int get daysInMonth {
    if (month == DateTime.february) {
      return (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
          ? 29
          : 28;
    }
    List<int> days = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    return days[month - 1];
  }
}
