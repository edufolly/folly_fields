import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class EmptyValidator extends AbstractValidator<String> {
  ///
  ///
  ///
  EmptyValidator() : super();

  ///
  ///
  ///
  @override
  String format(String value) => value;

  ///
  ///
  ///
  @override
  String strip(String value) => value;

  ///
  ///
  ///
  @override
  bool isValid(String value) => false;
}
