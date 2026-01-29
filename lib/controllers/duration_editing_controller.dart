import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/duration_validator.dart';

class DurationEditingController extends ValidatorEditingController<Duration> {
  DurationEditingController({
    final Duration? duration,
    final String yearSuffix = 'y',
    final String monthSuffix = 'M',
    final String daySuffix = 'd',
    final String hourSuffix = 'h',
    final String minuteSuffix = 'm',
    final String secondSuffix = 's',
    final String millisecondSuffix = 'ms',
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

  DurationEditingController.fromValue(
    super.value, {
    final String yearSuffix = 'y',
    final String monthSuffix = 'M',
    final String daySuffix = 'd',
    final String hourSuffix = 'h',
    final String minuteSuffix = 'm',
    final String secondSuffix = 's',
    final String millisecondSuffix = 'ms',
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
}
