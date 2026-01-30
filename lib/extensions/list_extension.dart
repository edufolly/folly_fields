extension ListExtension<T> on List<T> {
  List<T> intersperse(final T item) =>
      expand((final T e) => <T>[e, item]).toList()..removeLast();
}

bool isNullOrEmpty(final Iterable<dynamic>? it) => it?.isEmpty ?? true;

bool isNotEmpty(final Iterable<dynamic>? it) => it?.isNotEmpty ?? false;
