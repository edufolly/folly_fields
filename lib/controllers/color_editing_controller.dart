import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/validators/color_validator.dart';

///
///
///
class ColorEditingController extends ValidatorEditingController<Color> {
  ///
  ///
  ///
  ColorEditingController({Color? color})
      : super(validator: ColorValidator(), value: color);

  ///
  ///
  ///
  ColorEditingController.fromValue(super.value)
      : super.fromValue(validator: ColorValidator());

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
}
