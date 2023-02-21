import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/color_validator.dart';

///
///
///
class ColorEditingController extends ValidatorEditingController<Color> {
  ValueNotifier<Color> pickerColor = ValueNotifier<Color>(Colors.transparent);

  ///
  ///
  ///
  ColorEditingController({Color? color})
      : super(validator: ColorValidator(), value: color) {
    pickerColor.value = color ?? Colors.transparent;
  }

  ///
  ///
  ///
  ColorEditingController.fromValue(super.value)
      : super.fromValue(validator: ColorValidator()) {
    pickerColor.value = data ?? Colors.transparent;
  }

  ///
  ///
  ///
  @Deprecated('Use property data instead color.')
  Color? get color => data;

  ///
  ///
  ///
  @Deprecated('Use property data instead color.')
  set color(Color? color) => data = color;

  ///
  ///
  ///
  @override
  void dispose() {
    pickerColor.dispose();
    super.dispose();
  }
}
