import 'package:flutter/painting.dart';
import 'package:folly_fields/crud/abstract_consumer.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/folly_fields.dart';
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
  static String stringProducer(dynamic e) => e.toString();

  ///
  ///
  ///
  static DateTime fromJsonDateMillis(
    int? millis, [
    DateTime? defaultDateTime,
  ]) =>
      millis != null && millis >= 0 && millis <= 8640000000000000
          ? DateTime.fromMillisecondsSinceEpoch(millis)
          : defaultDateTime ?? DateTime.now();

  ///
  ///
  ///
  static DateTime fromJsonDateSecs(
    int? secs, [
    DateTime? defaultDateTime,
  ]) =>
      secs != null && secs >= 0 && secs <= 8640000000000
          ? DateTime.fromMillisecondsSinceEpoch(secs * 1000)
          : defaultDateTime ?? DateTime.now();

  ///
  ///
  ///
  static DateTime? fromJsonNullableDateMillis(int? millis) =>
      millis != null && millis >= 0 && millis <= 8640000000000000
          ? DateTime.fromMillisecondsSinceEpoch(millis)
          : null;

  ///
  ///
  ///
  static DateTime? fromJsonNullableDateSecs(int? secs) =>
      secs != null && secs >= 0 && secs <= 8640000000000
          ? DateTime.fromMillisecondsSinceEpoch(secs * 1000)
          : null;

  ///
  ///
  ///
  static Iterable<T>? fromJsonRawIterable<T>(
    Iterable<dynamic>? value, {
    required T Function(dynamic e) producer,
  }) =>
      value?.map<T>(producer);

  ///
  ///
  ///
  static Set<T> fromJsonSet<T extends AbstractModel<Object>>(
    Set<dynamic>? value,
    AbstractConsumer<T> consumer,
  ) =>
      fromJsonRawIterable<T>(
        value,
        producer: (dynamic e) => consumer.fromJson(e),
      )?.toSet() ??
      <T>{};

  ///
  ///
  ///
  static Set<T> fromJsonSafeSet<T>(
    dynamic value, {
    required T Function(dynamic e) producer,
  }) =>
      value == null
          ? <T>{}
          : (value is Set)
              ? fromJsonRawIterable<T>(value, producer: producer)?.toSet() ??
                  <T>{}
              : <T>{producer(value)};

  ///
  ///
  ///
  static Set<String> fromJsonSafeStringSet(dynamic value) =>
      fromJsonSafeSet<String>(
        value,
        producer: stringProducer,
      );

  ///
  ///
  ///
  static List<T> fromJsonList<T extends AbstractModel<Object>>(
    List<dynamic>? value,
    AbstractConsumer<T> consumer,
  ) =>
      fromJsonRawIterable<T>(
        value,
        producer: (dynamic e) => consumer.fromJson(e),
      )?.toList() ??
      <T>[];

  ///
  ///
  ///
  static List<T> fromJsonSafeList<T>(
    dynamic value, {
    required T Function(dynamic e) producer,
  }) =>
      value == null
          ? <T>[]
          : (value is List)
              ? fromJsonRawIterable<T>(value, producer: producer)?.toList() ??
                  <T>[]
              : <T>[producer(value)];

  ///
  ///
  ///
  static List<String> fromJsonSafeStringList(dynamic value) =>
      fromJsonSafeList<String>(
        value,
        producer: stringProducer,
      );

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
  static Map<T, U> fromJsonRawMap<T, U>(
    Map<dynamic, dynamic>? value, {
    required T Function(dynamic k) keyProducer,
    required U Function(dynamic v) valueProducer,
  }) =>
      value?.map<T, U>(
        (dynamic key, dynamic value) => MapEntry<T, U>(
          keyProducer(key),
          valueProducer(value),
        ),
      ) ??
      <T, U>{};

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
  static Set<Map<String, dynamic>> toMapSet<T extends AbstractModel<Object>>(
    Set<T> set,
  ) =>
      set.map((T e) => e.toMap()).toSet();

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
  @Deprecated('Use toMapDecimalInt instead.')
  static int toMapDecimal(Decimal decimal) => toMapDecimalInt(decimal);

  ///
  ///
  ///
  static int toMapDecimalInt(Decimal decimal) => decimal.intValue;

  ///
  ///
  ///
  static double toMapDecimalDouble(Decimal decimal) => decimal.doubleValue;

  ///
  ///
  ///
  static String toMapColor(Color color) => ColorValidator().format(color);

  ///
  ///
  ///
  static void toSaveMapId(Map<String, dynamic>? map) => map?.removeWhere(
        (String key, dynamic value) => key != FollyFields().modelIdKey,
      );

  ///
  ///
  ///
  static void toSaveSetMapId(Set<dynamic>? set) =>
      set?.map((dynamic e) => toSaveMapId(e as Map<String, dynamic>?)).toSet();

  ///
  ///
  ///
  static Set<Map<String, dynamic>> toSaveSet<T extends AbstractModel<Object>>(
    Set<T> set,
  ) =>
      set.map((T e) => e.toSave()).toSet();

  ///
  ///
  ///
  static void toSaveListMapId(List<dynamic>? list) => list
      ?.map((dynamic e) => toSaveMapId(e as Map<String, dynamic>?))
      .toList();

  ///
  ///
  ///
  static List<Map<String, dynamic>> toSaveList<T extends AbstractModel<Object>>(
    List<T> list,
  ) =>
      list.map((T e) => e.toSave()).toList();
}
