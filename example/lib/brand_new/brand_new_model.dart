import 'package:folly_fields/crud/abstract_model.dart';
import 'package:folly_fields_example/brand_new/brand_new_enum.dart';

///
///
///
class BrandNewModel extends AbstractModel<int> {
  static const BrandNewParser _brandNewParser = BrandNewParser();
  String name = '';
  BrandNewEnum type = _brandNewParser.defaultItem;
  String? specific1;
  String? specific2;
  String? specific3;

  ///
  ///
  ///
  BrandNewModel();

  ///
  ///
  ///
  BrandNewModel.fromJson(super.map)
      : name = map['name'],
        type = _brandNewParser.fromJson('type'),
        specific1 = map['specific1'],
        specific2 = map['specific2'],
        specific3 = map['specific3'],
        super.fromJson();

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['name'] = name;
    map['type'] = _brandNewParser.toMap(type);
    map['specific1'] = specific1;
    map['specific2'] = specific2;
    map['specific3'] = specific3;
    return map;
  }

  ///
  ///
  ///
  @override
  String toString() => name;
}
