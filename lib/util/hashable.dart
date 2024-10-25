import 'package:flutter/foundation.dart';

///
///
///
mixin Hashable {
  ///
  ///
  ///
  int hashIterable(
    Iterable<dynamic> iterable, {
    int deep = 0,
    bool debug = false,
  }) {
    int iterated = iterable.fold(
      -1,
      (int h, dynamic i) {
        int hash;
        if (i is List) {
          hash = hashIterable(i, deep: deep + 1, debug: debug);
        } else if (i is Map) {
          hash = hashIterable(i.values, deep: deep + 1, debug: debug);
        } else if (i == null) {
          hash = -2;
        } else {
          hash = i.hashCode;
        }

        int comb = combine(h, hash);

        if (kDebugMode) {
          if (debug) {
            print('${' ' * deep * 2}h: $h => '
                '(${i.runtimeType}) $i: $hash => comb: $comb');
          }
        }

        return comb;
      },
    );

    int finished = finish(iterated);

    if (kDebugMode) {
      if (debug) {
        print('finish: $finished');
      }
    }

    return finished;
  }

  ///
  ///
  ///
  int combine(int hash, int value) {
    int h = 0x1fffffff & (hash + value);
    h = 0x1fffffff & (h + ((0x0007ffff & h) << 10));

    return h ^ (h >> 6);
  }

  ///
  ///
  ///
  int finish(int hash) {
    int h = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    h = h ^ (h >> 11);

    return 0x1fffffff & (h + ((0x00003fff & h) << 15));
  }
}
