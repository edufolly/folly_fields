import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class DurationValidator extends AbstractValidator<Duration>
    implements AbstractParser<Duration> {
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
        r'(\d+'
        '$yearSuffix)?'
        r'\s*(\d+'
        '$monthSuffix)?'
        r'\s*(\d+'
        '$daySuffix)?'
        r'\s*(\d+'
        '$hourSuffix)?'
        r'\s*(\d+'
        '$minuteSuffix)?'
        r'\s*(\d+'
        '$secondSuffix)?'
        r'\s*(\d+'
        '$millisecondSuffix)?',
      );

  ///
  ///
  ///
  @override
  bool isValid(String value) {
    RegExpMatch? match = regExp.firstMatch(value.trim());
    return match != null && match.group(0) == value.trim();
  }

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

    String input = value.split(' ').join();
    RegExp onlyNumbers = RegExp(r'\d+');

    RegExp yearRegex = RegExp(r'(\d)+' '$yearSuffix');
    RegExp monthRegex = RegExp(r'(\d)+' '$monthSuffix');
    RegExp dayRegex = RegExp(r'(\d)+' '$daySuffix');
    RegExp hourRegex = RegExp(r'(\d)+' '$hourSuffix');
    RegExp minuteRegex = RegExp(r'(\d)+' '$minuteSuffix');
    RegExp secondRegex = RegExp(r'(\d)+' '$secondSuffix');
    RegExp millisecondRegex = RegExp(r'(\d)+' '$millisecondSuffix');

    String? yearsString = yearRegex.firstMatch(input)?.group(0) ?? '';
    String? monthsString = monthRegex.firstMatch(input)?.group(0) ?? '';
    String? daysString = dayRegex.firstMatch(input)?.group(0) ?? '';
    String? hoursString = hourRegex.firstMatch(input)?.group(0) ?? '';
    String? minutesString = minuteRegex.firstMatch(input)?.group(0) ?? '';
    String? secondsString = secondRegex.firstMatch(input)?.group(0) ?? '';
    String? millisecondsString =
        millisecondRegex.firstMatch(input)?.group(0) ?? '';

    int? years =
        int.tryParse(onlyNumbers.firstMatch(yearsString)?.group(0) ?? '');
    int? months =
        int.tryParse(onlyNumbers.firstMatch(monthsString)?.group(0) ?? '');
    int? days =
        int.tryParse(onlyNumbers.firstMatch(daysString)?.group(0) ?? '');
    int? hours =
        int.tryParse(onlyNumbers.firstMatch(hoursString)?.group(0) ?? '');
    int? minutes =
        int.tryParse(onlyNumbers.firstMatch(minutesString)?.group(0) ?? '');
    int? seconds =
        int.tryParse(onlyNumbers.firstMatch(secondsString)?.group(0) ?? '');
    int? milliseconds = int.tryParse(
      onlyNumbers.firstMatch(millisecondsString)?.group(0) ?? '',
    );

    days = (days ?? 0) + 30 * (months ?? 0) + 365 * (years ?? 0);

    return Duration(
      days: days,
      hours: hours ?? 0,
      minutes: minutes ?? 0,
      seconds: seconds ?? 0,
      milliseconds: milliseconds ?? 0,
    );
  }

  ///
  ///
  ///
  @override
  String? valid(String value) => null;
}
