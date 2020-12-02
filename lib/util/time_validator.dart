import 'package:flutter/material.dart';
import 'package:folly_fields/util/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';

///
///
///
class TimeValidator extends AbstractValidator<TimeOfDay>
    implements AbstractTimeParser<TimeOfDay> {
  ///
  ///
  ///
  @override
  String format(TimeOfDay time) =>
      time.hour.toString().padLeft(2, '0') +
      ':' +
      time.minute.toString().padLeft(2, '0');

  ///
  ///
  ///
  @override
  String strip(String value) => value;

  ///
  ///
  ///
  @override
  bool isValid(String value, {bool stripBeforeValidation = true}) =>
      valid(value) == null;

  ///
  ///
  ///
  @override
  MaskTextInputFormatter get mask => MaskTextInputFormatter(
        mask: 'AB:CB',
        filter: <String, RegExp>{
          'A': RegExp(r'[0-2]'),
          'B': RegExp(r'[0-9]'),
          'C': RegExp(r'[0-5]'),
        },
      );

  ///
  ///
  ///
  @override
  TimeOfDay parse(String value) {
    if (isValid(value)) {
      List<String> parts = value.split(':');
      return TimeOfDay(
        hour: int.tryParse(parts[0]),
        minute: int.tryParse(parts[1]),
      );
    }
    return null;
  }

  ///
  ///
  ///
  @override
  String valid(String value) {
    if (value.isEmpty) return 'Hora vazia';

    List<String> parts = value.split(':');

    if (parts.length != 2) return 'Hora inválida';

    int hour = int.tryParse(parts[0]);

    if (hour == null || hour < 0 || hour > 23) {
      return 'Horas inválidas';
    }

    int minute = int.tryParse(parts[1]);

    if (minute == null || minute < 0 || minute > 59) {
      return 'Minutos inválidos';
    }

    return null;
  }

  ///
  ///
  ///
  String formatDateTime(DateTime dateTime) {
    return format(TimeOfDay.fromDateTime(dateTime));
  }
}
