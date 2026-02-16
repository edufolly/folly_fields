import 'package:flutter/material.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class ValidatorEditingController<T> extends TextEditingController {
  final AbstractParserValidator<T> validator;

  ValidatorEditingController({required this.validator, final T? value})
    : super(text: value?.let(validator.format));

  ValidatorEditingController.fromValue(
    TextEditingValue super.value, {
    required this.validator,
  }) : super.fromValue();

  T? get data => text.isEmpty ? null : validator.parse(text);

  set data(T? value) => text = value?.let(validator.format) ?? '';
}
