import 'package:flutter/material.dart';

import 'mask_text_input_formatter.dart';

///
///
///
abstract class AbstractValidator<T> {
  final MaskTextInputFormatter mask;

  ///
  ///
  ///
  AbstractValidator(this.mask);

  ///
  ///
  ///
  String format(T value);

  ///
  ///
  ///
  String strip(String value) => (value ?? '').replaceAll(RegExp(r'[^\d]'), '');

  ///
  ///
  ///
  bool isValid(String value, {bool stripBeforeValidation = true});

  ///
  ///
  ///
  TextInputType get keyboard => TextInputType.text;
}

///
///
///
abstract class AbstractTimeParser<T> {
  ///
  ///
  ///
  T parse(String value);

  ///
  ///
  ///
  String valid(String value);
}
