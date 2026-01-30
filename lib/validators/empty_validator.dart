import 'package:folly_fields/validators/abstract_validator.dart';

class EmptyValidator extends AbstractValidator<String> {
  EmptyValidator() : super();

  @override
  String format(final String value) => value;

  @override
  String strip(final String value) => value;

  @override
  bool isValid(final String value) => false;
}
