import 'package:flutter/foundation.dart';
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
  String strip(String value) {
    if (kDebugMode) {
      print('Decimal validator - call strip method.');
    }

    return value;
  }

  ///
  ///
  ///
  String _internalStrip(String value) => super.strip(value);

  ///
  ///
  ///
  @override
  String format(Decimal decimal) {
    List<String> parts = decimal.doubleValue
        .toStringAsFixed(precision)
        .replaceAll('.', '')
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
    Decimal decimal = Decimal(precision: precision);

    if (value == null || value.isEmpty) {
      return decimal;
    }

    int sepPos = value.indexOf(decimalSeparator);

    String integerPart = '0';
    String decimalPart = '0';

    if (sepPos < 0) {
      integerPart = value;
    } else if (sepPos == 0) {
      decimalPart = _internalStrip(value);
    } else {
      integerPart = _internalStrip(value.substring(0, sepPos));
      decimalPart = _internalStrip(value.substring(sepPos));
    }

    if (decimalPart.length > precision) {
      decimalPart = decimalPart.substring(0, precision);
    }

    String str = '$integerPart.$decimalPart';

    double? dbl = double.tryParse(str);

    if (dbl == null) {
      if (kDebugMode) {
        print('Error to parse $str');
      }
      dbl = 0;
    }

    decimal.doubleValue = dbl;

    return decimal;
  }

  ///
  ///
  ///
  @override
  String? valid(String value) => null;
}
