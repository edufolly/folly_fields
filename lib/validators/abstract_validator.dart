import 'package:flutter/services.dart';

abstract class AbstractValidator<T> {
  final List<TextInputFormatter>? inputFormatters;

  AbstractValidator([this.inputFormatters]);

  TextInputType get keyboard => TextInputType.text;

  String? format(T? value);

  String? strip(String? value) => value?.replaceAll(RegExp(r'\D'), '');

  bool isValid(String? value);
}

// @Deprecated('Remove this class!')
abstract class AbstractParser<T> {
  T? parse(String? value);

  String? valid(String? value);
}

// @Deprecated('Remove this class!')
abstract class AbstractParserValidator<T> extends AbstractValidator<T>
    implements AbstractParser<T> {
  AbstractParserValidator([super.inputFormatters]);
}
