import 'package:folly_fields/crud/abstract_enum_parser.dart';

///
///
///
enum BrandNewEnum {
  panel1,
  panel2,
  panel3,
}

///
///
///
class BrandNewParser extends AbstractEnumParser<BrandNewEnum> {
  ///
  ///
  ///
  const BrandNewParser() : super(defaultItem: BrandNewEnum.panel1);

  ///
  ///
  ///
  @override
  Map<BrandNewEnum, String> get items => <BrandNewEnum, String>{
        BrandNewEnum.panel1: 'Painel 1',
        BrandNewEnum.panel2: 'Painel 2',
        BrandNewEnum.panel3: 'Painel 3',
      };
}
