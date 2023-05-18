///
///
///
class Duplet<A, B> {
  final A a;
  final B b;

  ///
  /// 
  /// 
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
class Triplet<A,B,C> extends Duplet<A,B> {
  final C c;

  ///
  ///
  ///
  const Triplet(super.a, super.b, this.c);

  ///
  /// 
  /// 
  @override
  String toString() => '${super.toString()} => $c';

}
