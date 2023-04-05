import 'dart:math';

import 'package:flutter/foundation.dart';

///
///
///
// TODO(edufolly): Remove in version 1.0.0.
@Deprecated('This class will be removed in version 1.0.0.')
abstract class AbstractEnumParser<T extends Enum> {
  final T defaultItem;

  ///
  ///
  ///
  // TODO(edufolly): Remove in version 1.0.0.
  @Deprecated('This class will be removed in version 1.0.0.')
  @mustCallSuper
  const AbstractEnumParser({
    required this.defaultItem,
  });

  ///
  ///
  ///
  Map<T, String> get items;

  ///
  ///
  ///
  T fromJson(String? value) => value == null
      ? defaultItem
      : items.keys.firstWhere(
          (T key) => toMap(key) == value,
          orElse: () => defaultItem,
        );

  ///
  ///
  ///
  int get length => items.length;

  ///
  ///
  ///
  String toMap(T key) => key.toString().split('.').last;

  ///
  ///
  ///
  String getText(T key) => items[key]!;

  ///
  ///
  ///
  T get random => items.keys.elementAt(Random().nextInt(length));
}
