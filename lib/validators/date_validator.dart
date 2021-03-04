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
  final DateFormat dateFormat;

  ///
  ///
  ///
  DateValidator({
    String format = 'dd/MM/yyyy',
    String locale = 'pt_br',
    String mask = '##/##/####',
  })  : dateFormat = DateFormat(format, locale),
        super(
          <TextInputFormatter>[
            MaskTextInputFormatter(
              mask: mask,
            ),
          ],
        );

  ///
  ///
  ///
  @override
  String format(DateTime value) => dateFormat.format(value);

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
  DateTime? parse(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    } else {
      try {
        return dateFormat.parse(text);
      } catch (e) {
        return null;
      }
    }
  }

  ///
  ///
  ///
  @override
  String? valid(String value) => FollyUtils.validDate(value);
}
