import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/time_validator.dart';

class TimeEditingController extends ValidatorEditingController<TimeOfDay> {
  TimeEditingController({super.value}) : super(validator: TimeValidator());

  TimeEditingController.fromValue(super.value)
    : super.fromValue(validator: TimeValidator());
}
