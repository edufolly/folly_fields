///
///
///
class StringUtils {
  ///
  ///
  ///
  static bool isPascalCase(String value) =>
      !(value.isEmpty ||
          value.contains(RegExp('[^a-zA-Z0-9]+')) ||
          value.startsWith(RegExp('[0-9]+'))) &&
      value[0].toUpperCase() == value[0];

  ///
  ///
  ///
  static bool isCamelCase(String value) =>
      !(value.isEmpty ||
          value.contains(RegExp('[^a-zA-Z0-9]+')) ||
          value.startsWith(RegExp('[0-9]+'))) &&
      value[0].toLowerCase() == value[0];

  ///
  ///
  ///
  static bool isSnakeCase(String value) => !(value.isEmpty ||
      value.contains(RegExp('[^_a-z0-9]+')) ||
      value.startsWith(RegExp('[0-9]+')));

  ///
  ///
  ///
  static String camel2Snake(String camel, [bool internal = false]) =>
      internal || isCamelCase(camel)
          ? camel.splitMapJoin(
              (RegExp(r'[A-Z]')),
              onMatch: (Match m) => '_${m.group(0)!.toLowerCase()}',
              onNonMatch: (String n) => n,
            )
          : '';

  ///
  ///
  ///
  static String snake2Camel(String snake) =>
      isSnakeCase(snake) ? pascal2Camel(snake2Pascal(snake, true), true) : '';

  ///
  ///
  ///
  static String pascal2Camel(String pascal, [bool internal = false]) =>
      internal || isPascalCase(pascal)
          ? pascal[0].toLowerCase() + pascal.substring(1)
          : '';

  ///
  ///
  ///
  static String camel2Pascal(String camel) =>
      isCamelCase(camel) ? camel[0].toUpperCase() + camel.substring(1) : '';

  ///
  ///
  ///
  static String pascal2Snake(String pascal) =>
      isPascalCase(pascal) ? camel2Snake(pascal, true).substring(1) : '';

  ///
  ///
  ///
  static String snake2Pascal(String snake, [bool internal = false]) =>
      internal || isSnakeCase(snake)
          ? snake.toLowerCase().splitMapJoin(
                (RegExp(r'_')),
                onMatch: (Match m) => '',
                onNonMatch: (String n) =>
                    n.substring(0, 1).toUpperCase() + n.substring(1),
              )
          : '';
}
