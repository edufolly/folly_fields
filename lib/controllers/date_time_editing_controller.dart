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
    @Deprecated('Use property value instead dateTime.') DateTime? dateTime,
    DateTime? value,
    String locale = 'pt_br',
    String dateFormat = 'dd/MM/yyyy HH:mm',
    String mask = 'B#/D#/#### A#:C#',
  }) : super(
          validator: DateTimeValidator(
            locale: locale,
            dateFormat: dateFormat,
            mask: mask,
          ),
          value: value ?? dateTime,
        );

  ///
  ///
  ///
  DateTimeEditingController.fromValue(
    super.value, {
    String locale = 'pt_br',
    String dateFormat = 'dd/MM/yyyy HH:mm',
    String mask = 'B#/D#/#### A#:C#',
  }) : super.fromValue(
          validator: DateTimeValidator(
            locale: locale,
            dateFormat: dateFormat,
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
