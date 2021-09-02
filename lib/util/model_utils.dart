import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/decimal.dart';

///
///
///
class ModelUtils {
  ///
  ///
  ///
  static DateTime toDate(int? timestamp) => timestamp != null && timestamp >= 0
      ? DateTime.fromMillisecondsSinceEpoch(timestamp)
      : DateTime.now();

  ///
  ///
  ///
  static DateTime? toNullableDate(int? timestamp) =>
      timestamp != null && timestamp >= 0
          ? DateTime.fromMillisecondsSinceEpoch(timestamp)
          : null;

  ///
  ///
  ///
  static List<T> toList<T extends AbstractModel<Object>>(
    List<dynamic>? value,
    T Function(dynamic map) parse,
  ) =>
      value != null ? value.map<T>(parse).toList() : <T>[];

  ///
  ///
  ///
  static T? toModel<T extends AbstractModel<Object>>(
    dynamic value,
    T Function(dynamic map) parse,
  ) =>
      value != null ? parse(value) : null;

  ///
  ///
  ///
  static Decimal toDecimal(
    Map<String, dynamic> map,
    String key, [
    int precision = 2,
  ]) =>
      Decimal(precision: precision, initialValue: map[key] ?? 0);
}
