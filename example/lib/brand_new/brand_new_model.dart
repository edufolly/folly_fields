import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class BrandNewModel extends AbstractModel<int> {
  String name = '';

  ///
  ///
  ///
  BrandNewModel();

  ///
  ///
  ///
  BrandNewModel.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        super.fromJson(map);

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['name'] = name;
    return map;
  }

  ///
  ///
  ///
  @override
  String get searchTerm => name;

  ///
  ///
  ///
  @override
  String toString() => name;
}
