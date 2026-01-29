import 'package:flutter/services.dart';

abstract class AbstractValidator<T> {
  final List<TextInputFormatter>? inputFormatters;

  AbstractValidator([this.inputFormatters]);

  String format(final T value);

  String strip(final String value) => value.replaceAll(RegExp(r'\D'), '');

  bool isValid(final String value);

  TextInputType get keyboard => TextInputType.text;
}

abstract class AbstractParser<T> {
  T? parse(final String? value);

  String? valid(final String value);
}

abstract class AbstractParserValidator<T> extends AbstractValidator<T>
    implements AbstractParser<T> {
  AbstractParserValidator([super.inputFormatters]);
}
