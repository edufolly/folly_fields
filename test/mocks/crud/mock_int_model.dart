import 'package:folly_fields/crud/abstract_model.dart';

///
///
///
class MockIntModel extends AbstractModel<int> {
  String? name;
  int? age;

  ///
  ///
  ///
  MockIntModel({super.id, this.name, this.age}) : super();

  ///
  ///
  ///
  MockIntModel.fromJson(super.map)
      : name = map['name']?.toString(),
        age = int.tryParse(map['age'].toString()),
        super.fromJson();

  ///
  ///
  ///
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = super.toMap();
    map['name'] = name;
    map['age'] = age;

    return map;
  }

  ///
  ///
  ///
  static final Map<Map<String, dynamic>, MockIntModel> baseDomain =
      <Map<String, dynamic>, MockIntModel>{
    <String, dynamic>{}: MockIntModel(),
    <String, dynamic>{'id': 1}: MockIntModel(id: 1),
    <String, dynamic>{'name': 'aline'}: MockIntModel(name: 'aline'),
    <String, dynamic>{'age': 20}: MockIntModel(age: 20),
    <String, dynamic>{'name': 'aline', 'age': 20}:
        MockIntModel(name: 'aline', age: 20),
    <String, dynamic>{'name': 20, 'age': '20'}:
        MockIntModel(name: '20', age: 20),
    alineMap: alineModel,
    kateMap: kateModel,
  };

  ///
  ///
  ///
  static final Map<String, dynamic> alineMap = <String, dynamic>{
    'id': 1,
    'name': 'aline',
    'age': 20,
  };

  ///
  ///
  ///
  static final MockIntModel alineModel =
      MockIntModel(id: 1, name: 'aline', age: 20);

  ///
  ///
  ///
  static final Map<String, dynamic> kateMap = <String, dynamic>{
    'id': 2,
    'name': 'kate',
    'age': 28,
  };

  ///
  ///
  ///
  static final MockIntModel kateModel =
      MockIntModel(id: 2, name: 'kate', age: 28);
}
