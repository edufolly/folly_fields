import 'package:flutter/foundation.dart';

@immutable
class Ipv4Address {
  final int _ip;

  const Ipv4Address(int ip) : _ip = ip;

  const Ipv4Address.fromDecimals(int oc1, int oc2, int oc3, int oc4)
    : assert(oc1 >= 0 && oc1 <= 255, 'First octet must be between 0 and 255'),
      assert(oc2 >= 0 && oc2 <= 255, 'Second octet must be between 0 and 255'),
      assert(oc3 >= 0 && oc3 <= 255, 'Third octet must be between 0 and 255'),
      assert(oc4 >= 0 && oc4 <= 255, 'Fourth octet must be between 0 and 255'),
      _ip = (oc1 << 24) + (oc2 << 16) + (oc3 << 8) + oc4;

  // TODO(edufolly): Refactor this code!
  factory Ipv4Address.fromList(List<dynamic> list, {String separator = '.'}) {
    if (list.length != 4) {
      throw ArgumentError('invalidIpAddress');
    }

    return Ipv4Address.fromString(list.join(separator), separator: separator);
  }

  // TODO(edufolly): Refactor this code!
  factory Ipv4Address.fromString(String? value, {String separator = '.'}) {
    if (value == null || value.isEmpty) {
      throw ArgumentError('invalidIpAddress');
    }

    List<String> parts = value.split(separator);

    if (parts.length != 4) {
      throw ArgumentError('invalidIpAddress');
    }

    List<int> ocs = <int>[];

    for (final String part in parts) {
      int? octet = int.tryParse(part);
      if (octet == null || octet < 0 || octet > 255) {
        throw ArgumentError('invalidIpAddress');
      }
      ocs.add(octet);
    }

    return Ipv4Address.fromDecimals(ocs[0], ocs[1], ocs[2], ocs[3]);
  }

  int get dot1 => _ip >> 24 & 0xFF;

  int get dot2 => (_ip >> 16) & 0xFF;

  int get dot3 => (_ip >> 8) & 0xFF;

  int get dot4 => _ip & 0xFF;

  int get integer => _ip;

  @override
  String toString({String separator = '.'}) =>
      <int>[dot1, dot2, dot3, dot4].join(separator);

  @override
  int get hashCode => _ip;

  @override
  bool operator ==(Object other) =>
      other is Ipv4Address && _ip == other.integer;

  Ipv4Address operator +(int value) {
    int newValue = _ip + value;
    if (newValue > 4294967295) {
      throw ArgumentError('invalidIpAddress');
    }

    return Ipv4Address(newValue);
  }

  Ipv4Address operator -(int value) {
    int newValue = _ip - value;
    if (newValue < 0) {
      throw ArgumentError('invalidIpAddress');
    }

    return Ipv4Address(newValue);
  }

  bool operator >(Ipv4Address value) => _ip > value.integer;

  bool operator <(Ipv4Address value) => _ip < value.integer;

  bool operator >=(Ipv4Address value) => _ip >= value.integer;

  bool operator <=(Ipv4Address value) => _ip <= value.integer;
}
