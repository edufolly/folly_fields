import 'package:folly_fields/util/decimal.dart';

///
///
///
class FollyValidators {
  ///
  ///
  ///
  static String? decimalGTEZero(
    Decimal decimal, {
    String msg = 'O valor deve ser igual ou maior que zero.',
  }) =>
      decimal.doubleValue >= 0 ? null : msg;

  ///
  ///
  ///
  static String? decimalGTZero(
    Decimal decimal, {
    String msg = 'O valor deve ser maior que zero.',
  }) =>
      decimal.doubleValue > 0 ? null : msg;

  ///
  ///
  ///
  static String? decimalLTZero(
    Decimal decimal, {
    String msg = 'O valor deve ser menor que zero.',
  }) =>
      decimal.doubleValue < 0 ? null : msg;

  ///
  ///
  ///
  static String? decimalLTEZero(
    Decimal decimal, {
    String msg = 'O valor deve ser igual ou menor que zero.',
  }) =>
      decimal.doubleValue <= 0 ? null : msg;

  ///
  ///
  ///
  static String? stringNotEmpty(
    String? string, {
    String msg = 'O campo não pode ser vazio.',
  }) =>
      string != null && string.isNotEmpty ? null : msg;

  ///
  ///
  ///
  static String? stringNullNotEmpty(
    String? string, {
    String msg = 'Informe um valor ou deixe em branco.',
  }) =>
      string == null || string.isNotEmpty ? null : msg;

  ///
  ///
  ///
  static String? notNull(
    dynamic value, {
    String msg = 'O campo não pode ser nulo.',
  }) =>
      value == null ? msg : null;

  ///
  ///
  ///
  static String? intGTEZero(
    int? value, {
    String msg = 'O valor deve ser igual ou maior que zero.',
  }) =>
      (value ?? -1) >= 0 ? null : msg;

  ///
  ///
  ///
  static String? intGTZero(
    int? value, {
    String msg = 'O valor deve ser maior que zero.',
  }) =>
      (value ?? -1) > 0 ? null : msg;

  ///
  ///
  ///
  static String? intLTZero(
    int? value, {
    String msg = 'O valor deve ser menor que zero.',
  }) =>
      (value ?? 1) < 0 ? null : msg;

  ///
  ///
  ///
  static String? intLTEZero(
    int? value, {
    String msg = 'O valor deve ser igual ou menor que zero.',
  }) =>
      (value ?? 1) <= 0 ? null : msg;

  ///
  ///
  ///
  static String? intNullGTEZero(
    int? value, {
    String msg = 'O valor deve ser nulo, igual ou maior que zero.',
  }) =>
      (value == null || value >= 0) ? null : msg;

  ///
  ///
  ///
  static String? intNullGTZero(
    int? value, {
    String msg = 'O valor deve ser nulo ou maior que zero.',
  }) =>
      (value == null || value > 0) ? null : msg;

  ///
  ///
  ///
  static String? intNullLTZero(
    int? value, {
    String msg = 'O valor deve ser nulo ou menor que zero.',
  }) =>
      (value == null || value < 0) ? null : msg;

  ///
  ///
  ///
  static String? intNullLTEZero(
    int? value, {
    String msg = 'O valor deve ser nulo, igual ou menor que zero.',
  }) =>
      (value == null || value <= 0) ? null : msg;
}
