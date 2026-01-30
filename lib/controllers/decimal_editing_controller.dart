import 'package:folly_fields/controllers/validator_editing_controller.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/decimal_validator.dart';

class NewDecimalEditingController extends ValidatorEditingController<Decimal> {
  NewDecimalEditingController(
    final Decimal value, {
    final String decimalSeparator = ',',
    final String thousandSeparator = '.',
  }) : super(
         validator: DecimalValidator(
           value.precision,
           decimalSeparator: decimalSeparator,
           thousandSeparator: thousandSeparator,
         ),
       ) {
    decimal = value;
  }

  set decimal(final Decimal dec) {
    String masked = validator.format(dec);
    if (masked != text) {
      text = masked;
    }
  }

  Decimal get decimal =>
      data ?? Decimal(precision: (validator as DecimalValidator).precision);

  set intValue(final int intValue) {
    decimal = Decimal(
      precision: (validator as DecimalValidator).precision,
      intValue: intValue,
    );
  }

  int get intValue => decimal.intValue;

  set doubleValue(final double doubleValue) {
    decimal = Decimal(
      precision: (validator as DecimalValidator).precision,
      doubleValue: doubleValue,
    );
  }

  double get doubleValue => decimal.doubleValue;
}
