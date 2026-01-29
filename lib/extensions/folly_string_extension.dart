extension FollyStringExtension on String {
  String repeat(int length) =>
      List<String>.generate(length, (_) => this).join();

  String get capitalize =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  String get capitalizeWords =>
      split(' ').map((String e) => e.capitalize).toList().join(' ');

  // TODO(edufolly): Add more characters.
  String get normalize => splitMapJoin(
    RegExp(r'[^a-zA-Z0-9\s]', caseSensitive: false),
    onMatch: (Match e) {
      return switch (e.group(0)) {
        'á' || 'à' || 'ã' || 'â' || 'ä' || 'å' => 'a',
        'Á' || 'À' || 'Ã' || 'Â' || 'Ä' || 'Å' => 'A',
        'é' || 'è' || 'ê' || 'ë' => 'e',
        'É' || 'È' || 'Ê' || 'Ë' => 'E',
        'í' || 'ì' || 'î' || 'ï' => 'i',
        'Í' || 'Ì' || 'Î' || 'Ï' => 'I',
        'ó' || 'ò' || 'õ' || 'ô' || 'ö' => 'o',
        'Ó' || 'Ò' || 'Õ' || 'Ô' || 'Ö' => 'O',
        'ú' || 'ù' || 'û' || 'ü' => 'u',
        'Ú' || 'Ù' || 'Û' || 'Ü' => 'U',
        'ç' => 'c',
        'Ç' => 'C',
        _ => e.group(0) ?? '',
      };
    },
    onNonMatch: (String e) => e,
  );

  bool get isPascalCase =>
      !(isEmpty ||
          contains(RegExp('[^a-zA-Z0-9]+')) ||
          startsWith(RegExp('[0-9]+'))) &&
      this[0].toUpperCase() == this[0];

  bool get isCamelCase =>
      !(isEmpty ||
          contains(RegExp('[^a-zA-Z0-9]+')) ||
          startsWith(RegExp('[0-9]+'))) &&
      this[0].toLowerCase() == this[0];

  bool get isSnakeCase =>
      !(isEmpty ||
          contains(RegExp('[^_a-z0-9]+')) ||
          startsWith(RegExp('[0-9]+')));

  String get _camel2Snake => splitMapJoin(
    RegExp('[A-Z]'),
    onMatch: (Match m) => '_${m.group(0)!.toLowerCase()}',
    onNonMatch: (String n) => n,
  );

  String get _snake2Pascal => toLowerCase().splitMapJoin(
    RegExp('_'),
    onMatch: (Match m) => '',
    onNonMatch: (String n) => n[0].toUpperCase() + n.substring(1),
  );

  String get _pascal2Camel => this[0].toLowerCase() + substring(1);

  String get camel2Snake =>
      isCamelCase ? _camel2Snake : throw Exception('Invalid camel case: $this');

  String get pascal2Camel => isPascalCase
      ? _pascal2Camel
      : throw Exception('Invalid pascal case: $this');

  String get camel2Pascal => isCamelCase
      ? this[0].toUpperCase() + substring(1)
      : throw Exception('Invalid camel case: $this');

  String get snake2Pascal => isSnakeCase
      ? _snake2Pascal
      : throw Exception('Invalid snake case: $this');

  String get snake2Camel => isSnakeCase
      ? _snake2Pascal._pascal2Camel
      : throw Exception('Invalid snake case: $this');

  String get pascal2Snake => isPascalCase
      ? _camel2Snake.substring(1)
      : throw Exception('Invalid pascal case: $this');
}
