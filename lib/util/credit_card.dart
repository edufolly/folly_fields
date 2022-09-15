// ignore_for_file: always_specify_types

///
///
///
enum CreditCardType {
  visa,
  mastercard,
  amex,
  dinersclub,
  discover,
  jcb,
  unionpay,
  maestro,
  elo,
  mir,
  hiper,
  hipercard,
  unknown
}

///
///
///
class Range {
  final int initialValue;
  final int? finalValue;

  const Range(this.initialValue, [this.finalValue]);

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

    if (finalValue == null) {
      return ccInt == initialValue;
    } else {
      return ccInt >= initialValue && ccInt <= finalValue!;
    }
  }
}

///
///
///
class CreditCard {
  static const Map<CreditCardType, Set<Range>> patterns = {
    /// Visa
    CreditCardType.visa: {
      Range(4),
    },

    /// Mastercard
    CreditCardType.mastercard: {
      Range(51, 55),
      Range(2221, 2229),
      Range(223, 229),
      Range(23, 26),
      Range(270, 271),
      Range(2720),
    },

    /// American Express
    CreditCardType.amex: {
      Range(34),
      Range(37),
    },

    /// Diners Club
    CreditCardType.dinersclub: {
      Range(300, 305),
      Range(36),
      Range(38),
      Range(39),
    },

    /// Discover
    CreditCardType.discover: {
      Range(6011),
      Range(644, 649),
      Range(65),
    },

    /// JCB
    CreditCardType.jcb: {
      Range(2131),
      Range(1800),
      Range(3528, 3589),
    },

    /// UnionPay
    CreditCardType.unionpay: {
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

    /// Maestro
    CreditCardType.maestro: {
      Range(493698),
      Range(500000, 504174),
      Range(504176, 506698),
      Range(506779, 508999),
      Range(56, 59),
      Range(63),
      Range(67),
      Range(6),
    },

    /// Elo
    CreditCardType.elo: {
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

    /// Mir
    CreditCardType.mir: {
      Range(2200, 2204),
    },

    /// Hiper
    CreditCardType.hiper: {
      Range(637095),
      Range(63737423),
      Range(63743358),
      Range(637568),
      Range(637599),
      Range(637609),
      Range(637612),
    },

    /// Hipercard
    CreditCardType.hipercard: {
      Range(606282),
    }
  };

  ///
  ///
  ///
  static CreditCardType detectType(String ccNum) {
    ccNum = ccNum.replaceAll(r'\D', '');

    for (MapEntry<CreditCardType, Set<Range>> entry in patterns.entries) {
      for (Range range in entry.value) {
        if (range.isValid(ccNum)) {
          return entry.key;
        }
      }
    }

    return CreditCardType.unknown;
  }
}
