import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/duration_validator.dart';

///
///
///
class DurationEditingController extends ValidatorEditingController<Duration> {
  ///
  ///
  ///
  DurationEditingController({
    Duration? duration,
    String yearSuffix = 'y',
    String monthSuffix = 'M',
    String daySuffix = 'd',
    String hourSuffix = 'h',
    String minuteSuffix = 'm',
    String secondSuffix = 's',
    String millisecondSuffix = 'ms',
  }) : super(
          validator: DurationValidator(
            yearSuffix: yearSuffix,
            monthSuffix: monthSuffix,
            daySuffix: daySuffix,
            hourSuffix: hourSuffix,
            minuteSuffix: minuteSuffix,
            secondSuffix: secondSuffix,
            millisecondSuffix: millisecondSuffix,
          ),
          value: duration,
        );

  ///
  ///
  ///
  DurationEditingController.fromValue(
    super.value, {
    String yearSuffix = 'y',
    String monthSuffix = 'M',
    String daySuffix = 'd',
    String hourSuffix = 'h',
    String minuteSuffix = 'm',
    String secondSuffix = 's',
    String millisecondSuffix = 'ms',
  }) : super.fromValue(
          validator: DurationValidator(
            yearSuffix: yearSuffix,
            monthSuffix: monthSuffix,
            daySuffix: daySuffix,
            hourSuffix: hourSuffix,
            minuteSuffix: minuteSuffix,
            secondSuffix: secondSuffix,
            millisecondSuffix: millisecondSuffix,
          ),
        );

  ///
  ///
  ///
  @Deprecated('Use property data instead duration.')
  Duration? get duration => data;

  ///
  ///
  ///
  @Deprecated('Use property data instead duration.')
  set duration(Duration? duration) => data = duration;
}
