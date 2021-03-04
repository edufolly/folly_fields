

import 'package:folly_fields/util/hashable.dart';

///
///
///
abstract class AbstractModel with Hashable {
  int? id;
  int? updatedAt;
  int? deletedAt;
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
  AbstractModel fromMulti(Map<String, dynamic> map);

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
  /// Teste de exclusão de quando as entidades ainda não possuem id.
  /// Anteriormente o cálculo do hash estava com uma divergência, mas agora
  /// faremos novos testes para não precisar desse operador.
  ///
  /// Ocorreu um novo problema com a comparação dos objetos do menu.
  @override
  bool operator ==(dynamic other) => hashCode == other.hashCode;

  ///
  ///
  ///
  String get searchTerm;

  static Map<String, dynamic> fromMultiMap(Map<String, dynamic> map) {
    Map<String, dynamic> newMap = <String, dynamic>{};
    for (MapEntry<String, dynamic> entry in map.entries) {
      _multiMapEntry(entry, newMap);
    }
    return newMap;
  }

  ///
  ///
  ///
  static void _multiMapEntry(
    MapEntry<String, dynamic> entry,
    Map<String, dynamic> newMap,
  ) {
    List<String> parts = entry.key.split('_');
    if (parts.length > 1) {
      Map<String, dynamic> internalMap;
      if (newMap.containsKey(parts[0])) {
        internalMap = newMap[parts[0]];
      } else {
        internalMap = <String, dynamic>{};
      }

      String internalKey = parts.getRange(1, parts.length).join('_');

      _multiMapEntry(
        MapEntry<String, dynamic>(internalKey, entry.value),
        internalMap,
      );

      newMap[parts[0]] = internalMap;
    } else {
      newMap[entry.key] = entry.value;
    }
  }
}
