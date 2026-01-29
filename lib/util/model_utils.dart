import 'package:flutter/painting.dart';
import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/decimal.dart';
import 'package:folly_fields/validators/color_validator.dart';

@Deprecated('Refactor this methods')
class ModelUtils {
  static Color fromJsonColor(String? value, [int? defaultColor]) =>
      ColorValidator().parse(value) ?? Color(defaultColor ?? 0x00000000);

  static DateTime fromJsonDateMillis(
    int? millis, [
    DateTime? defaultDateTime,
  ]) => fromJsonNullableDateMillis(millis) ?? defaultDateTime ?? DateTime.now();

  static DateTime fromJsonDateSecs(int? secs, [DateTime? defaultDateTime]) =>
      fromJsonDateMillis(secs == null ? null : (secs * 1000), defaultDateTime);

  static Decimal fromJsonDecimalDouble(double? value, int? precision) =>
      Decimal(doubleValue: value ?? 0, precision: precision ?? 2);

  static Decimal fromJsonDecimalInt(int? value, int? precision) =>
      Decimal(intValue: value ?? 0, precision: precision ?? 2);

  // TODO(edufolly): Create tests.
  static T? fromJsonProducerMap<T>(
    dynamic value, {
    required T Function(Map<String, dynamic> e) producer,
  }) => value != null ? producer(value) : null;

  // TODO(edufolly): Create tests.
  static List<T> fromJsonListProducerMap<T>(
    dynamic value, {
    required T Function(Map<String, dynamic> e) producer,
  }) => switch (value) {
    null => <T>[],
    Iterable<dynamic> _ => value.map<T>((dynamic e) => producer(e)).toList(),
    _ => <T>[producer(value)],
  };

  // TODO(edufolly): Create tests.
  static Set<T> fromJsonSetProducerMap<T>(
    dynamic value, {
    required T Function(Map<String, dynamic> e) producer,
  }) => switch (value) {
    null => <T>{},
    Iterable<dynamic> _ => value.map<T>((dynamic e) => producer(e)).toSet(),
    _ => <T>{producer(value)},
  };

  static DateTime? fromJsonNullableDateMillis(int? millis) =>
      millis != null && millis >= 0 && millis <= 8640000000000000
      ? DateTime.fromMillisecondsSinceEpoch(millis)
      : null;

  static DateTime? fromJsonNullableDateSecs(int? secs) =>
      fromJsonNullableDateMillis(secs == null ? null : (secs * 1000));

  static int? fromJsonNullableInt(dynamic value, {int? radix}) =>
      int.tryParse(value.toString().trim(), radix: radix);

  static Map<T, U> fromJsonRawMap<T, U>(
    Map<dynamic, dynamic>? value, {
    required T Function(dynamic k) keyProducer,
    required U Function(dynamic v) valueProducer,
  }) =>
      value?.map<T, U>(
        (dynamic key, dynamic value) =>
            MapEntry<T, U>(keyProducer(key), valueProducer(value)),
      ) ??
      <T, U>{};

  static bool fromJsonSafeBool(dynamic value) =>
      value.toString().trim().toLowerCase() == 'true';

  static int fromJsonSafeInt(
    dynamic value, {
    int defaultValue = 0,
    int? radix,
  }) => fromJsonNullableInt(value, radix: radix) ?? defaultValue;

  static List<T> fromJsonSafeList<T>(
    dynamic value, {
    required T Function(dynamic e) producer,
  }) => switch (value) {
    null => <T>[],
    Iterable<dynamic> _ => value.map(producer).toList(),
    _ => <T>[producer(value)],
  };

  static Set<T> fromJsonSafeSet<T>(
    dynamic value, {
    required T Function(dynamic e) producer,
  }) => switch (value) {
    null => <T>{},
    Iterable<dynamic> _ => value.map(producer).toSet(),
    _ => <T>{producer(value)},
  };

  static List<String> fromJsonSafeStringList(dynamic value) =>
      fromJsonSafeList<String>(value, producer: stringProducer);

  static Set<String> fromJsonSafeStringSet(dynamic value) =>
      fromJsonSafeSet<String>(value, producer: stringProducer);

  static String stringProducer(dynamic e) => e.toString();

  static String toMapColor(Color color) => ColorValidator().format(color);

  static int toMapDateMillis(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch;

  static int toMapDateSecs(DateTime dateTime) =>
      dateTime.millisecondsSinceEpoch ~/ 1000;

  static double toMapDecimalDouble(Decimal decimal) => decimal.doubleValue;

  static int toMapDecimalInt(Decimal decimal) => decimal.intValue;

  static List<Map<String, dynamic>> toMapList<T extends AbstractModel<ID>, ID>(
    List<T> list,
  ) => list.map((T e) => e.toMap()).toList();

  static Map<String, dynamic>? toMapModel<T extends AbstractModel<ID>, ID>(
    T? model,
  ) => model?.toMap();

  static int? toMapNullableDateMillis(DateTime? dateTime) =>
      dateTime?.millisecondsSinceEpoch;

  static int? toMapNullableDateSecs(DateTime? dateTime) =>
      dateTime == null ? null : dateTime.millisecondsSinceEpoch ~/ 1000;

  static Set<Map<String, dynamic>> toMapSet<T extends AbstractModel<ID>, ID>(
    Set<T> set,
  ) => set.map((T e) => e.toMap()).toSet();

  static void toSaveMapOnlyId(Map<String, dynamic>? map) => map?.removeWhere(
    (String key, dynamic value) => key != FollyFields().modelIdKey,
  );

  static void toSaveListMapOnlyId(List<dynamic>? list) => list
      ?.map(
        (dynamic e) => e is Map<String, dynamic> ? toSaveMapOnlyId(e) : null,
      )
      .toList();

  static Iterable<Map<String, dynamic>>?
  _toSaveIterable<T extends AbstractModel<ID>, ID>(Iterable<T>? iterable) =>
      iterable?.map((T e) => e.toSave());

  static List<Map<String, dynamic>>?
  toSaveList<T extends AbstractModel<ID>, ID>(List<T>? list) =>
      _toSaveIterable(list)?.toList();

  static void toSaveSetMapOnlyId(Set<dynamic>? set) => set
      ?.map(
        (dynamic e) => e is Map<String, dynamic> ? toSaveMapOnlyId(e) : null,
      )
      .toSet();

  static Set<Map<String, dynamic>>? toSaveSet<T extends AbstractModel<ID>, ID>(
    Set<T>? set,
  ) => _toSaveIterable(set)?.toSet();

  static Iterable<String> _toMapEnumByName<T extends Enum>(
    Iterable<T> values,
  ) => values.map((T e) => e.name);

  static List<String> toMapListEnumByName<T extends Enum>(List<T> list) =>
      _toMapEnumByName(list).toList();

  static Set<String> toMapSetEnumByName<T extends Enum>(Set<T> set) =>
      _toMapEnumByName(set).toSet();

  static Iterable<String> _toMapEnumToString<T extends Enum>(
    Iterable<T> values,
  ) => values.map((T e) => e.toString());

  static List<String> toMapListEnumToString<T extends Enum>(List<T> list) =>
      _toMapEnumToString(list).toList();

  static Set<String> toMapSetEnumToString<T extends Enum>(Set<T> set) =>
      _toMapEnumToString(set).toSet();
}
