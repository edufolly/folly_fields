extension IterableEnumExtension<T extends Enum> on Iterable<T> {
  T byNameOrDefault(String? name, {required T defaultValue}) =>
      byNameOrNull(name) ?? defaultValue;

  T? byNameOrNull(String? name) {
    if (name == null) return null;

    for (final T value in this) {
      if (value.name == name) return value;
    }

    return null;
  }
}
