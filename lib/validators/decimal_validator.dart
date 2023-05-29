import 'package:flutter/services.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class DecimalValidator extends AbstractParserValidator<Decimal> {
  final String decimalSeparator;
  final String thousandSeparator;
  final int precision;

  ///
  ///
  ///
  DecimalValidator(
    this.precision, {
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
  })  : assert(precision >= 0, 'precision must be positive or zero.'),
        super(
          <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
        );

  ///
  ///
  ///
  @override
  String format(Decimal decimal) {
    final List<String> parts = decimal.doubleValue
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    int start = precision + 4;
    if (precision > 0) {
      parts.insert(precision, decimalSeparator);
    } else {
      start = 3;
    }

    for (int pos = start; parts.length > pos; pos += 4) {
      parts.insert(pos, thousandSeparator);
    }

    return parts.reversed.join();
  }

  ///
  ///
  ///
  @override
  String strip(String value) => value;

  ///
  ///
  ///
  String _internalStrip(String value) => super.strip(value);

  ///
  ///
  ///
  @override
  bool isValid(String value) => valid(value) == null;

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.number;

  ///
  ///
  ///
  @override
  Decimal? parse(String? value) {
    final Decimal decimal = Decimal(precision: precision);

    if (value == null || value.isEmpty) {
      return decimal;
    }

    final List<String> parts =
        _internalStrip(value).split('').toList(growable: true);

    for (int pos = parts.length; pos <= precision; pos++) {
      parts.insert(0, '0');
    }

    if (precision > 0) {
      parts.insert(parts.length - precision, '.');
    }

    decimal.doubleValue = double.parse(parts.join());

    return decimal;
  }

  ///
  ///
  ///
  @override
  String? valid(String value) => null;
}
