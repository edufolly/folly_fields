import 'package:folly_fields/util/folly_utils.dart';
import 'package:folly_fields/validators/date_time_validator.dart';

class DateValidator extends DateTimeValidator {
  DateValidator({
    super.locale,
    super.dateFormat = 'dd/MM/yyyy',
    super.mask = 'B#/D#/####',
  });

  @override
  String? valid(final String value) => FollyUtils.validDate(value);
}
