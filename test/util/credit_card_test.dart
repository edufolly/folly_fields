import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folly_fields/util/credit_card_type.dart';
import 'package:http/http.dart';

void main() async {
  const int cardTest = 5;

  Map<String, CreditCardType> tests = <String, CreditCardType>{};

  Uri base = Uri.parse('https://www.invertexto.com/ajax/gerar-cartao.php');

  Map<String, CreditCardType> cardsRequest = <String, CreditCardType>{
    'mastercard': CreditCardType.mastercard,
    'visa16': CreditCardType.visa,
    'visa13': CreditCardType.visa,
    'amex': CreditCardType.amex,
    'diners': CreditCardType.dinersclub,
    'voyager': CreditCardType.unknown,
  };

  for (final MapEntry<String, CreditCardType> e in cardsRequest.entries) {
    try {
      for (int pos = 0; pos < cardTest; pos++) {
        Response response = await post(
          base,
          body: <String, String>{'bandeira': e.key},
        );

        Map<String, dynamic> data = jsonDecode(response.body);
        String? ccNum = data['numero'];

        if (ccNum != null) {
          ccNum = ccNum.trim();
          tests[ccNum] = e.value;
        }
      }
    } on Exception catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  group('Credit card detect type', () {
    for (final MapEntry<String, CreditCardType> e in tests.entries) {
      test(
        'Testing "${e.key}" for ${e.value}',
        () => expect(CreditCardType.detectType(e.key), e.value),
      );
    }
  });

  group('Credit card luhn check', () {
    for (final MapEntry<String, CreditCardType> e in tests.entries) {
      test(
        'Testing "${e.key}"',
        () => expect(e.value.validNumber(e.key), true),
      );
    }
  });

  Map<String, bool> cvvFailTests = <String, bool>{
    '': false,
    '  ': false,
    '   ': false,
    '    ': false,
    'A': false,
    'A ': false,
    'AA': false,
    'AA ': false,
    'AAA': false,
    'AAA ': false,
    'AAAA': false,
    'AAAA ': false,
    'AAAAA': false,
    'AAAAA ': false,
    '!': false,
    '! ': false,
    '!!': false,
    '!! ': false,
    '!!!': false,
    '!!! ': false,
    '!!!!': false,
    '!!!! ': false,
    '!!!!!': false,
    '!!!!! ': false,
    '1': false,
    '1 ': false,
    '11': false,
    '11 ': false,
    '1111 ': false,
    '11111': false,
    '*': false,
    '**': false,
    '** ': false,
    ' * ': false,
    ' **': false,
    ' * *': false,
  };

  Map<String, bool> cvvMasterTests = <String, bool>{
    ...cvvFailTests,
    '111 ': false,
    '234': true,
    '2345': false,
  };

  group('Credit card CVV check for Mastercard', () {
    for (final MapEntry<String, bool>(:String key, :bool value)
        in cvvMasterTests.entries) {
      test(
        'Testing "$key"',
        () => expect(CreditCardType.mastercard.cvvCheck(key), value),
      );
    }
  });

  Map<String, bool> cvvAmexTests = <String, bool>{
    ...cvvFailTests,
    '111 ': false,
    '234': false,
    '2345': true,
  };

  group('Credit card CVV check for American Express', () {
    for (final MapEntry<String, bool> e in cvvAmexTests.entries) {
      test(
        'Testing "${e.key}"',
        () => expect(CreditCardType.amex.cvvCheck(e.key), e.value),
      );
    }
  });

  Map<String, bool> cvvUnknownTests = <String, bool>{
    ...cvvFailTests,
    '111 ': true,
    '234': true,
    '2345': true,
  };

  group('Credit card CVV check for Unknown', () {
    for (final MapEntry<String, bool> e in cvvUnknownTests.entries) {
      test(
        'Testing "${e.key}"',
        () => expect(CreditCardType.unknown.cvvCheck(e.key), e.value),
      );
    }
  });

  Map<String?, CreditCardType> typeTests = <String?, CreditCardType>{
    null: CreditCardType.unknown,
    '': CreditCardType.unknown,
    ' ': CreditCardType.unknown,
    'unknown': CreditCardType.unknown,
    'a': CreditCardType.unknown,
    '1': CreditCardType.unknown,
    'Mastercard': CreditCardType.mastercard,
    'mastercard': CreditCardType.mastercard,
    'MASTERCARD': CreditCardType.mastercard,
    'Master card': CreditCardType.mastercard,
    'Master Card': CreditCardType.mastercard,
    'master card': CreditCardType.mastercard,
    'MASTER CARD': CreditCardType.mastercard,
    'master': CreditCardType.mastercard,
    ' master ': CreditCardType.mastercard,
    ' master': CreditCardType.mastercard,
    'master ': CreditCardType.mastercard,
    'Master': CreditCardType.mastercard,
    'MASTER': CreditCardType.mastercard,
    'M4ST3R': CreditCardType.unknown,
    'visa': CreditCardType.visa,
    'VISA': CreditCardType.visa,
    'Visa': CreditCardType.visa,
    'V1S4': CreditCardType.unknown,
    'Amex': CreditCardType.amex,
    'amex': CreditCardType.amex,
    'AMEX': CreditCardType.amex,
    'American Express': CreditCardType.amex,
    'American express': CreditCardType.amex,
    'american express': CreditCardType.amex,
    'AmericanExpress': CreditCardType.amex,
    'Americanexpress': CreditCardType.amex,
    'americanexpress': CreditCardType.amex,
    'americanExpress': CreditCardType.amex,
    '4M3X': CreditCardType.unknown,
    'Diners': CreditCardType.dinersclub,
    'diners': CreditCardType.dinersclub,
    'DINERS': CreditCardType.dinersclub,
    'Diners Club': CreditCardType.dinersclub,
    'Diners club': CreditCardType.dinersclub,
    'diners club': CreditCardType.dinersclub,
    'DinersClub': CreditCardType.dinersclub,
    'Dinersclub': CreditCardType.dinersclub,
    'dinersclub': CreditCardType.dinersclub,
    'discover': CreditCardType.discover,
    'Discover': CreditCardType.discover,
    'DISCOVER': CreditCardType.discover,
    'd1sc0v3r': CreditCardType.unknown,
    'jcb': CreditCardType.jcb,
    'Jcb': CreditCardType.jcb,
    'jCb': CreditCardType.jcb,
    'jcB': CreditCardType.jcb,
    'JCb': CreditCardType.jcb,
    'jCB': CreditCardType.jcb,
    'JCB': CreditCardType.jcb,
    'unionpay': CreditCardType.unionpay,
    'UnionPay': CreditCardType.unionpay,
    'UNIONPAY': CreditCardType.unionpay,
    'maestro': CreditCardType.maestro,
    'Maestro': CreditCardType.maestro,
    'MAESTRO': CreditCardType.maestro,
    'elo': CreditCardType.elo,
    'Elo': CreditCardType.elo,
    'eLo': CreditCardType.elo,
    'elO': CreditCardType.elo,
    'ELo': CreditCardType.elo,
    'eLO': CreditCardType.elo,
    'ELO': CreditCardType.elo,
    'mir': CreditCardType.mir,
    'Mir': CreditCardType.mir,
    'mIr': CreditCardType.mir,
    'miR': CreditCardType.mir,
    'MIr': CreditCardType.mir,
    'mIR': CreditCardType.mir,
    'MIR': CreditCardType.mir,
    'hiper': CreditCardType.hiper,
    'Hiper': CreditCardType.hiper,
    'HIPER': CreditCardType.hiper,
    'hipercard': CreditCardType.hipercard,
    'Hipercard': CreditCardType.hipercard,
    'HIPERCARD': CreditCardType.hipercard,
  };

  group('Credit card type parse check', () {
    for (final MapEntry<String?, CreditCardType> e in typeTests.entries) {
      test(
        'Testing "${e.key}"',
        () => expect(CreditCardType.parse(e.key), e.value),
      );
    }
  });
}
