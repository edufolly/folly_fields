///
///
///
class Ipv4Address {
  final int _ip;

  ///
  ///
  ///
  Ipv4Address(int ip) : _ip = ip;

  ///
  ///
  ///
  Ipv4Address.fromDecimals(int oc1, int oc2, int oc3, int oc4)
      : assert(
          oc1 >= 0 && oc1 <= 255,
          'First octet must be between 0 and 255',
        ),
        assert(
          oc2 >= 0 && oc2 <= 255,
          'Second octet must be between 0 and 255',
        ),
        assert(
          oc3 >= 0 && oc3 <= 255,
          'Third octet must be between 0 and 255',
        ),
        assert(
          oc4 >= 0 && oc4 <= 255,
          'Fourth octet must be between 0 and 255',
        ),
        _ip = (oc1 << 24) + (oc2 << 16) + (oc3 << 8) + oc4;

  ///
  ///
  ///
  int get dot1 => _ip >> 24 & 0xFF;

  ///
  ///
  ///
  int get dot2 => (_ip >> 16) & 0xFF;

  ///
  ///
  ///
  int get dot3 => (_ip >> 8) & 0xFF;

  ///
  ///
  ///
  int get dot4 => _ip & 0xFF;

  ///
  ///
  ///
  int get integer => _ip;

  ///
  ///
  ///
  @override
  String toString() => '$dot1.$dot2.$dot3.$dot4';

  ///
  ///
  ///
  String get dash => '$dot1-$dot2-$dot3-$dot4';

  ///
  ///
  ///
  // ignore: prefer_constructors_over_static_methods
  static Ipv4Address fromString(String? value) {
    if (value == null || value.isEmpty) {
      throw ArgumentError('invalidIpAddress');
    }

    List<String> parts = value.split('.');

    if (parts.length != 4) {
      throw ArgumentError('invalidIpAddress');
    }

    List<int> ocs = <int>[];

    for (final String part in parts) {
      int? oc = int.tryParse(part);
      if (oc == null || oc < 0 || oc > 255) {
        throw ArgumentError('invalidIpAddress');
      }
      ocs.add(oc);
    }

    return Ipv4Address.fromDecimals(ocs[0], ocs[1], ocs[2], ocs[3]);
  }

  ///
  ///
  ///
  static Ipv4Address fromList(List<dynamic> value) =>
      fromString(value.join('.'));

  ///
  ///
  ///
  @override
  int get hashCode => _ip;

  ///
  ///
  ///
  @override
  bool operator ==(Object other) =>
      other is Ipv4Address && _ip == other.integer;

  ///
  ///
  ///
  Ipv4Address operator +(int value) {
    int newValue = _ip + value;
    if (newValue > 4294967295) {
      throw ArgumentError('invalidIpAddress');
    }
    return Ipv4Address(newValue);
  }

  ///
  ///
  ///
  Ipv4Address operator -(int value) {
    int newValue = _ip - value;
    if (newValue < 0) {
      throw ArgumentError('invalidIpAddress');
    }
    return Ipv4Address(newValue);
  }

  ///
  ///
  ///
  bool operator >(Ipv4Address value) => _ip > value.integer;

  ///
  ///
  ///
  bool operator <(Ipv4Address value) => _ip < value.integer;

  ///
  ///
  ///
  bool operator >=(Ipv4Address value) => _ip >= value.integer;

  ///
  ///
  ///
  bool operator <=(Ipv4Address value) => _ip <= value.integer;
}
