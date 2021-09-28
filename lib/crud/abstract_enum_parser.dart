///
///
///
abstract class AbstractEnumParser<T extends Enum> {
  ///
  ///
  ///
  T get defaultItem;

  ///
  ///
  ///
  Map<T, String> get items;

  ///
  ///
  ///
  T fromJson(String? value) => value == null
      ? defaultItem
      : items.keys.firstWhere(
          (T key) => toMap(key) == value,
          orElse: () => defaultItem,
        );

  ///
  ///
  ///
  String toMap(T key) => key.toString().split('.').last;

  ///
  ///
  ///
  String getText(T key) => items[key]!;
}
