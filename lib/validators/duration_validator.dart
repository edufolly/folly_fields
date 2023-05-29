import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class DurationValidator extends AbstractParserValidator<Duration> {
  final String yearSuffix;
  final String monthSuffix;
  final String daySuffix;
  final String hourSuffix;
  final String minuteSuffix;
  final String secondSuffix;
  final String millisecondSuffix;

  ///
  ///
  ///
  DurationValidator({
    this.yearSuffix = 'y',
    this.monthSuffix = 'M',
    this.daySuffix = 'd',
    this.hourSuffix = 'h',
    this.minuteSuffix = 'm',
    this.secondSuffix = 's',
    this.millisecondSuffix = 'ms',
  })  : assert(yearSuffix.isNotEmpty, "yearSuffix can't be empty."),
        assert(monthSuffix.isNotEmpty, "monthSuffix can't be empty."),
        assert(daySuffix.isNotEmpty, "daySuffix can't be empty."),
        assert(hourSuffix.isNotEmpty, "hourSuffix can't be empty."),
        assert(minuteSuffix.isNotEmpty, "minuteSuffix can't be empty."),
        assert(secondSuffix.isNotEmpty, "secondsSuffix can't be empty."),
        assert(
          millisecondSuffix.isNotEmpty,
          "millisecondSuffix can't be empty.",
        );

  ///
  ///
  ///
  @override
  String format(Duration duration) {
    int milliseconds = duration.inMilliseconds;
    int seconds = 0;
    int minutes = 0;
    int hours = 0;
    int days = 0;
    int months = 0;
    int years = 0;

    String ret = '';

    if (milliseconds == 0) {
      return '0$millisecondSuffix';
    } else if (milliseconds >= 1000) {
      seconds = (milliseconds / 1000).floor();
      milliseconds = milliseconds % 1000;
    }

    if (seconds >= 60) {
      minutes = (seconds / 60).floor();
      seconds = seconds % 60;
    }

    if (minutes >= 60) {
      hours = (minutes / 60).floor();
      minutes = minutes % 60;
    }

    if (hours >= 24) {
      days = (hours / 24).floor();
      hours = hours % 24;
    }

    if (days >= 30) {
      months = (days / 30).floor();
      days = days % 30;
    }

    if (months >= 12) {
      years = (months / 12).floor();
      months = months % 12;
    }

    if (milliseconds != 0) {
      ret = '$milliseconds$millisecondSuffix';
    }

    if (seconds != 0) {
      ret = '$seconds$secondSuffix${ret.isEmpty ? '' : ' $ret'}';
    }

    if (minutes != 0) {
      ret = '$minutes$minuteSuffix${ret.isEmpty ? '' : ' $ret'}';
    }

    if (hours != 0) {
      ret = '$hours$hourSuffix${ret.isEmpty ? '' : ' $ret'}';
    }

    if (days != 0) {
      ret = '$days$daySuffix${ret.isEmpty ? '' : ' $ret'}';
    }

    if (months != 0) {
      ret = '$months$monthSuffix${ret.isEmpty ? '' : ' $ret'}';
    }

    if (years != 0) {
      ret = '$years$yearSuffix${ret.isEmpty ? '' : ' $ret'}';
    }

    return ret;
  }

  ///
  ///
  ///
  @override
  String strip(String value) => value;

  ///
  ///
  ///
  RegExp get regExp => RegExp(
        '(\\d+$yearSuffix)?\\s*'
        '(\\d+$monthSuffix)?\\s*'
        '(\\d+$daySuffix)?\\s*'
        '(\\d+$hourSuffix)?\\s*'
        '(\\d+$minuteSuffix)?\\s*'
        '(\\d+$secondSuffix)?\\s*'
        '(\\d+$millisecondSuffix)?',
      );

  ///
  ///
  ///
  @override
  bool isValid(String value) =>
      regExp.firstMatch(value.trim())?.group(0) == value.trim();

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.text;

  ///
  ///
  ///
  @override
  Duration? parse(String? value) {
    if (value == null || !isValid(value)) {
      return Duration.zero;
    }

    final String input = value.split(' ').join();
    final RegExp onlyNumbers = RegExp(r'\d+');

    final RegExp yearRegex = RegExp('(\\d)+$yearSuffix');
    final RegExp monthRegex = RegExp('(\\d)+$monthSuffix');
    final RegExp dayRegex = RegExp('(\\d)+$daySuffix');
    final RegExp hourRegex = RegExp('(\\d)+$hourSuffix');
    final RegExp minuteRegex = RegExp('(\\d)+$minuteSuffix');
    final RegExp secondRegex = RegExp('(\\d)+$secondSuffix');
    final RegExp millisecondRegex = RegExp('(\\d)+$millisecondSuffix');

    final String yearsString = yearRegex.firstMatch(input)?.group(0) ?? '';
    final String monthsString = monthRegex.firstMatch(input)?.group(0) ?? '';
    final String daysString = dayRegex.firstMatch(input)?.group(0) ?? '';
    final String hoursString = hourRegex.firstMatch(input)?.group(0) ?? '';
    final String minutesString = minuteRegex.firstMatch(input)?.group(0) ?? '';
    final String secondsString = secondRegex.firstMatch(input)?.group(0) ?? '';
    final String millisecondsString =
        millisecondRegex.firstMatch(input)?.group(0) ?? '';

    final int years =
        int.tryParse(onlyNumbers.firstMatch(yearsString)?.group(0) ?? '') ?? 0;
    final int months =
        int.tryParse(onlyNumbers.firstMatch(monthsString)?.group(0) ?? '') ?? 0;
    final int days =
        int.tryParse(onlyNumbers.firstMatch(daysString)?.group(0) ?? '') ?? 0;
    final int hours =
        int.tryParse(onlyNumbers.firstMatch(hoursString)?.group(0) ?? '') ?? 0;
    final int minutes =
        int.tryParse(onlyNumbers.firstMatch(minutesString)?.group(0) ?? '') ??
            0;
    final int seconds =
        int.tryParse(onlyNumbers.firstMatch(secondsString)?.group(0) ?? '') ??
            0;
    final int milliseconds = int.tryParse(
          onlyNumbers.firstMatch(millisecondsString)?.group(0) ?? '',
        ) ??
        0;

    return Duration(
      days: days + 30 * months + 365 * years,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    );
  }

  ///
  ///
  ///
  @override
  String? valid(String value) => null;
}
