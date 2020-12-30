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
  bool get returnLog => false;

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
    BuildContext context,
    Map<String, String> qsParam,
    bool forceOffline,
  );

  ///
  ///
  ///
  Future<Map<T, String>> dropdownMap(
    BuildContext context,
    Map<String, String> qsParam,
  ) async {
    List<T> _list = await list(context, qsParam, false);
    return <T, String>{for (T e in _list) e: e.toString()};
  }

  ///
  ///
  ///
  Future<bool> delete(
    BuildContext context,
    T model,
  );

  ///
  ///
  ///
  Future<T> getById(
    BuildContext context,
    T model,
  );

  ///
  ///
  ///
  Future<bool> saveOrUpdate(
    BuildContext context,
    T model,
  );
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
    this.name,
  });

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
        name = map['name'];

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
