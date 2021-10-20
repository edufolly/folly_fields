import 'package:flutter/painting.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/color_validator.dart';

///
///
///
class ModelUtils {
  static final ColorValidator _colorValidator = ColorValidator();

  ///
  ///
  ///
  static DateTime fromJsonDate(
    int? timestamp, [
    DateTime? defaultDateTime,
  ]) =>
      timestamp != null && timestamp >= 0
          ? DateTime.fromMillisecondsSinceEpoch(timestamp)
          : defaultDateTime ?? DateTime.now();

  ///
  ///
  ///
  @Deprecated('Use fromJsonDate.')
  static DateTime toDate(
    int? timestamp, [
    DateTime? defaultDateTime,
  ]) =>
      fromJsonDate(timestamp, defaultDateTime);

  ///
  ///
  ///
  static DateTime? fromJsonNullableDate(int? timestamp) =>
      timestamp != null && timestamp >= 0
          ? DateTime.fromMillisecondsSinceEpoch(timestamp)
          : null;

  ///
  ///
  ///
  @Deprecated('Use fromJsonNullableDate.')
  static DateTime? toNullableDate(int? timestamp) =>
      fromJsonNullableDate(timestamp);

  ///
  ///
  ///
  static List<T> fromJsonList<T extends AbstractModel<Object>>(
    List<dynamic>? value,
    AbstractConsumer<T> consumer,
  ) =>
      value != null
          ? value.map<T>((dynamic map) => consumer.fromJson(map)).toList()
          : <T>[];

  ///
  ///
  ///
  @Deprecated('Use fromJsonList.')
  static List<T> toList<T extends AbstractModel<Object>>(
    List<dynamic>? value,
    AbstractConsumer<T> consumer,
  ) =>
      fromJsonList<T>(value, consumer);

  ///
  ///
  ///
  static T? fromJsonModel<T extends AbstractModel<Object>>(
    Map<String, dynamic>? map,
    AbstractConsumer<T> consumer,
  ) =>
      map != null ? consumer.fromJson(map) : null;

  ///
  ///
  ///
  @Deprecated('Use fromJsonModel.')
  static T? toModel<T extends AbstractModel<Object>>(
    Map<String, dynamic>? map,
    AbstractConsumer<T> consumer,
  ) =>
      fromJsonModel(map, consumer);

  ///
  ///
  ///
  static Decimal fromJsonDecimal(
    int? value, [
    int precision = 2,
  ]) =>
      Decimal(precision: precision, initialValue: value ?? 0);

  ///
  ///
  ///
  @Deprecated('Use fromJsonDecimal.')
  static Decimal toDecimal(
    int? value, [
    int precision = 2,
  ]) =>
      fromJsonDecimal(value, precision);

  ///
  ///
  ///
  static Color fromJsonColor(
    String? value, [
    int defaultColor = 0x00000000,
  ]) =>
      _colorValidator.parse(value, defaultColor)!;

  ///
  ///
  ///
  static List<Map<String, dynamic>> toMapList<T extends AbstractModel<Object>>(
    List<T> list,
  ) =>
      list.map((T e) => e.toMap()).toList();

  ///
  ///
  ///
  static int toMapDate(DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  ///
  ///
  ///
  static int toMapDecimal(Decimal decimal) => decimal.integer;

  ///
  ///
  ///
  static String toMapColor(Color color) => ColorValidator().format(color);

  ///
  ///
  ///
  static void toSaveMapId(Map<String, dynamic>? map) =>
      map?.removeWhere((String key, dynamic value) => key != 'id');

  ///
  ///
  ///
  @Deprecated('Use toSaveMapId.')
  static void onlyMapId(Map<String, dynamic>? map) => toSaveMapId(map);

  ///
  ///
  ///
  static void toSaveListMapId(List<dynamic>? list) =>
      list?.map((dynamic e) => toSaveMapId(e)).toList();

  ///
  ///
  ///
  @Deprecated('Use toSaveListMapId.')
  static void onlyListMapId(List<dynamic>? list) => toSaveListMapId(list);

  ///
  ///
  ///
  static List<Map<String, dynamic>> toSaveList<T extends AbstractModel<Object>>(
    List<T> list,
  ) =>
      list.map((T e) => e.toSave()).toList();
}
