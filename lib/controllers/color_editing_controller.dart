import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/color_validator.dart';

class ColorEditingController extends ValidatorEditingController<Color?> {
  ValueNotifier<Color?> pickerColor = ValueNotifier<Color?>(null);

  ColorEditingController({Color? color})
    : super(validator: ColorValidator(), value: color) {
    pickerColor.value = color;
  }

  ColorEditingController.fromValue(super.value)
    : super.fromValue(validator: ColorValidator()) {
    pickerColor.value = data;
  }

  @override
  void dispose() {
    pickerColor.dispose();
    super.dispose();
  }
}
