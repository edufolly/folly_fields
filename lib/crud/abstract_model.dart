import 'package:folly_fields/util/hashable.dart';

///
///
///
abstract class AbstractModel with Hashable {
  int id;
  int updatedAt;
  int deletedAt;
  bool selected = false;

  ///
  ///
  ///
  AbstractModel();

  ///
  ///
  ///
  AbstractModel.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        updatedAt = map['updatedAt'],
        deletedAt = map['deletedAt'];

  ///
  ///
  ///
  AbstractModel fromJson(Map<String, dynamic> map);

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) map['id'] = id;
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
  bool operator ==(dynamic other) => (id ?? -1) == (other.id ?? -2);

  ///
  ///
  ///
  String get searchTerm;
}
