import 'package:folly_fields/util/decimal.dart';

///
///
///
class FollyValidators {
  ///
  ///
  ///
  static String? decimalGTEZero(Decimal decimal) => decimal.doubleValue >= 0
      ? null
      : 'O valor deve ser igual ou maior que zero.';

  ///
  ///
  ///
  static String? decimalGTZero(Decimal decimal) =>
      decimal.doubleValue > 0 ? null : 'O valor deve ser maior que zero.';

  ///
  ///
  ///
  static String? decimalLTZero(Decimal decimal) =>
      decimal.doubleValue < 0 ? null : 'O valor deve ser menor que zero.';

  ///
  ///
  ///
  static String? decimalLTEZero(Decimal decimal) => decimal.doubleValue <= 0
      ? null
      : 'O valor deve ser igual ou menor que zero.';

  ///
  ///
  ///
  static String? stringNotEmpty(String string) =>
      string.isNotEmpty ? null : 'O campo não pode ser vazio.';

  ///
  ///
  ///
  static String? notNull(dynamic value) =>
      value == null ? 'O campo não pode ser nulo.' : null;

  ///
  ///
  ///
  static String? intGTEZero(int? value) =>
      (value ?? -1) >= 0 ? null : 'O valor deve ser igual ou maior que zero.';

  ///
  ///
  ///
  static String? intGTZero(int? value) =>
      (value ?? -1) > 0 ? null : 'O valor deve ser maior que zero.';

  ///
  ///
  ///
  static String? intLTZero(int? value) =>
      (value ?? 1) < 0 ? null : 'O valor deve ser menor que zero.';

  ///
  ///
  ///
  static String? intLTEZero(int? value) =>
      (value ?? 1) <= 0 ? null : 'O valor deve ser igual ou menor que zero.';
}
