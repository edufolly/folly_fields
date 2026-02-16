extension ListExtension<T> on List<T> {
  List<T> intersperse(T item) =>
      expand((T e) => <T>[e, item]).toList()..removeLast();
}

bool isNullOrEmpty(Iterable<dynamic>? it) => it?.isEmpty ?? true;

bool isNotEmpty(Iterable<dynamic>? it) => it?.isNotEmpty ?? false;
