import 'package:flutter/widgets.dart';
import 'package:folly_fields/folly_fields.dart';
import 'package:folly_fields/util/hashable.dart';

///
///
///
abstract class AbstractModel<A> with Hashable {
  static final String modelIdKey = FollyFields().modelIdKey;
  static final String modelUpdatedAtKey = FollyFields().modelUpdatedAtKey;
  static final String modelDeletedAtKey = FollyFields().modelDeletedAtKey;
  static final FollyDateParse? dateParseUpdate = FollyFields().dateParseUpdate;
  static final FollyDateParse? dateParseDelete = FollyFields().dateParseDelete;

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
    for (MapEntry<String, dynamic> entry in map.entries) {
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
      if (newMap.containsKey(parts[0])) {
        internalMap = newMap[parts[0]];
      } else {
        internalMap = <String, dynamic>{};
      }

      String internalKey = parts.getRange(1, parts.length).join('_');

      _multiMapEntry(
        MapEntry<String, dynamic>(internalKey, entry.value),
        internalMap,
      );

      newMap[parts[0]] = internalMap;
    } else {
      newMap[entry.key] = entry.value;
    }
  }
}
