void cartesianProductGenerate(
  final List<Map<dynamic, bool>> domain,
  final void Function(List<dynamic> data, {required bool result}) runTest, {
  final List<dynamic> data = const <dynamic>[],
  final int depth = 0,
  final bool result = true,
}) {
  for (int i = 0; i < domain[depth].length; i++) {
    MapEntry<dynamic, bool> entry = domain[depth].entries.toList()[i];
    if (depth == domain.length - 1) {
      runTest(<dynamic>[...data, entry.key], result: result && entry.value);
    } else {
      cartesianProductGenerate(
        domain,
        runTest,
        data: <dynamic>[...data, entry.key],
        depth: depth + 1,
        result: result && entry.value,
      );
    }
  }
}
