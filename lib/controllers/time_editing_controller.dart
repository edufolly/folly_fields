import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/time_validator.dart';

///
///
///
class TimeEditingController extends ValidatorEditingController<TimeOfDay> {
  ///
  ///
  ///
  TimeEditingController({
    @Deprecated('Use property value instead time.') TimeOfDay? time,
    TimeOfDay? value,
  }) : super(validator: TimeValidator(), value: value ?? time);

  ///
  ///
  ///
  TimeEditingController.fromValue(super.value)
      : super.fromValue(validator: TimeValidator());

  ///
  ///
  ///
  @Deprecated('Use property data instead time.')
  TimeOfDay? get time => data;

  ///
  ///
  ///
  @Deprecated('Use property data instead time.')
  set time(TimeOfDay? time) => data = time;
}
