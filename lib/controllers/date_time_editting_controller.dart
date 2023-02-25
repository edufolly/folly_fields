import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/date_time_validator.dart';

///
///
///
class DateTimeEditingController extends ValidatorEditingController<DateTime> {
  ///
  ///
  ///
  DateTimeEditingController({
    DateTime? dateTime,
    String locale = 'pt_br',
    String format = 'dd/MM/yyyy HH:mm',
    String mask = 'B#/D#/#### A#:C#',
  }) : super(
          validator: DateTimeValidator(
            locale: locale,
            format: format,
            mask: mask,
          ),
          value: dateTime,
        );

  ///
  ///
  ///
  DateTimeEditingController.fromValue(
    super.value, {
    String locale = 'pt_br',
    String format = 'dd/MM/yyyy HH:mm',
    String mask = 'B#/D#/#### A#:C#',
  }) : super.fromValue(
          validator: DateTimeValidator(
            locale: locale,
            format: format,
            mask: mask,
          ),
        );

  ///
  ///
  ///
  @Deprecated('Use property data instead dateTime.')
  DateTime? get dateTime => data;

  ///
  ///
  ///
  @Deprecated('Use property data instead dateTime.')
  set dateTime(DateTime? date) => data = date;
}
