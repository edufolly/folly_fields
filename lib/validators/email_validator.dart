import 'package:folly_fields/validators/abstract_validator.dart';
import 'package:email_validator/email_validator.dart' as ev;

///
///
///
class EmailValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  EmailValidator() : super(null);

  ///
  ///
  ///
  @override
  String format(String value) => value;

  ///
  ///
  ///
  @override
  bool isValid(String value, {bool stripBeforeValidation = true}) =>
      ev.EmailValidator.validate(value);

  ///
  ///
  ///
  @override
  String strip(String value) => value;
}
