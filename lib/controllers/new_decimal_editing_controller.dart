import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/new_decimal_validator.dart';

///
///
///
class NewDecimalEditingController extends ValidatorEditingController<Decimal> {
  ///
  ///
  ///
  NewDecimalEditingController(
    Decimal value, {
    String decimalSeparator = ',',
    String thousandSeparator = '.',
  }) : super(
          validator: NewDecimalValidator(
            value.precision,
            decimalSeparator: decimalSeparator,
            thousandSeparator: thousandSeparator,
          ),
        ) {
    decimal = value;
  }

  ///
  ///
  ///
  set decimal(Decimal dec) {
    String masked = validator.format(dec);
    if (masked != text) {
      text = masked;
    }
  }

  ///
  ///
  ///
  Decimal get decimal =>
      data ?? Decimal(precision: (validator as NewDecimalValidator).precision);

  ///
  ///
  ///
  set intValue(int intValue) {
    decimal = Decimal(
      precision: (validator as NewDecimalValidator).precision,
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
      precision: (validator as NewDecimalValidator).precision,
      doubleValue: doubleValue,
    );
  }

  ///
  ///
  ///
  double get doubleValue => decimal.doubleValue;
}
