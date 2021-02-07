import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:folly_fields/util/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

///
///
///
class DateValidator extends AbstractValidator<DateTime>
    implements AbstractParser<DateTime> {
  final dynamic locale;

  ///
  ///
  ///
  DateValidator({
    this.locale = 'pt_br',
  }) : super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: '##/##/####',
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(DateTime value) =>
      value == null ? '' : DateFormat.yMd(locale).format(value);

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
  DateTime parse(String text) =>
      isValid(text) ? DateFormat.yMd(locale).parse(text) : null;

  ///
  ///
  ///
  @override
  String valid(String value) => FollyUtils.validDate(value);
}
