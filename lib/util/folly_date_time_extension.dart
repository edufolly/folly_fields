import 'package:flutter/material.dart';

///
///
///
extension FollyDateTimeExtension on DateTime {
  static const Duration oneDay = Duration(days: 1);
  static const Duration week = Duration(days: 7);

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

  ///
  ///
  ///
  DateTime get monthFirstDay => copyWith(day: 1).mergeStart();

  ///
  ///
  ///
  DateTime get monthLastDay => copyWith(day: daysInMonth).mergeEnd();

  ///
  ///
  ///
  DateTime get prevMonthLastDay => monthFirstDay.subtract(oneDay).mergeEnd();

  ///
  ///
  ///
  DateTime get prevMonthFirstDay => prevMonthLastDay.monthFirstDay;

  ///
  ///
  ///
  DateTime get nextMonthFirstDay => monthLastDay.add(oneDay).mergeStart();

  ///
  ///
  ///
  DateTime get nextMonthLastDay => nextMonthFirstDay.monthLastDay;

  ///
  ///
  ///
  DateTime weekFirstDay([int firstDay = DateTime.sunday]) => subtract(
        Duration(
          days: weekday - firstDay + (weekday - firstDay < 0 ? 7 : 0),
        ),
      ).mergeStart();

  ///
  ///
  ///
  DateTime weekLastDay([int lastDay = DateTime.saturday]) => add(
        Duration(
          days: lastDay - weekday + (lastDay - weekday < 0 ? 7 : 0),
        ),
      ).mergeStart();

  ///
  ///
  ///
  DateTime prevWeekFirstDay([int firstDay = DateTime.sunday]) =>
      weekFirstDay(firstDay).subtract(week);

  ///
  ///
  ///
  DateTime prevWeekLastDay([int lastDay = DateTime.saturday]) =>
      weekLastDay(lastDay).subtract(week);

  ///
  ///
  ///
  DateTime nextWeekFirstDay([int firstDay = DateTime.sunday]) =>
      weekFirstDay(firstDay).add(week);

  ///
  ///
  ///
  DateTime nextWeekLastDay([int lastDay = DateTime.saturday]) =>
      weekLastDay(lastDay).add(week);
}
