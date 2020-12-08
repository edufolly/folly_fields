///
///
///
abstract class AbstractModel {
  int id;
  int updatedAt;

  ///
  ///
  ///
  AbstractModel();

  ///
  ///
  ///
  AbstractModel.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        updatedAt = map['updatedAt'];

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
  int get hashCode => _hashIterable(toMap().values);

  ///
  ///
  ///
  int _hashIterable(Iterable<dynamic> iterable) => _finish(
        iterable.fold(
          0,
          (int h, dynamic i) {
            int hash;
            if (i is List) {
              hash = _hashIterable(i);
            } else if (i is Map) {
              hash = _hashIterable(i.values);
            } else {
              hash = i.hashCode;
            }
            return _combine(h, hash);
          },
        ),
      );

  ///
  ///
  ///
  int _combine(int hash, int value) {
    hash = 0x1fffffff & (hash + value);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  ///
  ///
  ///
  int _finish(int hash) {
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }

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
