import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
///
///
abstract class AbstractValidator<T> {
  final List<TextInputFormatter>? inputFormatters;

  ///
  ///
  ///
  AbstractValidator([this.inputFormatters]);

  ///
  ///
  ///
  String format(T value);

  ///
  ///
  ///
  String strip(String value) => value.replaceAll(RegExp(r'[^\d]'), '');

  ///
  ///
  ///
  bool isValid(String value);

  ///
  ///
  ///
  TextInputType get keyboard => TextInputType.text;
}

///
///
///
abstract class AbstractParser<T> {
  ///
  ///
  ///
  T? parse(String? value);

  ///
  ///
  ///
  String? valid(String value);
}
