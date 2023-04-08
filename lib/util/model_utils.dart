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
  ///
  ///
  ///
  static Color fromJsonColor(
    String? value, [
    int? defaultColor,
  ]) =>
      ColorValidator().parse(value) ?? Color(defaultColor ?? 0x00000000);

  ///
  ///
  ///
  static DateTime fromJsonDateMillis(
    int? millis, [
    DateTime? defaultDateTime,
  ]) =>
      fromJsonNullableDateMillis(millis) ?? defaultDateTime ?? DateTime.now();

  ///
  ///
  ///
  static DateTime fromJsonDateSecs(
    int? secs, [
    DateTime? defaultDateTime,
  ]) =>
      fromJsonDateMillis(secs == null ? null : (secs * 1000), defaultDateTime);

  ///
  ///
  ///
  static Decimal fromJsonDecimalDouble(
    double? value,
    int? precision,
  ) =>
      Decimal(doubleValue: value ?? 0, precision: precision ?? 2);

  ///
  ///
  ///
  static Decimal fromJsonDecimalInt(
    int? value,
    int? precision,
  ) =>
      Decimal(intValue: value ?? 0, precision: precision ?? 2);

  ///
  ///
  ///
  static List<T> fromJsonList<T extends AbstractModel<Object>>(
    List<dynamic>? value,
    AbstractConsumer<T> consumer,
  ) =>
      _fromJsonRawIterable<T>(
        value,
        producer: (dynamic e) => consumer.fromJson(e),
      )?.toList() ??
      <T>[];

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
  static DateTime? fromJsonNullableDateMillis(int? millis) =>
      millis != null && millis >= 0 && millis <= 8640000000000000
          ? DateTime.fromMillisecondsSinceEpoch(millis)
          : null;

  ///
  ///
  ///
  static DateTime? fromJsonNullableDateSecs(int? secs) =>
      fromJsonNullableDateMillis(secs == null ? null : (secs * 1000));

  ///
  ///
  ///
  static Iterable<T>? _fromJsonRawIterable<T>(
    Iterable<dynamic>? value, {
    required T Function(dynamic e) producer,
  }) =>
      value?.map<T>(producer);

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
  static List<T> fromJsonSafeList<T>(
    dynamic value, {
    required T Function(dynamic e) producer,
  }) =>
      value == null
          ? <T>[]
          : (value is Iterable)
              ? _fromJsonRawIterable<T>(value, producer: producer)?.toList() ??
                  <T>[]
              : <T>[producer(value)];

  ///
  ///
  ///
  static Set<T> fromJsonSafeSet<T>(
    dynamic value, {
    required T Function(dynamic e) producer,
  }) =>
      value == null
          ? <T>{}
          : (value is Iterable)
              ? _fromJsonRawIterable<T>(value, producer: producer)?.toSet() ??
                  <T>{}
              : <T>{producer(value)};

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
  static Set<String> fromJsonSafeStringSet(dynamic value) =>
      fromJsonSafeSet<String>(
        value,
        producer: stringProducer,
      );

  ///
  ///
  ///
  static Set<T> fromJsonSet<T extends AbstractModel<Object>>(
    Set<dynamic>? value,
    AbstractConsumer<T> consumer,
  ) =>
      _fromJsonRawIterable<T>(
        value,
        producer: (dynamic e) => consumer.fromJson(e),
      )?.toSet() ??
      <T>{};

  ///
  ///
  ///
  static String stringProducer(dynamic e) => e.toString();

  ///
  ///
  ///
  static String toMapColor(Color color) => ColorValidator().format(color);

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
  static double toMapDecimalDouble(Decimal decimal) => decimal.doubleValue;

  ///
  ///
  ///
  static int toMapDecimalInt(Decimal decimal) => decimal.intValue;

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
  static Map<String, dynamic>? toMapModel<T extends AbstractModel<Object>>(
    T? model,
  ) =>
      model?.toMap();

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
  static Set<Map<String, dynamic>> toMapSet<T extends AbstractModel<Object>>(
    Set<T> set,
  ) =>
      set.map((T e) => e.toMap()).toSet();

  ///
  ///
  ///
  static void _toSaveMapOnlyId(Map<String, dynamic>? map) => map?.removeWhere(
        (String key, dynamic value) => key != FollyFields().modelIdKey,
      );

  ///
  ///
  ///
  static void toSaveListMapOnlyId(List<dynamic>? list) => list
      ?.map(
        (dynamic e) => e is Map<String, dynamic> ? _toSaveMapOnlyId(e) : null,
      )
      .toList();

  ///
  ///
  ///
  static List<Map<String, dynamic>>?
      toSaveList<T extends AbstractModel<Object>>(
    List<T>? list,
  ) =>
          _toSaveIterable(list)?.toList();

  ///
  ///
  ///
  static void toSaveSetMapOnlyId(Set<dynamic>? set) => set
      ?.map(
        (dynamic e) => e is Map<String, dynamic> ? _toSaveMapOnlyId(e) : null,
      )
      .toSet();

  ///
  ///
  ///
  static Set<Map<String, dynamic>>? toSaveSet<T extends AbstractModel<Object>>(
    Set<T>? set,
  ) =>
      _toSaveIterable(set)?.toSet();

  ///
  ///
  ///
  static Iterable<Map<String, dynamic>>?
      _toSaveIterable<T extends AbstractModel<Object>>(Iterable<T>? iterable) =>
          iterable?.map((T e) => e.toSave());
}
