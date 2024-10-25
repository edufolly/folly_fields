///
///
///
extension FollyIterableExtension<T> on Iterable<T?> {
  ///
  ///
  ///
  Iterable<T> get removeNulls => where((T? e) => e != null).map((T? e) => e!);
}

///
///
///
extension FollyIterableEnumExtension<T extends Enum> on Iterable<T> {
  ///
  ///
  ///
  T byNameOrDefault(
    String? name, {
    required T defaultValue,
  }) =>
      byNameOrNull(name) ?? defaultValue;

  ///
  ///
  ///
  T? byNameOrNull(
    String? name,
  ) {
    if (name == null) {
      return null;
    }

    for (final T value in this) {
      if (value.name == name) {
        return value;
      }
    }

    return null;
  }
}
