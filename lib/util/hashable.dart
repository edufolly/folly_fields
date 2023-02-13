import 'package:flutter/foundation.dart';

///
///
///
abstract class Hashable {
  ///
  ///
  ///
  int hashIterable(
    Iterable<dynamic> iterable, {
    int deep = 1,
    bool debug = false,
  }) {
    int it = iterable.fold(
      0,
      (int h, dynamic i) {
        int hash;
        if (i is List) {
          hash = hashIterable(i, deep: deep + 1, debug: debug);
        } else if (i is Map) {
          hash = hashIterable(i.values, deep: deep + 1, debug: debug);
        } else if (i == null) {
          hash = 0;
        } else {
          hash = i.hashCode;
        }

        int c = combine(h, hash);

        if (debug) {
          if (kDebugMode) {
            print('${' ' * deep * 2}h: $h => '
                '(${i.runtimeType}) $i: $hash => c: $c');
          }
        }
        return c;
      },
    );

    int f = finish(it);

    if (debug) {
      if (kDebugMode) {
        print('finish: $f');
      }
    }

    return f;
  }

  ///
  ///
  ///
  int combine(int hash, int value) {
    hash = 0x1fffffff & (hash + value);
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  ///
  ///
  ///
  int finish(int hash) {
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}
