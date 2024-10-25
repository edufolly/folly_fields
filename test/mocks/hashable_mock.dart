import 'package:flutter/foundation.dart';
import 'package:folly_fields/util/hashable.dart';

///
///
///
@immutable
class HashableObjectMock with Hashable {
  final String name = 'name';
  final int age = 20;
  final List<String> stringList = <String>['A'];
  final Map<String, String> stringMap = <String, String>{'A': 'a'};
  final bool boolean = true;
  final Object? nullObject = null;

  ///
  ///
  ///
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['age'] = age;
    map['stringList'] = stringList;
    map['stringMap'] = stringMap;
    map['boolean'] = boolean;
    map['nullObject'] = nullObject;

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

///
///
///
@immutable
class HashableIterableMock<T> with Hashable {
  final Iterable<T?> iterable;

  ///
  ///
  ///
  HashableIterableMock(this.iterable);

  ///
  ///
  ///
  @override
  int get hashCode => hashIterable(iterable);

  ///
  ///
  ///
  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  ///
  ///
  ///
  @override
  String toString() => iterable.toString();
}
