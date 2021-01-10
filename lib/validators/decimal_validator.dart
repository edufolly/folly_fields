import 'package:flutter/services.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/abstract_validator.dart';

///
///
///
class DecimalValidator extends AbstractValidator<Decimal>
    implements AbstractParser<Decimal> {
  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  final int precision;

  ///
  ///
  ///
  DecimalValidator(
    this.precision, {
    this.decimalSeparator = ',',
    this.thousandSeparator = '.',
    this.rightSymbol = '',
    this.leftSymbol = '',
  }) : super(
          <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
        ) {
    if (_internalStrip(leftSymbol).isNotEmpty) {
      throw ArgumentError('leftSymbol must not have numbers.');
    }

    if (_internalStrip(rightSymbol).isNotEmpty) {
      throw ArgumentError('rightSymbol must not have numbers.');
    }
  }

  ///
  ///
  ///
  @override
  String format(Decimal value) {
    if (value == null) return '';

    List<String> textRepresentation = value.value
        .toStringAsFixed(precision)
        .replaceAll('.', '')
        .split('')
        .reversed
        .toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (int i = precision + 4; true; i += 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    String masked = textRepresentation.reversed.join('');

    if (rightSymbol.isNotEmpty) {
      masked += rightSymbol;
    }

    if (leftSymbol.isNotEmpty) {
      masked = leftSymbol + masked;
    }

    return masked;
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
  Decimal parse(String text) {
    bool hasNoValue = text.isEmpty ||
        (text.length <= (rightSymbol.length + leftSymbol.length));

    Decimal decimal = Decimal(precision: precision);

    if (hasNoValue) {
      return decimal;
    }

    List<String> parts = _internalStrip(text).split('').toList(growable: true);

    for (int i = parts.length; i <= precision; i++) {
      parts.insert(0, '0');
    }

    parts.insert(parts.length - precision, '.');

    double d = double.parse(parts.join());

    decimal.value = d;

    return decimal;
  }

  ///
  ///
  ///
  @override
  String valid(String value) => null;
}
