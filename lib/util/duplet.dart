///
///
///
@Deprecated('Use Dart record.')
// TODO(edufolly): Remove in version 1.1.0
class Duplet<A, B> {
  final A a;
  final B b;

  ///
  ///
  ///
  @Deprecated('Use Dart record.')
  // TODO(edufolly): Remove in version 1.1.0
  const Duplet(this.a, this.b);

  ///
  ///
  ///
  @override
  String toString() => '$a => $b';
}

///
///
///
@Deprecated('Use Dart record.')
// TODO(edufolly): Remove in version 1.1.0
class Triplet<A, B, C> extends Duplet<A, B> {
  final C c;

  ///
  ///
  ///
  @Deprecated('Use Dart record.')
  // TODO(edufolly): Remove in version 1.1.0
  const Triplet(super.a, super.b, this.c);

  ///
  ///
  ///
  @override
  String toString() => '${super.toString()} => $c';
}
