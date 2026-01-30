///
///
/// https://github.com/braintree/credit-card-type/blob/main/src/lib/card-types.ts
///
enum CreditCardType {
  /// Visa
  visa(
    brand: 'Visa',
    mask: '#### #### #### #### ###',
    lengths: <int>[16, 18, 19],
    code: CreditCardCode('CVV', <int>[3]),
    patterns: <Range>{Range(4)},
  ),

  /// Mastercard
  mastercard(
    brand: 'Master',
    mask: '#### #### #### ####',
    lengths: <int>[16],
    code: CreditCardCode('CVC', <int>[3]),
    patterns: <Range>{
      Range(51, 55),
      Range(2221, 2229),
      Range(223, 229),
      Range(23, 26),
      Range(270, 271),
      Range(2720),
    },
    extraBrands: <String>['mastercard'],
  ),

  /// American Express
  amex(
    brand: 'Amex',
    mask: '#### ###### #####',
    lengths: <int>[15],
    code: CreditCardCode('CID', <int>[4]),
    patterns: <Range>{Range(34), Range(37)},
    extraBrands: <String>['americanexpress'],
  ),

  /// Diners Club
  dinersclub(
    brand: 'Diners',
    mask: '#### ###### #########',
    lengths: <int>[14, 16, 19],
    code: CreditCardCode('CVV', <int>[3]),
    patterns: <Range>{Range(300, 305), Range(36), Range(38), Range(39)},
    extraBrands: <String>['dinersclub'],
  ),

  /// Discover
  discover(
    brand: 'Discover',
    mask: '#### #### #### #### ###',
    lengths: <int>[16, 19],
    code: CreditCardCode('CID', <int>[3]),
    patterns: <Range>{Range(6011), Range(644, 649), Range(65)},
  ),

  /// JCB
  jcb(
    brand: 'JCB',
    mask: '#### #### #### #### ###',
    lengths: <int>[16, 17, 18, 19],
    code: CreditCardCode('CVV', <int>[3]),
    patterns: <Range>{Range(2131), Range(1800), Range(3528, 3589)},
  ),

  /// UnionPay
  unionpay(
    brand: 'UnionPay',
    mask: '#### #### #### #### ###',
    lengths: <int>[14, 15, 16, 17, 18, 19],
    code: CreditCardCode('CVN', <int>[3]),
    patterns: <Range>{
      Range(620),
      Range(62100, 62182),
      Range(62184, 62187),
      Range(62185, 62197),
      Range(62200, 62205),
      Range(622010, 622999),
      Range(622018),
      Range(62207, 62209),
      Range(623, 626),
      Range(6270),
      Range(6272),
      Range(6276),
      Range(627700, 627779),
      Range(627781, 627799),
      Range(6282, 6289),
      Range(6291),
      Range(6292),
      Range(810),
      Range(8110, 8131),
      Range(8132, 8151),
      Range(8152, 8163),
      Range(8164, 8171),
    },
    checkLuhn: false,
  ),

  /// Maestro
  maestro(
    brand: 'Maestro',
    mask: '#### #### #### #### ###',
    lengths: <int>[12, 13, 14, 15, 16, 17, 18, 19],
    code: CreditCardCode('CVC', <int>[3]),
    patterns: <Range>{
      Range(493698),
      Range(500000, 504174),
      Range(504176, 506698),
      Range(506779, 508999),
      Range(56, 59),
      Range(63),
      Range(67),
      Range(6),
    },
  ),

  /// Elo
  elo(
    brand: 'Elo',
    mask: '#### #### #### ####',
    lengths: <int>[16],
    code: CreditCardCode('CVE', <int>[3]),
    patterns: <Range>{
      Range(401178),
      Range(401179),
      Range(438935),
      Range(457631),
      Range(457632),
      Range(431274),
      Range(451416),
      Range(457393),
      Range(504175),
      Range(506699, 506778),
      Range(509000, 509999),
      Range(627780),
      Range(636297),
      Range(636368),
      Range(650031, 650033),
      Range(650035, 650051),
      Range(650405, 650439),
      Range(650485, 650538),
      Range(650541, 650598),
      Range(650700, 650718),
      Range(650720, 650727),
      Range(650901, 650978),
      Range(651652, 651679),
      Range(655000, 655019),
      Range(655021, 655058),
    },
  ),

  /// Mir
  mir(
    brand: 'Mir',
    mask: '#### #### #### #### ###',
    lengths: <int>[16, 17, 18, 19],
    code: CreditCardCode('CVP2', <int>[3]),
    patterns: <Range>{Range(2200, 2204)},
  ),

  /// Hiper
  hiper(
    brand: 'Hiper',
    mask: '#### #### #### ####',
    lengths: <int>[16],
    code: CreditCardCode('CVC', <int>[3]),
    patterns: <Range>{
      Range(637095),
      Range(63737423),
      Range(63743358),
      Range(637568),
      Range(637599),
      Range(637609),
      Range(637612),
    },
  ),

  /// Hipercard
  hipercard(
    brand: 'Hipercard',
    mask: '#### #### #### ####',
    lengths: <int>[16],
    code: CreditCardCode('CVC', <int>[3]),
    patterns: <Range>{Range(606282)},
  ),

  /// Unknown
  unknown(
    brand: 'Unknown',
    mask: '#### #### #### #### ###',
    lengths: <int>[12, 13, 14, 15, 16, 17, 18, 19],
    code: CreditCardCode('CVV', <int>[3, 4]),
    patterns: <Range>{},
  );

  final String brand;
  final String mask;
  final List<int> lengths;
  final CreditCardCode code;
  final Set<Range> patterns;
  final bool checkLuhn;
  final List<String> extraBrands;

  const CreditCardType({
    required this.brand,
    required this.mask,
    required this.lengths,
    required this.code,
    required this.patterns,
    this.checkLuhn = true,
    this.extraBrands = const <String>[],
  });

  bool validLength(final String? ccNum) =>
      ccNum != null && lengths.contains(clearNum(ccNum).length);

  bool validNumber(final String? ccNum) {
    if (!checkLuhn) {
      return true;
    }

    if (ccNum == null || ccNum.length < 2) {
      return false;
    }

    String cNum = clearNum(ccNum);
    int mod = cNum.length % 2;
    int sum = 0;

    try {
      for (int pos = cNum.length - 1; pos >= 0; pos--) {
        int digit = int.parse(cNum[pos]);

        if (pos % 2 == mod) {
          digit *= 2;
          if (digit > 9) {
            digit -= 9;
          }
        }

        sum += digit;
      }

      return sum % 10 == 0;
    } on Exception {
      return false;
    }
  }

  bool cvvCheck(final String? cvv) =>
      cvv != null &&
      code.size.contains(cvv.length) &&
      code.size.contains(clearNum(cvv).length);

  static String clearNum(final String ccNum) =>
      ccNum.replaceAll(RegExp(r'\D'), '');

  static CreditCardType detectType(final String ccNum) {
    String cNum = clearNum(ccNum);

    for (final CreditCardType type in CreditCardType.values) {
      for (final Range range in type.patterns) {
        if (range.isValid(cNum)) {
          return type;
        }
      }
    }

    return CreditCardType.unknown;
  }

  // TODO(edufolly): Create a factory.
  static CreditCardType parse(final String? value) {
    return CreditCardType.values.firstWhere(
      (final CreditCardType type) {
        String? newValue = value?.replaceAll(RegExp(r'\s'), '').toLowerCase();

        return type.brand.toLowerCase() == newValue ||
            type.extraBrands.fold<bool>(
              false,
              (final bool previous, final String element) =>
                  previous || element.toLowerCase() == newValue,
            );
      },
      // Unknown card type
      orElse: () => CreditCardType.unknown,
    );
  }
}

class CreditCardCode {
  final String name;
  final List<int> size;

  const CreditCardCode(this.name, this.size);
}

class Range {
  final int initialValue;
  final int? finalValue;

  const Range(this.initialValue, [this.finalValue]);

  bool isValid(final String ccNum) {
    int qtd = initialValue.toString().length;

    if (ccNum.length < qtd) {
      return false;
    }

    int? ccInt = int.tryParse(ccNum.substring(0, qtd));

    if (ccInt == null) {
      return false;
    }

    return finalValue == null
        ? ccInt == initialValue
        : ccInt >= initialValue && ccInt <= finalValue!;
  }
}
