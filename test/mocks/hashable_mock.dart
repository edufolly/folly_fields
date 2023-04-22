// ignore_for_file: avoid-top-level-members-in-tests

import 'package:folly_fields/util/hashable.dart';

///
///
///
class HashableMock with Hashable {
  String name = 'name';
  int age = 20;
  List<String> stringList = <String>['A'];
  Map<String, String> stringMap = <String, String>{'A': 'a'};

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['age'] = age;
    map['stringList'] = stringList;
    map['stringMap'] = stringMap;

    return map;
  }

  ///
  ///
  ///
  @override
  int get hashCode => hashIterable(toMap().values);

  ///
  ///
  ///
  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}
