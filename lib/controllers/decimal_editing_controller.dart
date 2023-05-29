import 'package:flutter/material.dart';
import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/decimal_validator.dart';

///
///
///
class DecimalEditingController extends ValidatorEditingController<Decimal> {
  double _lastValue = 0;

  ///
  ///
  ///
  DecimalEditingController(
    Decimal value, {
    String decimalSeparator = ',',
    String thousandSeparator = '.',
  }) : super(
          validator: DecimalValidator(
            value.precision,
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandSeparator,
          ),
        ) {
    addListener(_changeListener);
    decimal = value;
  }

  ///
  ///
  ///
  set decimal(Decimal dec) {
    if (dec.doubleValue.toStringAsFixed(0).length > 12) {
      dec.doubleValue = _lastValue;
    } else {
      _lastValue = dec.doubleValue;
    }

    final String masked = validator.format(dec);

    if (masked != super.text) {
      super.text = masked;

      final int cursorPosition = super.text.length;

      super.selection = TextSelection.fromPosition(
        TextPosition(
          offset: cursorPosition,
        ),
      );
    }
  }

  ///
  ///
  ///
  Decimal get decimal =>
      data ?? Decimal(precision: (validator as DecimalValidator).precision);

  ///
  ///
  ///
  void _changeListener() => decimal = decimal;

  ///
  ///
  ///
  set intValue(int intValue) {
    decimal = Decimal(
      precision: (validator as DecimalValidator).precision,
      intValue: intValue,
    );
  }

  ///
  ///
  ///
  int get intValue => decimal.intValue;

  ///
  ///
  ///
  set doubleValue(double doubleValue) {
    decimal = Decimal(
      precision: (validator as DecimalValidator).precision,
      doubleValue: doubleValue,
    );
  }

  ///
  ///
  ///
  double get doubleValue => decimal.doubleValue;

  ///
  ///
  ///
  @override
  void dispose() {
    removeListener(_changeListener);
    super.dispose();
  }
}
