import 'package:flutter/material.dart' show TimeOfDay;

extension DateTimeExtension on DateTime {
  static const Duration oneDay = Duration(days: 1);
  static const Duration week = Duration(days: 7);

  TimeOfDay get time => TimeOfDay.fromDateTime(this);

  DateTime mergeStartSeconds({
    final int second = 0,
    final int millisecond = 0,
    final int microsecond = 0,
  }) => copyWith(
    second: second,
    millisecond: millisecond,
    microsecond: microsecond,
  );

  DateTime mergeStart({
    final TimeOfDay? time = const TimeOfDay(hour: 0, minute: 0),
    final int second = 0,
    final int millisecond = 0,
    final int microsecond = 0,
  }) => copyWith(
    hour: time?.hour ?? 0,
    minute: time?.minute ?? 0,
    second: second,
    millisecond: millisecond,
    microsecond: microsecond,
  );

  DateTime get startOfDay => mergeStart();

  DateTime mergeEndSeconds({
    final int second = 59,
    final int millisecond = 999,
    final int microsecond = 0,
  }) => copyWith(
    second: second,
    millisecond: millisecond,
    microsecond: microsecond,
  );

  DateTime mergeEnd({
    final TimeOfDay? time = const TimeOfDay(hour: 23, minute: 59),
    final int second = 59,
    final int millisecond = 999,
    final int microsecond = 0,
  }) => copyWith(
    hour: time?.hour ?? 0,
    minute: time?.minute ?? 0,
    second: second,
    millisecond: millisecond,
    microsecond: microsecond,
  );

  DateTime get endOfDay => mergeEnd();

  int get daysInMonth => (month == DateTime.february)
      ? (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
            ? 29
            : 28
      : <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month - 1];

  DateTime get monthFirstDay => copyWith(day: 1).startOfDay;

  DateTime get monthLastDay => copyWith(day: daysInMonth).endOfDay;

  DateTime get prevMonthFirstDay => prevMonthLastDay.monthFirstDay;

  DateTime get prevMonthLastDay => monthFirstDay.subtract(oneDay).endOfDay;

  DateTime get nextMonthFirstDay => monthLastDay.add(oneDay).startOfDay;

  DateTime get nextMonthLastDay => nextMonthFirstDay.monthLastDay;

  DateTime weekFirstDay([final int firstDay = DateTime.sunday]) => subtract(
    Duration(days: weekday - firstDay + (weekday - firstDay < 0 ? 7 : 0)),
  ).mergeStart();

  DateTime weekLastDay([final int lastDay = DateTime.saturday]) => add(
    Duration(days: lastDay - weekday + (lastDay - weekday < 0 ? 7 : 0)),
  ).mergeStart();

  DateTime prevWeekFirstDay([final int firstDay = DateTime.sunday]) =>
      weekFirstDay(firstDay).subtract(week);

  DateTime prevWeekLastDay([final int lastDay = DateTime.saturday]) =>
      weekLastDay(lastDay).subtract(week);

  DateTime nextWeekFirstDay([final int firstDay = DateTime.sunday]) =>
      weekFirstDay(firstDay).add(week);

  DateTime nextWeekLastDay([final int lastDay = DateTime.saturday]) =>
      weekLastDay(lastDay).add(week);

  DateTime get yearFirstDay => copyWith(month: 1, day: 1).startOfDay;

  DateTime get yearLastDay => copyWith(month: 12, day: 31).endOfDay;
}
