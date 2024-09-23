// ignore_for_file: always_specify_types

///
///
/// https://github.com/braintree/credit-card-type/blob/main/src/lib/card-types.ts
///
enum CreditCardType {
  /// Visa
  visa(
    brand: 'Visa',
    mask: '#### #### #### #### ###',
    lengths: [16, 18, 19],
    code: CreditCardCode('CVV', [3]),
    patterns: {
      CreditCardRange(4),
    },
  ),

  /// Mastercard
  mastercard(
    brand: 'Master',
    mask: '#### #### #### ####',
    lengths: [16],
    code: CreditCardCode('CVC', [3]),
    patterns: {
      CreditCardRange(51, 55),
      CreditCardRange(2221, 2229),
      CreditCardRange(223, 229),
      CreditCardRange(23, 26),
      CreditCardRange(270, 271),
      CreditCardRange(2720),
    },
    extraBrands: ['mastercard'],
  ),

  /// American Express
  amex(
    brand: 'Amex',
    mask: '#### ###### #####',
    lengths: [15],
    code: CreditCardCode('CID', [4]),
    patterns: {
      CreditCardRange(34),
      CreditCardRange(37),
    },
    extraBrands: ['americanexpress'],
  ),

  /// Diners Club
  dinersclub(
    brand: 'Diners',
    mask: '#### ###### #########',
    lengths: [14, 16, 19],
    code: CreditCardCode('CVV', [3]),
    patterns: {
      CreditCardRange(300, 305),
      CreditCardRange(36),
      CreditCardRange(38),
      CreditCardRange(39),
    },
    extraBrands: ['dinersclub'],
  ),

  /// Discover
  discover(
    brand: 'Discover',
    mask: '#### #### #### #### ###',
    lengths: [16, 19],
    code: CreditCardCode('CID', [3]),
    patterns: {
      CreditCardRange(6011),
      CreditCardRange(644, 649),
      CreditCardRange(65),
    },
  ),

  /// JCB
  jcb(
    brand: 'JCB',
    mask: '#### #### #### #### ###',
    lengths: [16, 17, 18, 19],
    code: CreditCardCode('CVV', [3]),
    patterns: {
      CreditCardRange(2131),
      CreditCardRange(1800),
      CreditCardRange(3528, 3589),
    },
  ),

  /// UnionPay
  unionpay(
    brand: 'UnionPay',
    mask: '#### #### #### #### ###',
    lengths: [14, 15, 16, 17, 18, 19],
    code: CreditCardCode('CVN', [3]),
    patterns: {
      CreditCardRange(620),
      CreditCardRange(62100, 62182),
      CreditCardRange(62184, 62187),
      CreditCardRange(62185, 62197),
      CreditCardRange(62200, 62205),
      CreditCardRange(622010, 622999),
      CreditCardRange(622018),
      CreditCardRange(62207, 62209),
      CreditCardRange(623, 626),
      CreditCardRange(6270),
      CreditCardRange(6272),
      CreditCardRange(6276),
      CreditCardRange(627700, 627779),
      CreditCardRange(627781, 627799),
      CreditCardRange(6282, 6289),
      CreditCardRange(6291),
      CreditCardRange(6292),
      CreditCardRange(810),
      CreditCardRange(8110, 8131),
      CreditCardRange(8132, 8151),
      CreditCardRange(8152, 8163),
      CreditCardRange(8164, 8171),
    },
    checkLuhn: false,
  ),

  /// Maestro
  maestro(
    brand: 'Maestro',
    mask: '#### #### #### #### ###',
    lengths: [12, 13, 14, 15, 16, 17, 18, 19],
    code: CreditCardCode('CVC', [3]),
    patterns: {
      CreditCardRange(493698),
      CreditCardRange(500000, 504174),
      CreditCardRange(504176, 506698),
      CreditCardRange(506779, 508999),
      CreditCardRange(56, 59),
      CreditCardRange(63),
      CreditCardRange(67),
      CreditCardRange(6),
    },
  ),

  /// Elo
  elo(
    brand: 'Elo',
    mask: '#### #### #### ####',
    lengths: [16],
    code: CreditCardCode('CVE', [3]),
    patterns: {
      CreditCardRange(401178),
      CreditCardRange(401179),
      CreditCardRange(438935),
      CreditCardRange(457631),
      CreditCardRange(457632),
      CreditCardRange(431274),
      CreditCardRange(451416),
      CreditCardRange(457393),
      CreditCardRange(504175),
      CreditCardRange(506699, 506778),
      CreditCardRange(509000, 509999),
      CreditCardRange(627780),
      CreditCardRange(636297),
      CreditCardRange(636368),
      CreditCardRange(650031, 650033),
      CreditCardRange(650035, 650051),
      CreditCardRange(650405, 650439),
      CreditCardRange(650485, 650538),
      CreditCardRange(650541, 650598),
      CreditCardRange(650700, 650718),
      CreditCardRange(650720, 650727),
      CreditCardRange(650901, 650978),
      CreditCardRange(651652, 651679),
      CreditCardRange(655000, 655019),
      CreditCardRange(655021, 655058),
    },
  ),

  /// Mir
  mir(
    brand: 'Mir',
    mask: '#### #### #### #### ###',
    lengths: [16, 17, 18, 19],
    code: CreditCardCode('CVP2', [3]),
    patterns: {
      CreditCardRange(2200, 2204),
    },
  ),

  /// Hiper
  hiper(
    brand: 'Hiper',
    mask: '#### #### #### ####',
    lengths: [16],
    code: CreditCardCode('CVC', [3]),
    patterns: {
      CreditCardRange(637095),
      CreditCardRange(63737423),
      CreditCardRange(63743358),
      CreditCardRange(637568),
      CreditCardRange(637599),
      CreditCardRange(637609),
      CreditCardRange(637612),
    },
  ),

  /// Hipercard
  hipercard(
    brand: 'Hipercard',
    mask: '#### #### #### ####',
    lengths: [16],
    code: CreditCardCode('CVC', [3]),
    patterns: {
      CreditCardRange(606282),
    },
  ),

  /// Unknown
  unknown(
    brand: 'Unknown',
    mask: '#### #### #### #### ###',
    lengths: [12, 13, 14, 15, 16, 17, 18, 19],
    code: CreditCardCode('CVV', [3, 4]),
    patterns: {},
  );

  ///
  ///
  ///
  final String brand;
  final String mask;
  final List<int> lengths;
  final CreditCardCode code;
  final Set<CreditCardRange> patterns;
  final bool checkLuhn;
  final List<String> extraBrands;

  ///
  ///
  ///
  const CreditCardType({
    required this.brand,
    required this.mask,
    required this.lengths,
    required this.code,
    required this.patterns,
    this.checkLuhn = true,
    this.extraBrands = const <String>[],
  });

  ///
  ///
  ///
  bool validLength(String ccNum) => lengths.contains(clearNum(ccNum).length);

  ///
  ///
  ///
  bool validNumber(String ccNum) {
    if (!checkLuhn) {
      return true;
    }

    if (ccNum.length < 2) {
      return false;
    }

    String cNum = ccNum.replaceAll(RegExp(r'\D'), '');
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

  ///
  ///
  ///
  bool cvvCheck(String cvv) =>
      code.size.contains(cvv.length) &&
      code.size.contains(clearNum(cvv).length);

  ///
  ///
  ///
  static String clearNum(String ccNum) => ccNum.replaceAll(RegExp(r'\D'), '');

  ///
  ///
  ///
  static CreditCardType detectType(String ccNum) {
    String cNum = clearNum(ccNum);

    for (final CreditCardType type in CreditCardType.values) {
      for (final CreditCardRange range in type.patterns) {
        if (range.isValid(cNum)) {
          return type;
        }
      }
    }

    return CreditCardType.unknown;
  }

  ///
  ///
  ///
  static CreditCardType parse(String? value) =>
      CreditCardType.values.firstWhere(
        (CreditCardType type) {
          String? newValue = value?.replaceAll(RegExp(r'\s'), '').toLowerCase();

          return type.brand.toLowerCase() == newValue ||
              type.extraBrands.fold<bool>(
                false,
                (bool previous, String element) =>
                    previous || element.toLowerCase() == newValue,
              );
        },
        orElse: () => CreditCardType.unknown,
      );
}

///
///
///
class CreditCardCode {
  final String name;
  final List<int> size;

  ///
  ///
  ///
  const CreditCardCode(this.name, this.size);
}

///
///
///
class CreditCardRange {
  final int initialValue;
  final int? finalValue;

  const CreditCardRange(this.initialValue, [this.finalValue]);

  ///
  ///
  ///
  bool isValid(String ccNum) {
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
