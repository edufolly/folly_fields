import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class TimeValidator extends AbstractValidator<TimeOfDay>
    implements AbstractParser<TimeOfDay> {
  ///
  ///
  ///
  TimeValidator()
      : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: 'AB:CB',
              filter: <String, RegExp>{
                'A': RegExp('[0-2]'),
                'B': RegExp('[0-9]'),
                'C': RegExp('[0-5]'),
              },
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(TimeOfDay value) => '${value.hour.toString().padLeft(2, '0')}'
      ':${value.minute.toString().padLeft(2, '0')}';

  ///
  ///
  ///
  @override
  String strip(String value) => value;

  ///
  ///
  ///
  @override
  bool isValid(String value) => valid(value) == null;

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.datetime;

  ///
  ///
  ///
  @override
  TimeOfDay? parse(String? value) {
    if (value != null && isValid(value)) {
      List<String> parts = value.split(':');
      if (parts.length == 2) {
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }
    }
    return null;
  }

  ///
  ///
  ///
  @override
  String? valid(String value) => FollyUtils.validTime(value);

  ///
  ///
  ///
  String formatDateTime(DateTime dateTime) =>
      format(TimeOfDay.fromDateTime(dateTime));
}
