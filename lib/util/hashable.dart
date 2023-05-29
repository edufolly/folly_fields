// ignore_for_file: binary-expression-operand-order

///
///
///
mixin Hashable {
  ///
  ///
  ///
  int hashIterable(
    Iterable<dynamic> iterable,
    // { int deep = 1,
    // bool debug = false,}
  ) {
    final int iterated = iterable.fold(
      0,
      (int h, dynamic i) {
        int hash;
        if (i is List) {
          // hash = hashIterable(i, deep: deep + 1, debug: debug);
          hash = hashIterable(i);
        } else if (i is Map) {
          // hash = hashIterable(i.values, deep: deep + 1, debug: debug);
          hash = hashIterable(i.values);
        } else if (i == null) {
          hash = 0;
        } else {
          hash = i.hashCode;
        }

        // int comb = combine(h, hash);
        //
        // if (debug) {
        //   if (kDebugMode) {
        //     print('${' ' * deep * 2}h: $h => '
        //         '(${i.runtimeType}) $i: $hash => comb: $comb');
        //   }
        // }
        //
        // return comb;

        return combine(h, hash);
      },
    );

    // int finished = finish(iterated);
    //
    // if (debug) {
    //   if (kDebugMode) {
    //     print('finish: $finished');
    //   }
    // }
    //
    // return finished;
    return finish(iterated);
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
