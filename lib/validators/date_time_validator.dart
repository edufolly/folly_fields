import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

///
///
///
class DateTimeValidator extends AbstractValidator<DateTime>
    implements AbstractParser<DateTime> {
  final DateFormat pattern;

  ///
  ///
  ///
  DateTimeValidator({String format})
      : pattern = DateFormat(format ?? 'dd/MM/yyyy HH:mm'),
        super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '##/##/#### A#:C#',
              filter: <String, RegExp>{
                'A': RegExp(r'[0-2]'),
                'C': RegExp(r'[0-5]'),
                '#': RegExp(r'[0-9]'),
              },
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(DateTime value) => value == null ? '' : pattern.format(value);

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
  DateTime parse(String text) => isValid(text) ? pattern.parse(text) : null;

  ///
  ///
  ///
  @override
  String valid(String value) {
    List<String> p = value.split(' ');
    return FollyUtils.validDate(p.first) ?? FollyUtils.validTime(p.last);
  }
}
