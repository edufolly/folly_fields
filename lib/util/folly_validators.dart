import 'package:folly_fields/util/decimal.dart';

// TODO(edufolly): How to use i18n?
// TODO(edufolly): Move to extensions?
class FollyValidators {
  static String? allowAll(final dynamic value) => null;

  static String? decimalGTEZero(
    final Decimal? decimal, {
    final String msg = 'O valor deve ser igual ou maior que zero.',
  }) => decimal != null && decimal.doubleValue >= 0 ? null : msg;

  static String? decimalGTZero(
    final Decimal? decimal, {
    final String msg = 'O valor deve ser maior que zero.',
  }) => decimal != null && decimal.doubleValue > 0 ? null : msg;

  static String? decimalLTZero(
    final Decimal? decimal, {
    final String msg = 'O valor deve ser menor que zero.',
  }) => decimal != null && decimal.doubleValue < 0 ? null : msg;

  static String? decimalLTEZero(
    final Decimal? decimal, {
    final String msg = 'O valor deve ser igual ou menor que zero.',
  }) => decimal != null && decimal.doubleValue <= 0 ? null : msg;

  static String? stringNotEmpty(
    final String? string, {
    final String msg = 'O campo não pode ser vazio.',
  }) => string != null && string.isNotEmpty ? null : msg;

  static String? stringNotBlank(
    final String? string, {
    final String msg = 'O campo deve ser preenchido.',
  }) => string != null && string.trim().isNotEmpty ? null : msg;

  static String? stringNullNotEmpty(
    final String? string, {
    final String msg = 'Informe um valor ou deixe vazio.',
  }) => string == null || string.isNotEmpty ? null : msg;

  static String? stringNullNotBlank(
    final String? string, {
    final String msg = 'Informe um valor ou deixe em branco.',
  }) => string == null || string.trim().isNotEmpty ? null : msg;

  static String? notNull(
    final dynamic value, {
    final String msg = 'O campo não pode ser nulo.',
  }) => switch (value) {
    null => msg,
    Iterable<dynamic> _ =>
      value.length == 1 && notNull(value.first, msg: msg) != null ? msg : null,
    Map<dynamic, dynamic> _ =>
      value.length == 1 &&
              (notNull(value.keys.first, msg: msg) != null ||
                  notNull(value.values.first, msg: msg) != null)
          ? msg
          : null,
    _ => null,
  };

  static String? notEmpty(
    final dynamic value, {
    final String msg = 'O campo não pode ser vazio.',
  }) => switch (value) {
    null => msg,
    Iterable<dynamic> _ =>
      value.isEmpty || notEmpty(value.first, msg: msg) != null ? msg : null,
    Map<dynamic, dynamic> _ =>
      value.isEmpty ||
              notEmpty(value.keys.first, msg: msg) != null ||
              notEmpty(value.values.first, msg: msg) != null
          ? msg
          : null,
    _ => value.toString().isEmpty ? msg : null,
  };

  static String? notBlank(
    final dynamic value, {
    final String msg = 'O campo deve ser preenchido.',
  }) => switch (value) {
    null => msg,
    Iterable<dynamic> _ =>
      value.isEmpty ||
              (value.length == 1 && notBlank(value.first, msg: msg) != null)
          ? msg
          : null,
    Map<dynamic, dynamic> _ =>
      value.isEmpty ||
              (value.length == 1 &&
                  (notBlank(value.keys.first, msg: msg) != null ||
                      notBlank(value.values.first, msg: msg) != null))
          ? msg
          : null,
    _ => value.toString().trim().isEmpty ? msg : null,
  };

  static String? intGTEZero(
    final int? value, {
    final String msg = 'O valor deve ser igual ou maior que zero.',
  }) => (value ?? -1) >= 0 ? null : msg;

  static String? intGTZero(
    final int? value, {
    final String msg = 'O valor deve ser maior que zero.',
  }) => (value ?? -1) > 0 ? null : msg;

  static String? intLTZero(
    final int? value, {
    final String msg = 'O valor deve ser menor que zero.',
  }) => (value ?? 1) < 0 ? null : msg;

  static String? intLTEZero(
    final int? value, {
    final String msg = 'O valor deve ser igual ou menor que zero.',
  }) => (value ?? 1) <= 0 ? null : msg;

  static String? intNullGTEZero(
    final int? value, {
    final String msg = 'O valor deve ser nulo, igual ou maior que zero.',
  }) => (value == null || value >= 0) ? null : msg;

  static String? intNullGTZero(
    final int? value, {
    final String msg = 'O valor deve ser nulo ou maior que zero.',
  }) => (value == null || value > 0) ? null : msg;

  static String? intNullLTZero(
    final int? value, {
    final String msg = 'O valor deve ser nulo ou menor que zero.',
  }) => (value == null || value < 0) ? null : msg;

  static String? intNullLTEZero(
    final int? value, {
    final String msg = 'O valor deve ser nulo, igual ou menor que zero.',
  }) => (value == null || value <= 0) ? null : msg;
}
