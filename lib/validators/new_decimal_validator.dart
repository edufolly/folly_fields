import 'package:flutter/services.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/decimal_text_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class NewDecimalValidator extends AbstractParserValidator<Decimal> {
  final int precision;
  final String decimalSeparator;
  final String thousandSeparator;

  ///
  ///
  ///
  NewDecimalValidator(
    this.precision, {
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
  })  : assert(
          precision >= 0,
          'precision must be equals or greater than zero.',
        ),
        super(<TextInputFormatter>[
          DecimalTextFormatter(
            precision: precision,
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandSeparator,
          ),
        ]);

  ///
  ///
  ///
  @override
  TextInputType get keyboard => TextInputType.number;

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
  String format(Decimal decimal) {
    final List<String> parts = decimal.doubleValue
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .replaceAll('-', '')
        .split('')
        .reversed
        .toList();

    int start = precision + 4;
    if (precision > 0) {
      parts.insert(precision, decimalSeparator);
    } else {
      start = 3;
    }

    for (int pos = start; parts.length > pos; pos += 4) {
      parts.insert(pos, thousandSeparator);
    }

    if (decimal.doubleValue < 0) {
      parts.add('-');
    }

    return parts.reversed.join();
  }

  ///
  ///
  ///
  @override
  bool isValid(String decimal) => valid(decimal) == null;

  ///
  ///
  ///
  @override
  Decimal? parse(String? value) {
    final Decimal decimal = Decimal(precision: precision);

    if (value == null || value.isEmpty) {
      return decimal;
    }

    final bool isNegative = value.startsWith('-');

    final String newValue = value.replaceAll('-', '');

    final int sepPos = newValue.indexOf(decimalSeparator);

    String integerPart = '0';
    String decimalPart = '0';

    if (sepPos < 0) {
      integerPart = newValue;
    } else if (sepPos == 0) {
      decimalPart = _internalStrip(newValue);
    } else {
      integerPart = _internalStrip(newValue.substring(0, sepPos));
      decimalPart = _internalStrip(newValue.substring(sepPos));
    }

    if (decimalPart.length > precision) {
      decimalPart = decimalPart.substring(0, precision);
    }

    final String str = '${isNegative ? '-' : ''}$integerPart.$decimalPart';

    decimal.doubleValue = double.tryParse(str) ?? 0;

    return decimal;
  }

  ///
  ///
  ///
  @override
  String? valid(String value) => null;
}
