import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/model_utils.dart';

///
///
///
void main() {
  ///
  group('ModelUtils fromJsonDateMillis', () {
    DateTime now = DateTime.now().copyWith(microsecond: 0);

    Map<MapEntry<int?, DateTime?>, dynamic> domain =
        <MapEntry<int?, DateTime?>, dynamic>{
      MapEntry<int?, DateTime?>(null, now): now,
      MapEntry<int?, DateTime?>(now.millisecondsSinceEpoch, null): now,
      MapEntry<int?, DateTime?>(8640000000000001, now): now,
      const MapEntry<int?, DateTime?>(null, null): isA<DateTime>(),
      const MapEntry<int?, DateTime?>(-1, null): isA<DateTime>(),
      const MapEntry<int?, DateTime?>(0, null): DateTime.utc(1970).toLocal(),
      const MapEntry<int?, DateTime?>(1, null):
          DateTime.utc(1970, 1, 1, 0, 0, 0, 1).toLocal(),
      const MapEntry<int?, DateTime?>(1999, null):
          DateTime.utc(1970, 1, 1, 0, 0, 1, 999).toLocal(),
      const MapEntry<int?, DateTime?>(59999, null):
          DateTime.utc(1970, 1, 1, 0, 0, 59, 999).toLocal(),
      const MapEntry<int?, DateTime?>(3599999, null):
          DateTime.utc(1970, 1, 1, 0, 59, 59, 999).toLocal(),
      const MapEntry<int?, DateTime?>(8640000000000000, null):
          DateTime.utc(275760, 9, 13).toLocal(),
      const MapEntry<int?, DateTime?>(8640000000000001, null): isA<DateTime>(),
    };

    for (final MapEntry<MapEntry<int?, DateTime?>, dynamic> input
        in domain.entries) {
      test('${input.key.key} - ${input.key.value}', () {
        expect(
          ModelUtils.fromJsonDateMillis(input.key.key, input.key.value),
          input.value,
        );
      });
    }
  });

  ///
  group('ModelUtils fromJsonDateSecs', () {
    DateTime now = DateTime.now().copyWith(millisecond: 0, microsecond: 0);

    Map<MapEntry<int?, DateTime?>, dynamic> domain =
        <MapEntry<int?, DateTime?>, dynamic>{
      MapEntry<int?, DateTime?>(null, now): now,
      MapEntry<int?, DateTime?>(now.millisecondsSinceEpoch ~/ 1000, null): now,
      MapEntry<int?, DateTime?>(8640000000001, now): now,
      const MapEntry<int?, DateTime?>(null, null): isA<DateTime>(),
      const MapEntry<int?, DateTime?>(-1, null): isA<DateTime>(),
      const MapEntry<int?, DateTime?>(0, null): DateTime.utc(1970).toLocal(),
      const MapEntry<int?, DateTime?>(1, null):
          DateTime.utc(1970, 1, 1, 0, 0, 1).toLocal(),
      const MapEntry<int?, DateTime?>(1999, null):
          DateTime.utc(1970, 1, 1, 0, 33, 19).toLocal(),
      const MapEntry<int?, DateTime?>(59999, null):
          DateTime.utc(1970, 1, 1, 16, 39, 59).toLocal(),
      const MapEntry<int?, DateTime?>(3599999, null):
          DateTime.utc(1970, 2, 11, 15, 59, 59).toLocal(),
      const MapEntry<int?, DateTime?>(8640000000000, null):
          DateTime.utc(275760, 9, 13).toLocal(),
      const MapEntry<int?, DateTime?>(8640000000001, null): isA<DateTime>(),
    };

    for (final MapEntry<MapEntry<int?, DateTime?>, dynamic> input
        in domain.entries) {
      test('${input.key.key} - ${input.key.value}', () {
        expect(
          ModelUtils.fromJsonDateSecs(input.key.key, input.key.value),
          input.value,
        );
      });
    }
  });

  ///
  group('ModelUtils fromJsonNullableDateMillis', () {
    DateTime now = DateTime.now().copyWith(microsecond: 0);

    Map<int?, DateTime?> domain = <int?, DateTime?>{
      null: null,
      now.millisecondsSinceEpoch: now,
      -1: null,
      0: DateTime.utc(1970).toLocal(),
      1: DateTime.utc(1970, 1, 1, 0, 0, 0, 1).toLocal(),
      1999: DateTime.utc(1970, 1, 1, 0, 0, 1, 999).toLocal(),
      59999: DateTime.utc(1970, 1, 1, 0, 0, 59, 999).toLocal(),
      3599999: DateTime.utc(1970, 1, 1, 0, 59, 59, 999).toLocal(),
      8640000000000000: DateTime.utc(275760, 9, 13).toLocal(),
      8640000000000001: null,
    };

    for (final MapEntry<int?, DateTime?> input in domain.entries) {
      test('${input.key} - ${input.value}', () {
        expect(
          ModelUtils.fromJsonNullableDateMillis(input.key),
          input.value,
        );
      });
    }
  });

  ///
  group('ModelUtils fromJsonNullableDateSecs', () {
    DateTime now = DateTime.now().copyWith(millisecond: 0, microsecond: 0);

    Map<int?, DateTime?> domain = <int?, DateTime?>{
      null: null,
      now.millisecondsSinceEpoch ~/ 1000: now,
      -1: null,
      0: DateTime.utc(1970).toLocal(),
      1: DateTime.utc(1970, 1, 1, 0, 0, 1).toLocal(),
      1999: DateTime.utc(1970, 1, 1, 0, 33, 19).toLocal(),
      59999: DateTime.utc(1970, 1, 1, 16, 39, 59).toLocal(),
      3599999: DateTime.utc(1970, 2, 11, 15, 59, 59).toLocal(),
      8640000000000: DateTime.utc(275760, 9, 13).toLocal(),
      8640000000001: null,
    };

    for (final MapEntry<int?, DateTime?> input in domain.entries) {
      test('${input.key} - ${input.value}', () {
        expect(
          ModelUtils.fromJsonNullableDateSecs(input.key),
          input.value,
        );
      });
    }
  });

  // TODO(edufolly): fromJsonRawIterable
  // TODO(edufolly): fromJsonSet
  // TODO(edufolly): fromJsonSafeSet
  // TODO(edufolly): fromJsonSafeStringSet
  // TODO(edufolly): fromJsonList
  // TODO(edufolly): fromJsonSafeList
  // TODO(edufolly): fromJsonSafeStringList
  // TODO(edufolly): fromJsonModel
  // TODO(edufolly): fromJsonDecimal
  // TODO(edufolly): fromJsonColor
  // TODO(edufolly): fromJsonRawMap
  // TODO(edufolly): toMapModel
  // TODO(edufolly): toMapSet
  // TODO(edufolly): toMapList
  // TODO(edufolly): toMapDateMillis
  // TODO(edufolly): toMapDateSecs
  // TODO(edufolly): toMapNullableDateMillis
  // TODO(edufolly): toMapNullableDateSecs
  // TODO(edufolly): toMapDecimal
  // TODO(edufolly): toMapColor
  // TODO(edufolly): toSaveMapId
  // TODO(edufolly): toSaveSetMapId
  // TODO(edufolly): toSaveSet
  // TODO(edufolly): toSaveListMapId
  // TODO(edufolly): toSaveList
}
