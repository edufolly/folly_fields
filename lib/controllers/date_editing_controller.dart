import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/date_validator.dart';

class DateEditingController extends ValidatorEditingController<DateTime> {
  DateEditingController({
    super.value,
    final String locale = 'pt_br',
    final String dateFormat = 'dd/MM/yyyy',
    final String mask = 'B#/D#/####',
  }) : super(
         validator: DateValidator(
           locale: locale,
           dateFormat: dateFormat,
           mask: mask,
         ),
       );

  DateEditingController.fromValue(
    super.value, {
    final String locale = 'pt_br',
    final String dateFormat = 'dd/MM/yyyy',
    final String mask = 'B#/D#/####',
  }) : super.fromValue(
         validator: DateValidator(
           locale: locale,
           dateFormat: dateFormat,
           mask: mask,
         ),
       );
}
