import 'package:folly_fields/crud/abstract_enum_parser.dart';

///
///
///
enum ExampleEnum {
  first,
  second,
  third,
  other,
}

///
///
///
class ExampleEnumParser extends AbstractEnumParser<ExampleEnum> {
  ///
  ///
  ///
  const ExampleEnumParser(): super(defaultItem: ExampleEnum.other);

  ///
  ///
  ///
  @override
  Map<ExampleEnum, String> get items => <ExampleEnum, String>{
        ExampleEnum.first: 'Primeiro',
        ExampleEnum.second: 'Segundo',
        ExampleEnum.third: 'Terceiro',
        ExampleEnum.other: 'Outro',
      };
}
