extension ListExtension<T> on List<T> {
  List<T> intersperse(T item) =>
      expand((T e) => <T>[e, item]).toList()..removeLast();
}
