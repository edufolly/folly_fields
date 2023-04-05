import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/date_validator.dart';

///
///
///
class DateEditingController extends ValidatorEditingController<DateTime> {
  ///
  ///
  ///
  DateEditingController({
    // TODO(edufolly): Remove in version 1.0.0.
    @Deprecated('Use property value instead dateTime.') DateTime? dateTime,
    DateTime? value,
    String locale = 'pt_br',
    String dateFormat = 'dd/MM/yyyy',
    String mask = 'B#/D#/####',
  }) : super(
          validator: DateValidator(
            locale: locale,
            dateFormat: dateFormat,
            mask: mask,
          ),
          value: value ?? dateTime,
        );

  ///
  ///
  ///
  DateEditingController.fromValue(
    super.value, {
    String locale = 'pt_br',
    String dateFormat = 'dd/MM/yyyy',
    String mask = 'B#/D#/####',
  }) : super.fromValue(
          validator: DateValidator(
            locale: locale,
            dateFormat: dateFormat,
            mask: mask,
          ),
        );

  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('Use property data instead date.')
  DateTime? get date => data;

  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('Use property data instead date.')
  set date(DateTime? date) => data = date;
}
