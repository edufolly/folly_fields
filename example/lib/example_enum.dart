import 'dart:math';




enum ExampleEnum {
  first('Primeiro'),
  second('Segundo'),
  third('Terceiro'),
  other('Outro');

  final String value;




  const ExampleEnum(this.value);




  static ExampleEnum get defaultItem => ExampleEnum.other;




  static ExampleEnum fromJson(String? value) => values.firstWhere(
    (ExampleEnum e) => e.name == value,
    orElse: () => defaultItem,
  );




  static ExampleEnum get random =>
      values.elementAt(Random().nextInt(values.length));
}
