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

  ///
  ///
  ///
  static final Map<Map<String, dynamic>, MockModel> baseDomain =
      <Map<String, dynamic>, MockModel>{
    <String, dynamic>{}: MockModel(),
    <String, dynamic>{'id': 'abc'}: MockModel(id: 'abc'),
    <String, dynamic>{'name': 'aline'}: MockModel(name: 'aline'),
    <String, dynamic>{'age': 20}: MockModel(age: 20),
    <String, dynamic>{'name': 'aline', 'age': 20}:
        MockModel(name: 'aline', age: 20),
    <String, dynamic>{'name': 20, 'age': '20'}: MockModel(name: '20', age: 20),
    alineMap: alineModel,
    kateMap: kateModel,
  };

  ///
  ///
  ///
  static final Map<String, dynamic> alineMap = <String, dynamic>{
    'id': 'abc',
    'name': 'aline',
    'age': 20,
  };

  ///
  ///
  ///
  static final MockModel alineModel =
      MockModel(id: 'abc', name: 'aline', age: 20);

  ///
  ///
  ///
  static final Map<String, dynamic> kateMap = <String, dynamic>{
    'id': 'cde',
    'name': 'kate',
    'age': 28,
  };

  ///
  ///
  ///
  static final MockModel kateModel =
      MockModel(id: 'cde', name: 'kate', age: 28);
}
