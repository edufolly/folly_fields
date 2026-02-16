import 'package:flutter/services.dart';
import 'package:folly_fields/extensions/string_extension.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/util/decimal_text_formatter.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

class DecimalValidator extends AbstractParserValidator<Decimal> {
  final int precision;
  final String decimalSeparator;
  final String thousandSeparator;

  DecimalValidator(
    this.precision, {
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
  }) : assert(precision >= 0, 'precision must be equals or greater than zero.'),
       super(<TextInputFormatter>[
         DecimalTextFormatter(
           precision: precision,
           decimalSeparator: decimalSeparator,
           thousandSeparator: thousandSeparator,
         ),
       ]);

  @override
  TextInputType get keyboard => TextInputType.number;

  @override
  String? strip(String? value) => value;

  @override
  String? format(Decimal? decimal) {
    if (decimal == null) return null;

    List<String> parts = decimal.doubleValue
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

  @override
  bool isValid(String? decimal) => valid(decimal) == null;

  @override
  Decimal? parse(String? value) {
    if (value.isNullOrBlank) return null;

    bool isNegative = value!.startsWith('-');

    String newValue = value.replaceAll('-', '');

    int sepPos = newValue.indexOf(decimalSeparator);

    String integerPart = '0';
    String decimalPart = '0';

    if (sepPos < 0) {
      integerPart = newValue;
    } else if (sepPos == 0) {
      decimalPart = super.strip(newValue)!;
    } else {
      integerPart = super.strip(newValue.substring(0, sepPos))!;
      decimalPart = super.strip(newValue.substring(sepPos))!;
    }

    if (decimalPart.length > precision) {
      decimalPart = decimalPart.substring(0, precision);
    }

    String str = '${isNegative ? '-' : ''}$integerPart.$decimalPart';

    return Decimal(
      precision: precision,
      doubleValue: double.tryParse(str) ?? 0,
    );
  }

  @override
  String? valid(String? value) => null;
}
