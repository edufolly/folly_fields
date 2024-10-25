import 'package:flutter/material.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class ValidatorEditingController<T> extends TextEditingController {
  final AbstractParserValidator<T> validator;

  ///
  ///
  ///
  ValidatorEditingController({required this.validator, T? value})
      : super(text: value == null ? '' : validator.format(value));

  ///
  ///
  ///
  ValidatorEditingController.fromValue(
    TextEditingValue super.value, {
    required this.validator,
  }) : super.fromValue();

  ///
  ///
  ///
  T? get data => validator.parse(text);

  ///
  ///
  ///
  set data(T? value) => text = value == null ? '' : validator.format(value);
}
