import 'package:flutter/foundation.dart';
import 'package:folly_fields/util/folly_num_extension.dart';

///
///
///
@immutable
class Range {
  final int _first;
  final int _last;

  ///
  ///
  ///
  const Range(int first, int last)
      : assert(last >= first, 'First must be less than or equal to last'),
        _first = first,
        _last = last;

  ///
  ///
  ///
  const Range.exclusive(int first, int last) : this(first, last - 1);

  ///
  ///
  ///
  int get first => _first;

  ///
  ///
  ///
  int get last => _last;

  ///
  ///
  ///
  int get length => _last - _first + 1;

  ///
  ///
  ///
  bool contains(int value) => value >= _first && value <= _last;

  ///
  ///
  ///
  List<int> toList() => List<int>.generate(length, (int i) => _first + i);

  ///
  ///
  ///
  @override
  String toString() => 'Range($_first, $_last)';

  ///
  ///
  ///
  @override
  int get hashCode => '$_first$_last'.hashCode;

  ///
  ///
  ///
  @override
  bool operator ==(Object other) =>
      other is Range && _first == other._first && _last == other._last;

  ///
  ///
  ///
  Range copyWith({int? first, int? last}) =>
      Range(first ?? _first, last ?? _last);

  ///
  ///
  ///
  bool intersects(Range other) =>
      _first <= other._last && _last >= other._first;

  ///
  ///
  ///
  Range operator +(Range other) =>
      Range(_first.min(other.first), _last.max(other.last));
}
