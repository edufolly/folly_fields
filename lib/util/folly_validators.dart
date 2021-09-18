import 'package:folly_fields/util/decimal.dart';

///
///
///
class FollyValidators {
  ///
  ///
  ///
  static String? decimalGTEZero(Decimal decimal) =>
      decimal.value >= 0 ? null : 'O valor deve ser igual ou maior que zero.';

  ///
  ///
  ///
  static String? decimalGTZero(Decimal decimal) =>
      decimal.value > 0 ? null : 'O valor deve ser maior que zero.';

  ///
  ///
  ///
  static String? decimalLTZero(Decimal decimal) =>
      decimal.value < 0 ? null : 'O valor deve ser menor que zero.';

  ///
  ///
  ///
  static String? decimalLTEZero(Decimal decimal) =>
      decimal.value <= 0 ? null : 'O valor deve ser igual ou menor que zero.';

  ///
  ///
  ///
  static String? stringNotEmpty(String string) =>
      string.isNotEmpty ? null : 'O campo não pode ser vazio.';
}
