import 'package:email_validator/email_validator.dart' as ev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class EmailValidator extends AbstractValidator<String> {
  EmailValidator() : super();

  @override
  String format(final String value) => value;

  @override
  bool isValid(final String value) => ev.EmailValidator.validate(value);

  @override
  String strip(final String value) => value;

  @override
  TextInputType get keyboard => TextInputType.emailAddress;
}
