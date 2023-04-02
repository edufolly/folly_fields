import 'package:folly_fields/util/decimal.dart';

///
///
///
class FollyValidators {
  ///
  ///
  ///
  static String? decimalGTEZero(
    Decimal? decimal, {
    String msg = 'O valor deve ser igual ou maior que zero.',
  }) =>
      decimal != null && decimal.doubleValue >= 0 ? null : msg;

  ///
  ///
  ///
  static String? decimalGTZero(
    Decimal? decimal, {
    String msg = 'O valor deve ser maior que zero.',
  }) =>
      decimal != null && decimal.doubleValue > 0 ? null : msg;

  ///
  ///
  ///
  static String? decimalLTZero(
    Decimal? decimal, {
    String msg = 'O valor deve ser menor que zero.',
  }) =>
      decimal != null && decimal.doubleValue < 0 ? null : msg;

  ///
  ///
  ///
  static String? decimalLTEZero(
    Decimal? decimal, {
    String msg = 'O valor deve ser igual ou menor que zero.',
  }) =>
      decimal != null && decimal.doubleValue <= 0 ? null : msg;

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
  static String? stringNotBlank(
    String? string, {
    String msg = 'O campo deve ser preenchido.',
  }) =>
      string != null && string.trim().isNotEmpty ? null : msg;

  ///
  ///
  ///
  static String? stringNullNotEmpty(
    String? string, {
    String msg = 'Informe um valor ou deixe vazio.',
  }) =>
      string == null || string.isNotEmpty ? null : msg;

  ///
  ///
  ///
  static String? stringNullNotBlank(
    String? string, {
    String msg = 'Informe um valor ou deixe em branco.',
  }) =>
      string == null || string.trim().isNotEmpty ? null : msg;

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
  static String? notEmpty(
    dynamic value, {
    String msg = 'O campo não pode ser vazio.',
  }) {
    if (value == null) {
      return msg;
    } else if (value is Iterable) {
      if (value.isEmpty) {
        return msg;
      }
    } else if (value is Map) {
      if (value.isEmpty) {
        return msg;
      }
    } else {
      return value.toString().isEmpty ? msg : null;
    }

    return null;
  }

  ///
  ///
  ///
  static String? notBlank(
    dynamic value, {
    String msg = 'O campo deve ser preenchido.',
  }) {
    if (value == null) {
      return msg;
    } else if (value is Iterable) {
      if (value.isEmpty) {
        return msg;
      }
      if (value.length == 1) {
        if (value.first == null || value.first.toString().trim().isEmpty) {
          return msg;
        }
      }
    } else if (value is Map) {
      if (value.isEmpty) {
        return msg;
      }
      if (value.length == 1) {
        if (value.keys.first == null ||
            value.keys.first.toString().trim().isEmpty) {
          return msg;
        }
      }
    } else {
      return value.toString().trim().isEmpty ? msg : null;
    }

    return null;
  }

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
