// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/cupertino.dart';
import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
@immutable
abstract class AbstractConsumer<T extends AbstractModel<ID>, ID> {
  final List<String> routeName;
  final String? offlineTableName;
  final String? offlineWhere;
  final List<dynamic>? offlineWhereArgs;
  final String offlineOrderBy;
  final String? offlineTerms;
  final bool returnLog;

  ///
  ///
  ///
  const AbstractConsumer(
    this.routeName, {
    this.offlineTableName,
    this.offlineWhere,
    this.offlineWhereArgs,
    this.offlineOrderBy = 'id',
    this.offlineTerms,
    this.returnLog = false,
  });

  ///
  ///
  ///
  T fromJson(Map<String, dynamic> map);

  ///
  ///
  ///
  ID? idFrom(dynamic value) => switch (ID) {
        String => value?.toString(),
        int => int.tryParse(value.toString()),
        _ => throw UnsupportedError('Type $ID not supported in idFrom')
      } as ID?;

  ///
  ///
  ///
  Future<ConsumerPermission> checkPermission(
    BuildContext context,
    List<String> paths,
  );

  ///
  ///
  ///
  Future<List<T>> list(
    BuildContext context, {
    // TODO(edufolly): @QueryParam("sort") List<String> sortQuery
    int page = 0,
    int size = 20,
    Map<String, String> extraParams = const <String, String>{},
    bool forceOffline = false,
  });

  ///
  ///
  ///
  Future<Map<T, String>> dropdownMap(
    BuildContext context, {
    int page = 0,
    int size = 20,
    Map<String, String> extraParams = const <String, String>{},
    bool forceOffline = false,
  }) async =>
      (await list(
        context,
        page: page,
        size: size,
        extraParams: extraParams,
        forceOffline: forceOffline,
      ))
          .asMap()
          .map((_, T item) => MapEntry<T, String>(item, item.dropdownText));

  ///
  ///
  ///
  Future<T?> getById(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  });

  ///
  ///
  ///
  Future<bool> beforeDelete(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async =>
      true;

  ///
  ///
  ///
  Future<bool> delete(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  });

  ///
  ///
  ///
  Future<bool> beforeSaveOrUpdate(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  }) async =>
      true;

  ///
  ///
  ///
  Future<T?> saveOrUpdate(
    BuildContext context,
    T model, {
    Map<String, String> extraParams = const <String, String>{},
  });
}

///
///
///
@immutable
class ConsumerPermission {
  final bool menu;
  final bool view;
  final bool insert;
  final bool update;
  final bool delete;
  final String iconName;
  final String name;

  ///
  ///
  ///
  const ConsumerPermission({
    this.menu = false,
    this.view = false,
    this.insert = false,
    this.update = false,
    this.delete = false,
    this.iconName = 'solidCircle',
    this.name = '',
  });

  ///
  ///
  ///
  const ConsumerPermission.allowAll({String? name, String? iconName})
      : menu = true,
        view = true,
        insert = true,
        update = true,
        delete = true,
        iconName = iconName ?? 'solidCircle',
        name = name ?? '';

  ///
  ///
  ///
  ConsumerPermission.fromJson(Map<String, dynamic> map)
      : menu = map['menu'] ?? false,
        view = map['view'] ?? false,
        insert = map['insert'] ?? false,
        update = map['update'] ?? false,
        delete = map['delete'] ?? false,
        iconName = map['iconName'] ?? 'solidCircle',
        name = map['name'] ?? '';

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'menu': menu,
      'view': view,
      'insert': insert,
      'update': update,
      'delete': delete,
      'iconName': iconName,
      'name': name,
    };
  }
}
