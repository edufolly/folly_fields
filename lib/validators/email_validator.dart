import 'package:email_validator/email_validator.dart' as ev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/scope_extension.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class EmailValidator extends AbstractValidator<String> {
  EmailValidator() : super();

  @override
  TextInputType get keyboard => TextInputType.emailAddress;

  @override
  String? format(String? value) => value;

  @override
  String? strip(String? value) => value;

  @override
  bool isValid(String? value) =>
      value?.let(ev.EmailValidator.validate) ?? false;
}
