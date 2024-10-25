import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class MockStringModel extends AbstractModel<String> {
  String? name;
  int? age;

  ///
  ///
  ///
  MockStringModel({super.id, this.name, this.age}) : super();

  ///
  ///
  ///
  MockStringModel.fromJson(super.map)
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
  static final Map<Map<String, dynamic>, MockStringModel> baseDomain =
      <Map<String, dynamic>, MockStringModel>{
    <String, dynamic>{}: MockStringModel(),
    <String, dynamic>{'id': 'abc'}: MockStringModel(id: 'abc'),
    <String, dynamic>{'name': 'aline'}: MockStringModel(name: 'aline'),
    <String, dynamic>{'age': 20}: MockStringModel(age: 20),
    <String, dynamic>{'name': 'aline', 'age': 20}:
        MockStringModel(name: 'aline', age: 20),
    <String, dynamic>{'name': 20, 'age': '20'}:
        MockStringModel(name: '20', age: 20),
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
  static final MockStringModel alineModel =
      MockStringModel(id: 'abc', name: 'aline', age: 20);

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
  static final MockStringModel kateModel =
      MockStringModel(id: 'cde', name: 'kate', age: 28);
}
