// ignore_for_file: avoid-top-level-members-in-tests

import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class MockModel extends AbstractModel<String> {
  String? name;
  int? age;

  ///
  ///
  ///
  MockModel({super.id, this.name, this.age}) : super();

  ///
  ///
  ///
  MockModel.fromJson(super.map)
      : name = map['name']?.toString(),
        age = int.tryParse(map['age'].toString()),
        super.fromJson();

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();
    map['name'] = name;
    map['age'] = age;

    return map;
  }
}
