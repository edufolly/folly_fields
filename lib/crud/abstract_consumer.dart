import 'package:flutter/cupertino.dart';
import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
abstract class AbstractConsumer<T extends AbstractModel> {
  ///
  ///
  ///
  List<String> get routeName;

  ///
  ///
  ///
  T get modelInstance;

  ///
  ///
  ///
  String get offlineTableName => null;

  ///
  ///
  ///
  String get offlineWhere => null;

  ///
  ///
  ///
  List<dynamic> get offlineWhereArgs => null;

  ///
  ///
  ///
  String get offlineOrderBy => 'id';

  ///
  ///
  ///
  Future<ConsumerPermission> checkPermission(
    BuildContext context, {
    List<String> paths,
    bool returnLog = false,
  });

  ///
  ///
  ///
  Future<List<T>> list(
    BuildContext context, {
    bool forceOffline = false,
    Map<String, String> qsParam,
    bool returnLog = false,
  });

  ///
  ///
  ///
  Future<Map<T, String>> dropdownMap(
    BuildContext context, {
    Map<String, String> qsParam,
  }) async {
    List<T> _list = await list(
      context,
      forceOffline: false,
      qsParam: qsParam,
    );
    return <T, String>{for (T e in _list) e: e.toString()};
  }

  ///
  ///
  ///
  Future<T> delete(
    BuildContext context,
    T model, {
    bool returnLog = false,
  });

  ///
  ///
  ///
  Future<T> getById(
    BuildContext context,
    T model, {
    bool returnLog = false,
  });

  ///
  ///
  ///
  Future<bool> saveOrUpdate(
    BuildContext context,
    T model, {
    bool returnLog = false,
  });
}

///
///
///
@immutable
class ConsumerPermission {
  final bool insert;
  final bool update;
  final bool delete;
  final String iconName;
  final String name;

  ///
  ///
  ///
  const ConsumerPermission({
    this.insert = false,
    this.update = false,
    this.delete = false,
    this.iconName = 'solidCircle',
    this.name,
  });
}
