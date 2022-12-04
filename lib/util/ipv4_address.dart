///
///
///
class Ipv4Address {
  final int oc1;
  final int oc2;
  final int oc3;
  final int oc4;

  ///
  ///
  ///
  const Ipv4Address(this.oc1, this.oc2, this.oc3, this.oc4);

  ///
  ///
  ///
  @override
  String toString() => '$oc1.$oc2.$oc3.$oc4';
}
