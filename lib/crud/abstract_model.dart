// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:flutter/widgets.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/hashable.dart';

///
///
///
abstract class AbstractModel<A> with Hashable {
  A? id;
  int? updatedAt;
  int? deletedAt;
  bool selected = false;

  ///
  ///
  ///
  AbstractModel({
    this.id,
    this.updatedAt,
    this.deletedAt,
    this.selected = false,
  });

  ///
  ///
  ///
  String get modelIdKey => FollyFields().modelIdKey;

  ///
  ///
  ///
  String get modelUpdatedAtKey => FollyFields().modelUpdatedAtKey;

  ///
  ///
  ///
  String get modelDeletedAtKey => FollyFields().modelDeletedAtKey;

  ///
  ///
  ///
  FollyDateParse? get dateParseUpdate => FollyFields().dateParseUpdate;

  ///
  ///
  ///
  FollyDateParse? get dateParseDelete => FollyFields().dateParseDelete;

  ///
  ///
  ///
  AbstractModel.fromJson(Map<String, dynamic> map) {
    id = map[modelIdKey];

    if (map.containsKey(modelUpdatedAtKey)) {
      updatedAt = dateParseUpdate != null
          ? dateParseUpdate!(map[modelUpdatedAtKey])
          : map[modelUpdatedAtKey];
    }

    if (map.containsKey(modelDeletedAtKey)) {
      deletedAt = dateParseDelete != null
          ? dateParseDelete!(map[modelDeletedAtKey])
          : map[modelDeletedAtKey];
    }
  }

  ///
  ///
  ///
  @mustCallSuper
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) {
      map[modelIdKey] = id;
    }

    return map;
  }

  ///
  ///
  ///
  Map<String, dynamic> toSave() => toMap();

  ///
  ///
  ///
  @override
  int get hashCode => hashIterable(toMap().values);

  ///
  ///
  ///
  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  ///
  ///
  ///
  String get listSearchTerm => toString();

  ///
  ///
  ///
  String get dropdownText => toString();

  ///
  ///
  ///
  static Map<String, dynamic> fromMultiMap(Map<String, dynamic> map) {
    Map<String, dynamic> newMap = <String, dynamic>{};
    for (final MapEntry<String, dynamic> entry in map.entries) {
      _multiMapEntry(entry, newMap);
    }

    return newMap;
  }

  ///
  ///
  ///
  static void _multiMapEntry(
    MapEntry<String, dynamic> entry,
    Map<String, dynamic> newMap,
  ) {
    List<String> parts = entry.key.split('_');
    if (parts.length > 1 && parts.first.isNotEmpty) {
      Map<String, dynamic> internalMap;

      internalMap = newMap.containsKey(parts.first)
          ? newMap[parts.first]
          : <String, dynamic>{};

      String internalKey = parts.getRange(1, parts.length).join('_');

      _multiMapEntry(
        MapEntry<String, dynamic>(internalKey, entry.value),
        internalMap,
      );

      newMap[parts.first] = internalMap;
    } else {
      newMap[entry.key] = entry.value;
    }
  }
}
