extension IterableEnumExtension<T extends Enum> on Iterable<T> {
  T byNameOrDefault(final String? name, {required final T defaultValue}) =>
      byNameOrNull(name) ?? defaultValue;

  T? byNameOrNull(final String? name) {
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
