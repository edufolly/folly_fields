import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/decimal.dart';

///
///
///
class ModelUtils {
  ///
  ///
  ///
  static DateTime toDate(
    int? timestamp, [
    DateTime? defaultDateTime,
  ]) =>
      timestamp != null && timestamp >= 0
          ? DateTime.fromMillisecondsSinceEpoch(timestamp)
          : defaultDateTime ?? DateTime.now();

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
    AbstractConsumer<T> consumer,
  ) =>
      value != null
          ? value.map<T>((dynamic map) => consumer.fromJson(map)).toList()
          : <T>[];

  ///
  ///
  ///
  static T? toModel<T extends AbstractModel<Object>>(
    Map<String, dynamic>? map,
    AbstractConsumer<T> consumer,
  ) =>
      map != null ? consumer.fromJson(map) : null;

  ///
  ///
  ///
  static Decimal toDecimal(
    int? value, [
    int precision = 2,
  ]) =>
      Decimal(precision: precision, initialValue: value ?? 0);
}
