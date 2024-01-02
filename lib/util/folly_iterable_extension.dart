///
///
///
extension FollyIterableExtension<T extends Enum> on Iterable<T> {
  ///
  ///
  ///
  T byNameOrDefault(
    String? name, {
    required T defaultValue,
  }) {
    if (name == null) {
      return defaultValue;
    }

    for (final T value in this) {
      if (value.name == name) {
        return value;
      }
    }

    return defaultValue;
  }
}
