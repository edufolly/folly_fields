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
  @Deprecated('Use fromJsonDateMillis or fromJsonDateSecs.')
  static DateTime fromJsonDate(
    int? timestamp, [
    DateTime? defaultDateTime,
  ]) =>
      fromJsonDateMillis(timestamp, defaultDateTime);

  ///
  ///
  ///
  static DateTime fromJsonDateMillis(
    int? millis, [
    DateTime? defaultDateTime,
  ]) =>
      millis != null && millis >= 0
          ? DateTime.fromMillisecondsSinceEpoch(millis)
          : defaultDateTime ?? DateTime.now();

  ///
  ///
  ///
  static DateTime fromJsonDateSecs(
    int? secs, [
    DateTime? defaultDateTime,
  ]) =>
      secs != null && secs >= 0
          ? DateTime.fromMillisecondsSinceEpoch(secs * 1000)
          : defaultDateTime ?? DateTime.now();

  ///
  ///
  ///
  @Deprecated('Use fromJsonNullableDateMillis or fromJsonNullableDateSecs.')
  static DateTime? fromJsonNullableDate(int? timestamp) =>
      fromJsonNullableDateMillis(timestamp);

  ///
  ///
  ///
  static DateTime? fromJsonNullableDateMillis(int? millis) =>
      millis != null && millis >= 0
          ? DateTime.fromMillisecondsSinceEpoch(millis)
          : null;

  ///
  ///
  ///
  static DateTime? fromJsonNullableDateSecs(int? secs) =>
      secs != null && secs >= 0
          ? DateTime.fromMillisecondsSinceEpoch(secs * 1000)
          : null;

  ///
  ///
  ///
  static List<T> fromJsonList<T extends AbstractModel<Object>>(
    List<dynamic>? value,
    AbstractConsumer<T> consumer,
  ) =>
      value?.map<T>((dynamic map) => consumer.fromJson(map)).toList() ?? <T>[];

  ///
  ///
  ///
  static List<T> fromJsonListPrimary<T>(
    List<dynamic>? value,
    T Function(dynamic e) consumer,
  ) =>
      value?.map<T>(consumer).toList() ?? <T>[];

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
  static Decimal fromJsonDecimal(
    int? value,
    int? precision,
  ) =>
      Decimal(intValue: value ?? 0, precision: precision ?? 2);

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
  static Map<String, dynamic>? toMapModel<T extends AbstractModel<Object>>(
    T? model,
  ) =>
      model?.toMap();

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
  @Deprecated('Use toMapDateMillis or toMapDateSecs.')
  static int toMapDate(DateTime dateTime) => toMapDateMillis(dateTime);

  ///
  ///
  ///
  static int toMapDateMillis(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch;

  ///
  ///
  ///
  static int toMapDateSecs(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch ~/ 1000;

  ///
  ///
  ///
  @Deprecated('Use toMapNullableDateMillis or toMapNullableDateSecs.')
  static int? toMapNullableDate(DateTime? dateTime) =>
      toMapNullableDateMillis(dateTime);

  ///
  ///
  ///
  static int? toMapNullableDateMillis(DateTime? dateTime) =>
      dateTime?.millisecondsSinceEpoch;

  ///
  ///
  ///
  static int? toMapNullableDateSecs(DateTime? dateTime) =>
      dateTime == null ? null : dateTime.millisecondsSinceEpoch ~/ 1000;

  ///
  ///
  ///
  static int toMapDecimal(Decimal decimal) => decimal.intValue;

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
  static void toSaveListMapId(List<dynamic>? list) =>
      list?.map((dynamic e) => toSaveMapId(e)).toList();

  ///
  ///
  ///
  static List<Map<String, dynamic>> toSaveList<T extends AbstractModel<Object>>(
    List<T> list,
  ) =>
      list.map((T e) => e.toSave()).toList();
}
