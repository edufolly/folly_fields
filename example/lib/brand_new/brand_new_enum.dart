///
///
///
enum BrandNewEnum {
  panel1,
  panel2,
  panel3;

  ///
  ///
  ///
  static BrandNewEnum get defaultItem => BrandNewEnum.panel1;

  ///
  ///
  ///
  static BrandNewEnum fromJson(String? value) => values.firstWhere(
        (BrandNewEnum e) => e.name == value,
        orElse: () => defaultItem,
      );

  ///
  ///
  ///
  static Map<BrandNewEnum, String> get items => values.asMap().map(
        (int key, BrandNewEnum value) =>
            MapEntry<BrandNewEnum, String>(value, value.name),
      );
}
